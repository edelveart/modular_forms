# frozen_string_literal: true

require_relative './modular_forms/eisenstein_series'
require_relative './modular_forms/dedekind_eta_functions'
require_relative './modular_forms/ramanujan_tau_function'

# ModularForms
#
# This module provides tools for working with modular forms, complex, analytic functions invariant
# under the action of a modular group, with deep connections to number theory. It enables the calculation
# of coefficients and is well-suited for applications in Sonic Pi, particularly for algorithmic music composition
# and live coding.
module ModularForms
  module_function

  def eisenstein_serie(weight_k, gal_f = nil)
    EisensteinSeries.eisenstein_series(weight_k, gal_f)
  end

  def eisenstein_series_product(weight_k1, weight_k2, precision)
    EisensteinSeries.eisenstein_series_product(weight_k1, weight_k2, precision)
  end

  def dedekind_eta_function(pentagonal_coefs = false) # rubocop:disable Style/OptionalBooleanParameter
    DedekindEtaFunctions.eta_function(pentagonal_coefs)
  end

  def dedekind_eta_power(power, precision)
    DedekindEtaFunctions.eta_function_power(power, precision)
  end

  def ramanujan_tau_function
    RamanujanTauFunction.niebur_sigma_formula
  end
end
