# typed: strict
# frozen_string_literal: true

module Categoria
  module Generators
    class DataGenerator < ::Rails::Generators::NamedBase
      extend T::Sig

      source_root File.expand_path("templates", __dir__)
    end
  end
end
