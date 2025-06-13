# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../lib/modular_forms'

class TestModularForms < Minitest::Test
  P = [Rational(129, 100), Rational(-383, 1000)].freeze
  def test_elliptic_curve_q
    actual = ModularForms.elliptic_curve_q([0, 2])
    assert_equal({ a: 0, b: 2 }, actual)
  end

  def test_elliptic_curve_q_with_invalid_coefs
    a = 0
    b = 0
    assert_raises("y^2=x^3 #{a}x #{b} defines a singular curve") do
      ModularForms.elliptic_curve_q([a, b])
    end
  end

  def test_point_on_curve_q?
    ec = ModularForms.elliptic_curve_q([0, -2])
    actual = ModularForms.point_on_curve_q?(ec, P)
    assert_equal(true, actual)
  end

  def test_invalid_point_on_curve_q?
    x = Rational(13, 15)
    y = Rational(-383, 100)
    ec = ModularForms.elliptic_curve_q([0, -2])
    assert_raises("Coordinates [#{x},#{y}] do not define a point on curve") do
      ModularForms.point_on_curve_q?(ec, [x, y])
    end
  end

  def test_discriminant_q
    ec = ModularForms.elliptic_curve_q([3, 5])
    actual = ModularForms.discriminant_q(ec)
    assert_equal(-12_528, actual)
  end

  def test_j_invariant_q
    ec = ModularForms.elliptic_curve_q([3, 5])
    actual = ModularForms.j_invariant_q(ec)
    assert_equal(Rational(6912, 29), actual)
  end

  def test_point_addition_q
    ec = ModularForms.elliptic_curve_q([0, -2])
    actual = ModularForms.point_addition_q(ec, P, P)
    assert_equal([Rational(2_340_922_881, 58_675_600), Rational(113_259_286_337_279, 449_455_096_000)], actual)
  end

  def test_scalar_mul_point_q # rubocop:disable Metrics/MethodLength
    ec = ModularForms.elliptic_curve_q([0, -2])
    actual = ModularForms.scalar_mul_point_q(ec, 5, P)
    assert_equal(
      [
        Rational(29_167_882_803_130_958_433_397_234_917_019_400_842_240_735_627_664_950_533_249,
                 13_329_936_285_363_921_819_106_507_497_681_304_319_732_363_816_626_483_202_500),
        Rational(
          -4_480_837_752_171_799_317_417_181_660_620_311_416_320_744_088_863_403_448_133_440_333_667_399_448_664_193_857_218_943, 1_539_012_369_349_754_590_526_039_543_006_912_285_957_237_177_754_976_889_877_737_726_811_416_594_332_439_040_125_000 # rubocop:disable Layout/LineLength
        )
      ], actual
    )
  end

  def test_isogeny_2deg_q
    ec = ModularForms.elliptic_curve_q([1, 2])
    p_order_two = [-1, 0]
    actual = ModularForms.isogeny_2deg_q(ec, p_order_two)
    assert_equal({ a: -19, b: 30 }, actual)
  end

  def test_isogeny_ndeg_q
    ec = ModularForms.elliptic_curve_q([1, 2])
    torsion_point = [1, -2]
    actual = ModularForms.isogeny_ndeg_q(ec, torsion_point, 4)
    assert_equal({ a: -59, b: -138 }, actual)
  end

  def test_weil_height
    x_point = P[0]
    assert_equal(4.859812404361672, ModularForms.weil_height([x_point.numerator, x_point.denominator]))
  end

  def test_canonical_height
    ec = ModularForms.elliptic_curve_q([2, 3])
    generator = ModularForms.canonical_height(ec, [Rational(3, 1), Rational(6, 1)], 200)
    assert_equal(1.4494, generator.round(4))

    generator2 = [Rational(-23, 144), Rational(2827, 1728)]
    actual = ModularForms.canonical_height(ec, generator2)
    assert_equal(5.7977, actual.round(4))
  end
end
