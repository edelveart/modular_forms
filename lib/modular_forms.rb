# frozen_string_literal: true

require_relative './modular_forms/core'

# ModularForms
#
# This module provides tools for modular forms, elliptic curves, SL_2(Z) matrices, and Dirichlet characters.
# It is well-suited for applications in Sonic Pi, particularly for algorithmic music composition and live coding.
module ModularForms # rubocop:disable Metrics/ModuleLength
  module_function

  def eisenstein_serie(weight_k, gal_f = nil)
    Core::EisensteinSeries.eisenstein_series(weight_k, gal_f)
  end

  def eisenstein_series_product(weight_k1, weight_k2, prec)
    Core::EisensteinSeries.eisenstein_series_product(weight_k1, weight_k2, prec)
  end

  def eisenstein_serie_power(weight_k, power, prec)
    Core::EisensteinSeries.eisenstein_serie_power(weight_k, power, prec)
  end

  def dedekind_eta_function(m_scale = 1, pentagonal_coefs = false) # rubocop:disable Style/OptionalBooleanParameter
    Core::DedekindEtaFunctions.eta_function(m_scale, pentagonal_coefs)
  end

  def dedekind_eta_pow(power, prec, m_scale = 1)
    Core::DedekindEtaFunctions.eta_function_pow(power, prec, m_scale)
  end

  def dedekind_sum(h, k) # rubocop:disable Naming/MethodParameterName
    Core::DedekindEtaFunctions.dedekind_sum(h, k)
  end

  def ramanujan_tau_function
    Core::RamanujanTauFunction.niebur_sigma_formula
  end

  def jacobi_theta_function(jacobi_index = 3, square_coefs = false) # rubocop:disable Style/OptionalBooleanParameter
    Core::ThetaFunctions.jacobi_theta_function(jacobi_index, square_coefs)
  end

  def jacobi_theta_power(jacobi_index, power, prec)
    Core::ThetaFunctions.jacobi_theta_function_power(jacobi_index, power, prec)
  end

  def j_invariant(prec)
    Core::KleinJInvariant.modular_j_function(prec)
  end

  def hecke_operator_prime_non_cusp(non_cusp_form_arr, prime, weight_k, prec)
    Core::HeckeOperators.hecke_prime_non_cusp(non_cusp_form_arr, prime, weight_k, prec)
  end

  def hecke_operator_prime_cusp(cusp_form_arr, prime, weight_k, prec)
    Core::HeckeOperators.hecke_prime_cusp(cusp_form_arr, prime, weight_k, prec)
  end

  def gamma0_index(n)
    Core::SL2Zgroups.index_gamma0(n)
  end

  def gamma1_index(n)
    Core::SL2Zgroups.index_gamma1(n)
  end

  def t_gen_matrix(n_power)
    Core::SL2Zgroups.t_matrix(n_power)
  end

  def s_gen_matrix(n_power)
    Core::SL2Zgroups.s_matrix(n_power)
  end

  def u_gen_matrix(mod_n)
    Core::SL2Zgroups.u_matrix(mod_n)
  end

  def st_gen_matrix(n_power)
    Core::SL2Zgroups.st_matrix(n_power)
  end

  def product_gen_mats(gen_mat_a, gen_mat_b)
    Core::SL2Zgroups.product_gen_matrices(gen_mat_a, gen_mat_b)
  end

  def dirichlet_trivchar(modq, a) # rubocop:disable Naming/MethodParameterName
    Core::DirichletCharacters.dirichlet_trivchar(modq, a)
  end

  def conrey_p_pminus1(modp, a) # rubocop:disable Naming/MethodParameterName
    Core::DirichletCharacters.conrey_p_pminus1(modp, a)
  end

  def gauss_sum_triv(dirichlet_q, a) # rubocop:disable Naming/MethodParameterName
    Core::DirichletCharacters.gauss_sum_triv(dirichlet_q, a)
  end

  def gauss_sum_conrey_p_minus1(dirichlet_q, a, parity) # rubocop:disable Naming/MethodParameterName
    Core::DirichletCharacters.gauss_sum_conrey_p_minus1(dirichlet_q, a, parity)
  end

  def elliptic_curve_q(coefs)
    Core::EllipticCurvesQ.elliptic_curve_q(coefs)
  end

  def discriminant_q(curve)
    Core::EllipticCurvesQ.discriminant_qq(curve)
  end

  def j_invariant_q(curve)
    Core::EllipticCurvesQ.j_invariant(curve)
  end

  def point_on_curve_q?(curve, point)
    Core::EllipticCurvesQ.point_on_curve?(curve, point)
  end

  def point_addition_q(curve, p, q) # rubocop:disable Naming/MethodParameterName
    Core::EllipticCurvesQ.point_addition(curve, p, q)
  end

  def scalar_mul_point_q(curve, n, point)
    Core::EllipticCurvesQ.scalar_mul_point(curve, n, point)
  end

  def isogeny_2deg_q(curve, point_2tor)
    Core::EllipticCurvesQ.isogeny_2deg(curve, point_2tor)
  end

  def isogeny_ndeg_q(curve, point_ntor, order)
    Core::EllipticCurvesQ.isogeny_ndeg(curve, point_ntor, order)
  end

  def elliptic_curve_fp(p, coefs) # rubocop:disable Naming/MethodParameterName
    Core::EllipticCurvesFp.elliptic_curve_fp(p, coefs)
  end

  def point_on_curve_modp?(curve, point)
    Core::EllipticCurvesFp.point_on_curve_modp?(curve, point)
  end

  def discriminant_modp(curve)
    Core::EllipticCurvesFp.discriminant_modp(curve)
  end

  def j_invariant_modp(curve)
    Core::EllipticCurvesFp.j_invariant_modp(curve)
  end

  def point_addition_modp(curve, p_point, q_point)
    Core::EllipticCurvesFp.point_addition_modp(curve, p_point, q_point)
  end

  def scalar_mul_point_mopd(curve, n, point)
    Core::EllipticCurvesFp.scalar_mul_point_mopd(curve, n, point)
  end

  def points_fp(curve, point_at_infinity = false) # rubocop:disable Style/OptionalBooleanParameter
    Core::EllipticCurvesFp.points(curve, point_at_infinity)
  end

  def cardinality_fp(curve)
    Core::EllipticCurvesFp.cardinality(curve)
  end

  def quadratic_twist_fp(curve)
    Core::EllipticCurvesFp.quadratic_twist(curve)
  end

  def eta_product(eta1, eta2, prec = nil)
    Core::DedekindEtaFunctions.eta_product(eta1, eta2, prec)
  end

  def eta_quotient(num_eta, den_eta, prec)
    Core::DedekindEtaFunctions.eta_quotient(num_eta, den_eta, prec)
  end
end
