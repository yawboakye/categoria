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
        domain_dir = Pathname.new("app/lib/#{file_name}")

        in_root do
          %w[
            internal/commands
            internal/models
            command
            data
          ].each do |component_path|
            create_empty_directory_with_keep_file \
              at: domain_dir.join(component_path)
          end

          create_file domain_dir.join("description.yml")
        end

        template \
          "domain_module.rb.erb",
          "#{domain_dir}.rb"
      end

      sig { params(at: Pathname).void }
      private def create_empty_directory_with_keep_file(at:)
        empty_directory at
        create_file at.join(".keep")
      end
    end
  end
end
