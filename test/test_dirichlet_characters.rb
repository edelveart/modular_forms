# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../lib/modular_forms'

class TestModularForms < Minitest::Test
  def test_dirichlet_trivchar
    actual = ((0..16).map { |x| ModularForms.dirichlet_trivchar(18, x) })
    assert_equal([0, 1, 0, 0, 0, 1, 0, 1, 0, 0, 0, 1, 0, 1, 0, 0, 0], actual)
  end

  def test_conrey_p_pminus1
    actual = ((0..28).map { |x| ModularForms.conrey_p_pminus1(29, x) })
    assert_equal(
      [0, 1, -1, -1, 1, 1, 1, 1, -1, 1, -1, -1, -1, 1,
       -1, -1, 1, -1, -1, -1, 1, -1, 1, 1, 1, 1, -1, -1, 1],
      actual
    )
  end

  def test_invalid_conrey_p_minus1
    modp = 6_209_834
    assert_raises("#{modp} must be a prime number") do
      ModularForms.conrey_p_pminus1(modp, 15)
    end
  end

  def test_gauss_sum_triv
    actual = ((0..12).map { |x| ModularForms.gauss_sum_triv(12, x) })
    assert_equal(
      [4.0, 0.0, 2.0, 0.0, -2.0, 0.0, -4.0, 0.0, -2.0, 0.0, 2.0, 0.0, 4.0],
      actual
    )
  end

  def test_gauss_sum_conrey_p_minus1_even
    actual = ((0..12).map { |x| ModularForms.gauss_sum_conrey_p_minus1(13, x, 'even') })
    assert_equal(
      [0, 3.6055512755, -3.6055512755, 3.6055512755, 3.6055512755, -3.6055512755, -3.6055512755, -3.6055512755,
       -3.6055512755, 3.6055512755, 3.6055512755, -3.6055512755, 3.6055512755],
      actual
    )
  end

  def test_gauss_sum_conrey_p_minus1_odd # rubocop:disable Metrics/AbcSize
    actual = (0..22).map { |x| ModularForms.gauss_sum_conrey_p_minus1(23, x, 'odd') }
    assert_equal(
      [(0 + 0.0i), (0 + 4.7958315233i), (0 + 4.7958315233i), (0 + 4.7958315233i), (0 + 4.7958315233i),
       (0 - 4.7958315233i), (0 + 4.7958315233i), (0 - 4.7958315233i), (0 + 4.7958315233i),
       (0 + 4.7958315233i), (0 - 4.7958315233i), (0 - 4.7958315233i), (0 + 4.7958315233i), (0 + 4.7958315233i),
       (0 - 4.7958315233i), (0 - 4.7958315233i), (0 + 4.7958315233i), (0 - 4.7958315233i), (0 + 4.7958315233i),
       (0 - 4.7958315233i), (0 - 4.7958315233i), (0 - 4.7958315233i), (0 - 4.7958315233i)],
      actual
    )
  end
end
