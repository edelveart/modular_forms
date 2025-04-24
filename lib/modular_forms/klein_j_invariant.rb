# frozen_string_literal: true

require_relative '../numeric_helpers/numeric_helpers'
require_relative 'eisenstein_series'
require_relative 'dedekind_eta_functions'

module ModularForms
  # ModularForms::KleinJInvariant
  #
  # This module provides a generator for j function.
  module KleinJInvariant
    def self.modular_j_function(precision)
      e4_cubed = EisensteinSeries.eisenstein_serie_power(4, 3, precision + 1)
      delta_discriminant = DedekindEtaFunctions.eta_function_power(24, precision + 1)
      NumericHelpers.quotient_of_series(e4_cubed, delta_discriminant, precision)
    end
  end
end
