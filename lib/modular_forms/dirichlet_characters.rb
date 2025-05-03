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
  end
end
