# typed: strict
# frozen_string_literal: true

module Categoria
  module Generators
    class DomainGenerator < ::Rails::Generators::NamedBase
      extend T::Sig

      source_root File.expand_path("templates", __dir__)

      sig { returns(String) }
      def module_name = file_name.capitalize

      sig { void }
      def setup_new_domain
        domain_directory_path = "app/lib/#{file_name}"

        in_root do
          %w[
            internal/commands
            internal/models
            command
            data
          ].each do |component_path|
            create_empty_directory_with_keep_file \
              at: "#{domain_directory_path}/#{component_path}"
          end

          create_file "#{domain_directory_path}/description.yml"
        end

        template \
          "domain_module.rb.erb",
          "#{domain_directory_path}.rb"
      end

      sig { params(at: String).void }
      private def create_empty_directory_with_keep_file(at:)
        empty_directory at
        create_file "#{at}/.keep"
      end
    end
  end
end
