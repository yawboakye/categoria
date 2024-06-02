# typed: strict
# frozen_string_literal: true

module Categoria
  module Generators
    class DomainGenerator < ::Rails::Generators::NamedBase
      extend T::Sig

      source_root File.expand_path("templates", __dir__)

      def module_name = file_name.capitalize

      sig { void }
      def setup_new_domain
        domain_directory_path = "#{Rails.root}/app/lib/#{file_name}"
        %w[
          internal/commands
          internal/models
          command
          data
        ].each do |component_path|
          full_component_path = "#{domain_directory_path}/#{component_path}"

          empty_directory full_component_path
          create_file "#{full_component_path}/.keep"
        end

        create_file "#{domain_directory_path}/description.yml"
        template \
          "domain_module.rb.erb",
          "#{domain_directory_path}.rb"
      end
    end
  end
end
