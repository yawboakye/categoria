# typed: strict
# frozen_string_literal: true

require_relative "helpers"

module Categoria
  module Generators
    class CommandGenerator < ::Rails::Generators::NamedBase
      extend T::Sig

      include Helpers

      Component = Types::Component

      def generate_command_class
        in_root do
          component_path = domain_component_path(domain, Component::Command)
          class_path = File.join(component_path, "#{component}.rb")

          create_file class_path, <<~COMMAND
            # frozen_string_literal

            module #{root_module}
              module #{domain_module}
                module Command
                  class #{class_name}
                    def self.invoke(arg0); end
                  end
                end
              end
            end
          COMMAND
        end
      end

      sig { returns(String) }
      def class_name = component.classify
    end
  end
end
