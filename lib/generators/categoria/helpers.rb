# typed: strict
# frozen_string_literal: true

module Categoria
  module Generators
    module Helpers
      extend T::Sig

      sig { returns(String) }
      def domain_module = domain_name.capitalize

      sig { returns(String) }
      def domain_prefix = domain_name.singularize

      sig { returns(String) }
      def domain_name
        @domain_name ||= T.let(
          T.must(name.split(/:/)[0]),
          T.nilable(String)
        )
      end
    end
  end
end
