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
          # turns out that in order to cleanly undo the changes
          # introduced by the generator, we should make a few of
          # the actions more explicit, and independent, like the
          # creation of the domain directory itself.
          empty_directory domain_dir

          %w[
            internal/commands
            internal/models
            command
            data
          ].each do |component_path|
            create_empty_directory_with_keep_file \
              at: domain_dir.join(component_path)
          end

          template \
            "domain_description.yml.erb",
            domain_dir.join("description.yml")
          create_file domain_dir.join("README.md"), <<~README
            # About #{module_name}

            Describe the domain. You may provide usage guide for your public interfaces (commands).
            Feel free to describe explicitly what may be implicit (e.g. triggered jobs, emitted
            events, sent emails, etc).
          README
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
