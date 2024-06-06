# typed: strict
# frozen_string_literal: true

require "rails/generators"
require "rails/generators/active_record"
require "rails/generators/active_record/migration"
require "rails/generators/model_helpers"
require "rails/generators/migration"
require "active_support/inflector"
require "active_record"

module Categoria
  module Generators
    # `ModelGenerator` is almost an exact copy of the ActiveRecord
    # model generator. significant departures are as follows:
    #   - migrations cannot be skipped since a model should be an orm class,
    #     otherwise a data class is what you need. a data class typically
    #     serializes one or more model records into a form that is publicized.
    #     they are allowed to perform all sorts of key & value transformations
    #     for purposes of data interchange format and/or
    #     security-by-obscurity.
    #   - models are not in `app/models` but instead internal to domain.
    class ModelGenerator < ::Rails::Generators::NamedBase
      desc <<~DOC.squish
      DOC

      include ::Rails::Generators::ModelHelpers
      include ::Rails::Generators::Migration
      include ::ActiveRecord::Generators::Migration

      source_root File.expand_path("templates", __dir__)

      argument \
        :attributes,
        type: :array,
        default: [],
        banner: %(field[:type][:index] field[:type][:index])

      sig { void }
      def create_migration_file
        migration_template(
          "model_migration.rb.erb",
          File.join(db_migrate_path, "create_#{domain_prefixed_relation_name}_table.rb"),
          migration_version:
        )
      end

      sig { returns(String) }
      def migration_version = "[#{ActiveRecord::VERSION::MAJOR}.#{ActiveRecord::VERSION::MINOR}]"

      sig { void }
      def generate_internal_model
        in_root do
          template \
            "model.rb.erb",
            "app/lib/#{domain_name}/internal/models/#{internal_model_name}.rb"
        end
      end

      sig { returns(String) }
      def domain_module = domain_name.capitalize

      sig { returns(String) }
      def internal_model_class_name = ActiveSupport::Inflector.classify(internal_model_name)

      sig { returns(String) }
      def domain_name
        @domain_name ||= T.let(
          T.must(name.split(/:/)[0]),
          T.nilable(String)
        )
      end

      sig { returns(String) }
      def internal_model_name
        @internal_model_name ||= T.let(
          T.must(name.split(/:/)[1]),
          T.nilable(String)
        )
      end

      sig { returns(String) }
      def domain_prefixed_relation_name = %(#{domain_name.singularize}_#{internal_model_name.pluralize})

      sig { returns(T::Array[String]) }
      def attributes_with_index = attributes.select { !_1.reference? && _1.has_index? }

      sig { params(dirname: String).returns(String) }
      def self.next_migration_number(dirname)
        ActiveRecord::Generators::Base.next_migration_number(dirname)
      end
    end
  end
end
