# typed: strict
# frozen_string_literal: true

module Categoria
  module Generators
    module Helpers
      extend T::Sig

      Component = Types::Component

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

      sig { params(domain: String, component: Types::Component).returns(String) }
      def domain_component_path(domain, component)
        domain_path = domain_path_in_root(domain)

        case component
        when Component::Command then %(#{domain_path}/command)
        when Component::Model   then %(#{domain_path}/internal/models)
        when Component::Data    then %(#{domain_path}/data)
        else T.absurd(component)
        end
      end

      sig { params(domain: String).returns(String) }
      def domain_path_in_root(domain) = %(app/lib/#{domain})
    end
  end
end
