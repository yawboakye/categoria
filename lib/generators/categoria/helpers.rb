# typed: strict
# frozen_string_literal: true

require "active_support/inflector"

module Categoria
  module Generators
    module Helpers
      extend T::Sig

      Component = Types::Component

      sig { returns(String) }
      def root_module = Rails.application.class.module_parent.name

      sig { returns(String) }
      def domain_module = domain.capitalize

      sig { returns(String) }
      def domain_prefix = domain.singularize

      def class_name = ActiveSupport::Inflector.classify(component)

      sig { returns(String) }
      def domain
        @domain ||= T.let(
          T.must(domain_and_component[0]),
          T.nilable(String)
        )
      end

      def component
        @component ||= T.let(
          T.must(domain_and_component[1]),
          T.nilable(String)
        )
      end

      sig { returns([String, String]) }
      def domain_and_component
        @domain_and_component ||= T.let(
          T.must(name.split(/:/)[..1]),
          [String, String]
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
