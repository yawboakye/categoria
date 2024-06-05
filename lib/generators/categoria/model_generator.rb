# typed: strict
# frozen_string_literal: true

require "rails/generators"
require "rails/generators/active_record"
require "rails/generators/model_helpers"
require "rails/generators/migration"
require "active_record"

module Categoria
  module Generators
    # `ModelGenerator` is almost an exact copy of the ActiveRecord
    # model generator. significant departures are as follows:
    #   - migrations cannot be skipped since a model should be an ORM class.
    #   - models are not in `app/models` but instead internal to domain.
    class ModelGenerator < ::Rails::Generators::NamedBase
      include ::Rails::Generators::ModelHelpers
      include ::Rails::Generators::Migration

      source_root File.expand_path("templates", __dir__)

      argument \
        :attributes,
        type: :array,
        default: [],
        banner: %(field[:type][:index] field[:type][:index])

      sig { void }
      def create_migration_file
        debugger

        migration_template(
          "model_migration.rb.erb",
          "db/migrate/create_#{relation_name}_table.rb",
          migration_version:
        )
      end

      sig { returns(String) }
      def migration_version = "[#{ActiveRecord::VERSION::MAJOR}.#{ActiveRecord::VERSION::MINOR}]"

      sig { void }
      def generate_internal_model; end

      sig { returns(String) }
      private def domain_name
        @domain_name ||= T.let(
          T.must(name.split(/:/)[0]),
          T.nilable(String)
        )
      end

      sig { returns(String) }
      private def internal_model_name
        @internal_model_name ||= T.let(
          T.must(name.split(/:/)[1]),
          T.nilable(String)
        )
      end

      sig { returns(String) }
      private def relation_name = %(#{domain_name}_#{internal_model_name.pluralize})

      sig { params(dirname: String).returns(String) }
      def self.next_migration_number(dirname)
        ActiveRecord::Generators::Base.next_migration_number(dirname)
      end
    end
  end
end
