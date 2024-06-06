# typed: strict
# frozen_string_literal: true

module Categoria
  module Generators
    class DataGenerator < ::Rails::Generators::NamedBase
      extend T::Sig

      source_root File.expand_path("templates", __dir__)

      desc <<~DOC.squish
        generates a data class for the domain. data classes are used
        like value classes: hashes are more fit for the purpose except
        that in the wild hashes are difficult to tame.
      DOC
    end
  end
end
