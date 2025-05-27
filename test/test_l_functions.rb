# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../lib/modular_forms'

class TestModularForms < Minitest::Test
  def test_a_p # rubocop:disable Metrics/AbcSize,Metrics/MethodLength
    ## newform orbit 144.2.a.a
    prec = 20
    n = ModularForms.dedekind_eta_pow(12, prec, 12)
    d1 = ModularForms.dedekind_eta_pow(4, prec, 6)
    d2 = ModularForms.dedekind_eta_pow(4, prec, 24)
    eta_prod = ModularForms.eta_product(d1, d2)
    newform = ModularForms.eta_quotient(n, eta_prod, prec)
    expected = newform.reject { |x| x == 0 } # rubocop:disable Style/NumericPredicate

    ##  Elliptic curve 144.a3
    p = [7, 13, 19]
    points_card = []
    p.each do |i|
      ellc = ModularForms.elliptic_curve_fp(i, [0, -1])
      points_card << ModularForms.cardinality_fp(ellc)
    end

    ## Modular coefs
    l_coefs = []
    p.zip(points_card).each do |prime, card|
      l_coefs << ModularForms.a_p(prime, card)
    end

    assert_equal(expected[1..3], l_coefs)
  end
end
