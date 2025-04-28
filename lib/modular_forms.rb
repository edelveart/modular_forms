# frozen_string_literal: true

require_relative './modular_forms/eisenstein_series'
require_relative './modular_forms/dedekind_eta_functions'
require_relative './modular_forms/ramanujan_tau_function'
require_relative './modular_forms/theta_functions'
require_relative './modular_forms/klein_j_invariant'
require_relative './modular_forms/hecke_operators'
require_relative './modular_forms/sl2z_groups'

# ModularForms
#
# This module provides tools for working with modular forms, complex, analytic functions invariant
# under the action of a modular group, with deep connections to number theory.
# It enables the calculation of coefficients and is well-suited for applications in Sonic Pi,
# particularly for algorithmic music composition and live coding.
module ModularForms
  module_function

  def eisenstein_serie(weight_k, gal_f = nil)
    EisensteinSeries.eisenstein_series(weight_k, gal_f)
  end

  def eisenstein_series_product(weight_k1, weight_k2, precision)
    EisensteinSeries.eisenstein_series_product(weight_k1, weight_k2, precision)
  end

  def eisenstein_serie_power(weight_k, power, precision)
    EisensteinSeries.eisenstein_serie_power(weight_k, power, precision)
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

  def jacobi_theta_function(jacobi_index = 3, square_coefs = false) # rubocop:disable Style/OptionalBooleanParameter
    ThetaFunctions.jacobi_theta_function(jacobi_index, square_coefs)
  end

  def jacobi_theta_power(jacobi_index, power, precision)
    ThetaFunctions.jacobi_theta_function_power(jacobi_index, power, precision)
  end

  def j_invariant(precision)
    KleinJInvariant.modular_j_function(precision)
  end

  def hecke_operator_prime_non_cusp(non_cusp_form_arr, prime, weight_k, precision)
    HeckeOperators.hecke_prime_non_cusp(non_cusp_form_arr, prime, weight_k, precision)
  end

  def hecke_operator_prime_cusp(cusp_form_arr, prime, weight_k, precision)
    HeckeOperators.hecke_prime_cusp(cusp_form_arr, prime, weight_k, precision)
  end

  def gamma0_index(n)
    SL2Zgroups.index_gamma0(n)
  end

  def t_gen_matrix(n_power)
    SL2Zgroups.t_matrix(n_power)
  end

  def s_gen_matrix(n_power)
    SL2Zgroups.s_matrix(n_power)
  end

  def u_gen_matrix(mod_n)
    SL2Zgroups.u_matrix(mod_n)
  end

  def st_gen_matrix(n_power)
    SL2Zgroups.st_matrix(n_power)
  end
end
