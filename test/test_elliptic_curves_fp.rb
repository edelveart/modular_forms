# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../lib/modular_forms'

class TestModularForms < Minitest::Test
  P_FP = [2, 2].freeze
  def test_elliptic_curve_fp
    actual = ModularForms.elliptic_curve_fp(5, [1, 2])
    assert_equal({ a: 1, b: 2, p: 5 }, actual)
  end

  def test_elliptic_curve_fp_singular
    a = 2
    b = 3
    assert_raises("y^2=x^3 #{a}x #{b} defines a singular curve") do
      ModularForms.elliptic_curve_fp(5, [a, b])
    end
  end

  def test_point_on_curve_modp?
    ec = ModularForms.elliptic_curve_fp(5, [1, 3])
    actual = ModularForms.point_on_curve_modp?(ec, [4, 1])
    assert_equal(true, actual)
  end

  def test_invalid_point_on_curve_modp?
    x = 3
    y = 2
    ec = ModularForms.elliptic_curve_fp(5, [1, 3])
    assert_raises("Coordinates [#{x},#{y}] do not define a point on curve") do
      ModularForms.point_on_curve_modp?(ec, [x, y])
    end
  end

  def test_discriminant_modp
    ec = ModularForms.elliptic_curve_fp(5, [1, 3])
    actual = ModularForms.discriminant_modp(ec)
    assert_equal(3, actual)
  end

  def test_j_invariant_modp
    ec = ModularForms.elliptic_curve_fp(5, [4, 3])
    actual = ModularForms.j_invariant_modp(ec)
    assert_equal(2, actual)
  end

  def test_point_addition_fp
    ec = ModularForms.elliptic_curve_fp(5, [4, 3])
    actual = ModularForms.point_addition_modp(ec, P_FP, P_FP)
    assert_equal([2, 3], actual)
  end

  def test_scalar_mul_point_mopd
    ec = ModularForms.elliptic_curve_fp(11, [7, 3])
    actual = ModularForms.scalar_mul_point_mopd(ec, 8, [0, 5])
    assert_equal([5, 3], actual)
  end

  def test_points_fp
    ec = ModularForms.elliptic_curve_fp(11, [7, 3])
    actual = ModularForms.points_fp(ec, true)
    assert_equal(
      [
        nil, [0, 5], [0, 6], [1, 0], [2, 5],
        [2, 6], [5, 3], [5, 8], [9, 5], [9, 6]
      ], actual
    )
  end

  def test_cardinality_fp
    ec = ModularForms.elliptic_curve_fp(11, [7, 3])
    actual = ModularForms.cardinality_fp(ec)
    assert_equal(10, actual)
  end

  def test_quadratic_twist
    ec = ModularForms.elliptic_curve_fp(11, [7, 3])
    actual = ModularForms.quadratic_twist_fp(ec)
    assert_includes([
                      { a: 6, b: 2, p: 11 },
                      { a: 10, b: 10, p: 11 },
                      { a: 8, b: 7, p: 11 },
                      { a: 7, b: 8, p: 11 }
                    ],
                    actual)
  end
end
