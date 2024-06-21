# typed: strict
# frozen_string_literal: true

module Categoria
  module Generators
    class InitializerGenerator < ::Rails::Generators::Base
      extend T::Sig

      sig { void }
      def create_categoria_initializer_file
        in_root do
          create_file "config/initializers/categoria.rb", <<~INITIALIZER
            # frozen_string_literal: true

            Rails.autoloaders.main.push_dir(
              "\#{Rails.root}/app/lib",
              namespace: Rails.application.class.module_parent
            )
          INITIALIZER
        end
      end
    end
  end
end
