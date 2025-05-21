# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../lib/modular_forms'

class TestModularForms < Minitest::Test
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
    actual = ModularForms.point_on_curve_q?(ec, [Rational(129, 100), Rational(-383, 1000)])
    assert_equal(true, actual)
  end

  def test_invalid_point_on_curve_q?
    ec = ModularForms.elliptic_curve_q([0, -2])
    x = 0
    y = -2
    assert_raises("Coordinates [#{x},#{y}] do not define a point on curve") do
      ModularForms.point_on_curve_q?(ec, [Rational(13, 15), Rational(-383, 100)])
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
    p = [Rational(129, 100), Rational(-383, 1000)]
    ec = ModularForms.elliptic_curve_q([0, -2])
    actual = ModularForms.point_addition_q(ec, p, p)
    assert_equal([Rational(2_340_922_881, 58_675_600), Rational(113_259_286_337_279, 449_455_096_000)], actual)
  end

  def test_scalar_mul_point_q # rubocop:disable Metrics/MethodLength
    p = [Rational(129, 100), Rational(-383, 1000)]
    ec = ModularForms.elliptic_curve_q([0, -2])
    actual = ModularForms.scalar_mul_point_q(ec, 5, p)
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
end
