# typed: false
# frozen_string_literal: true

module Categoria
  module Types
    extend T::Sig

    class Component < T::Enum
      enums do
        Command = new("command")
        Model   = new("model")
        Data    = new("data")
      end
    end
  end
end
