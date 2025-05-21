# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../lib/modular_forms'

class TestModularForms < Minitest::Test
  DEDEKIND_ETA = [1, -1, -1, 0, 0, 1, 0, 1, 0, 0, 0, 0, -1, 0, 0, -1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0].freeze # rubocop:disable Layout/LineLength

  def test_dedekind_eta_function
    actual = ModularForms.dedekind_eta_function.take(150)
    assert_equal(DEDEKIND_ETA, actual)
  end

  DEDEKINT_ETA_POW = [1, 0, -6, 0, 9, 0, 10, 0, -30, 0, 0, 0, 11, 0, 42, 0, 0, 0, -70, 0, 18, 0, -54, 0, 49, 0, 90, 0, 0, 0, -22, 0, -60, 0, 0, 0, -110, 0, 0, 0, 81, 0, 180, 0, -78, 0, 0, 0, 130, 0, -198, 0, 0, 0, -182, 0, -30, 0, 90, 0, 121, 0, 84, 0, 0, 0, 0, 0, 210, 0, 0, 0, -252, 0, -102, 0, -270, 0, 170, 0, 0, 0, 0, 0, -69, 0, 330, 0, 0, 0, -38, 0, 420, 0, 0, 0, -190, 0, -390, 0, 0, 0, -108, 0, 0, 0, 0, 0, 0, 0, -300, 0, 99, 0, 442, 0, 210, 0, 0, 0].freeze # rubocop:disable Layout/LineLength

  def test_dedekind_eta_pow
    actual = ModularForms.dedekind_eta_pow(6, 120, 2)
    assert_equal(DEDEKINT_ETA_POW, actual)
  end

  def test_dedekind_sum
    actual = ModularForms.dedekind_sum(5, 39)
    assert_equal(Rational(11, 18), actual)
  end

  A = [1, -1, -1, 0, 0, 1, 0, 1, 0, 0, 0, 0, -1, 0, 0, -1, 0, 0, 0, 0].freeze
  B = [1, 0, -1, 0, -1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0].freeze

  ETA_PRODUCT = [1, -1, -2, 1, 0, 2, 1, 0, 0, -2, 1, -2, -2, 0, 2, -1, 0, 2, 0, 2].freeze
  def test_eta_product
    actual = ModularForms.eta_product(A, B)
    assert_equal(ETA_PRODUCT, actual)
  end

  ETA_QUOTIENT = [1, -1, 0, -1, 1, -1, 1, -1, 2, -2, 2].freeze
  def test_eta_quotient
    actual = ModularForms.eta_quotient(A, B, 10)
    assert_equal(ETA_QUOTIENT, actual)
  end
end
