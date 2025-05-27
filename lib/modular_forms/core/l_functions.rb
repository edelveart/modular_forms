# frozen_string_literal: true

module ModularForms
  module Core
    # ModularForms::Core::LFunctions
    #
    # The LFunctions module provides methods related to L-functions,
    # particularly those associated with modular forms and elliptic curves.
    module LFunctions
      def self.a_p(p, cardinality)
        p + 1 - cardinality
      end
    end
  end
end
