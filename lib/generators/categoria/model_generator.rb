# typed: strict
# frozen_string_literal: true

require "rails/generators"
require "rails/generators/model_helpers"

module Categoria
  module Generators
    class ModelGenerator < ::Rails::Generators::NamedBase
      include ::Rails::Generators::ModelHelpers

      def generate_internal_model; end
    end
  end
end
