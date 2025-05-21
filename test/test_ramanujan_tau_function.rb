# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../lib/modular_forms'

class TestModularForms < Minitest::Test
  RAMANUJAN_T = [1, -24, 252, -1472, 4830, -6048, -16_744, 84_480, -113_643, -115_920, 534_612, -370_944, -577_738, 401_856, 1_217_160, 987_136, -6_905_934, 2_727_432, 10_661_420, -7_109_760, -4_219_488, -12_830_688, 18_643_272, 21_288_960, -25_499_225, 13_865_712, -73_279_080, 24_647_168, 128_406_630, -29_211_840, -52_843_168, -196_706_304, 134_722_224, 165_742_416, -80_873_520, 167_282_496, -182_213_314, -255_874_080, -145_589_976, 408_038_400, 308_120_442, 101_267_712, -17_125_708, -786_948_864, -548_895_690, -447_438_528, 2_687_348_496, 248_758_272, -1_696_965_207, 611_981_400].freeze # rubocop:disable Layout/LineLength

  def test_ramanujan_tau_function
    actual = ModularForms.ramanujan_tau_function.take(50)
    assert_equal(RAMANUJAN_T, actual)
  end
end
