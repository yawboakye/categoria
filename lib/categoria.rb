# typed: strict
# frozen_string_literal: true

require "zeitwerk"
require "sorbet-runtime"

loader = Zeitwerk::Loader.for_gem
loader.ignore("#{__dir__}/generators")
loader.setup

module Categoria
  extend T::Sig
end
