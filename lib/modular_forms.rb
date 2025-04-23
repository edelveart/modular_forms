# frozen_string_literal: true

require_relative './modular_forms/eisenstein_series'
require_relative './modular_forms/dedekind_eta_functions'

# ModularForms
#
# This module provides tools for working with modular forms, complex, analytic functions invariant
# under the action of a modular group, with deep connections to number theory. It enables the calculation
# of coefficients and is well-suited for applications in Sonic Pi, particularly for algorithmic music composition
# and live coding.
module ModularForms
  module_function

  def eisenstein_series(weight_k, gal_f = nil)
    EisensteinSeries.eisenstein_modular_form(weight_k, gal_f)
  end

  def dedekind_eta_function(pentagonal_coefs = false) # rubocop:disable Style/OptionalBooleanParameter
    DedekindEtaFunctions.eta_function(pentagonal_coefs)
  end
end
