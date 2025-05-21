# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../lib/modular_forms'

class TestModularForms < Minitest::Test
  E_4 = ModularForms.eisenstein_series(4).take(64)

  def test_hecke_operator_prime_non_cusp
    actual = ModularForms.hecke_operator_prime_non_cusp(E_4, 7, 4, 10)
    assert_equal(
      [344, 82_560, 743_040, 2_311_680, 6_026_880, 10_402_560, 20_805_120, 28_400_640, 48_297_600, 62_497_920], actual
    )
  end

  ETA_POW_24 = ModularForms.dedekind_eta_pow(24, 100)

  def test_hecke_operator_prime_cusp
    actual = ModularForms.hecke_operator_prime_cusp(ETA_POW_24, 5, 12, 20)
    assert_equal(
      [4830, -115_920, 1_217_160, -7_109_760, 23_328_900, -29_211_840,
       -80_873_520, 408_038_400, -548_895_690, -559_893_600, 2_582_175_960, -1_791_659_520,
       -2_790_474_540, 1_940_964_480, 5_878_882_800, 4_767_866_880, -33_355_661_220, 13_173_496_560,
       51_494_658_600, -34_340_140_800], actual
    )
  end
end
