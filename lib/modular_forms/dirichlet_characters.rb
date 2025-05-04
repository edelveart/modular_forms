# frozen_string_literal: true

require_relative '../../lib/numeric_helpers/numeric_helpers'

module ModularForms
  # ModularForms::DirichletCharacters
  #
  # This module provides generators for Dirichlet characters and related topics.
  module DirichletCharacters
    def self.dirichlet_trivchar(modq, a) # rubocop:disable Naming/MethodParameterName
      NumericHelpers.gcd(a, modq) == 1 ? 1 : 0
    end

    def self.conrey_p_pminus1(modp, a) # rubocop:disable Naming/MethodParameterName
      raise "#{modp} must be a prime number" if !NumericHelpers.prime_number?(modp) # rubocop:disable Style/NegatedIf
      return 0 if a % modp == 0 # rubocop:disable Style/NumericPredicate
      return 1 if NumericHelpers.euler_criterion(a, modp)

      -1 if !NumericHelpers.euler_criterion(a, modp) # rubocop:disable Style/NegatedIf
    end
  end
end
