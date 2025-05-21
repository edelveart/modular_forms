# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../lib/modular_forms'

class TestModularForms < Minitest::Test
  EISENSTEIN_SERIES_EXPECTED = {
    4 => [1, 240, 2160, 6720, 17_520, 30_240, 60_480, 82_560, 140_400, 181_680,
          272_160, 319_680, 490_560, 527_520, 743_040, 846_720, 1_123_440, 1_179_360, 1_635_120, 1_646_400],

    6 => [1, -504, -16_632, -122_976, -532_728, -1_575_504, -4_058_208, -8_471_232, -17_047_800, -29_883_672, -51_991_632, -81_170_208, -129_985_632, -187_132_176, -279_550_656, -384_422_976, -545_530_104, -715_608_432, -986_161_176, -1_247_954_400], # rubocop:disable Layout/LineLength

    8 => [1, 480, 61_920, 1_050_240, 7_926_240, 37_500_480, 135_480_960, 395_301_120, 1_014_559_200, 2_296_875_360, 4_837_561_920, 9_353_842_560, 17_342_613_120, 30_119_288_640, 50_993_844_480, 82_051_050_240, 129_863_578_080, 196_962_563_520, 296_296_921_440, 429_058_435_200], # rubocop:disable Layout/LineLength

    10 => [1, -264, -135_432, -5_196_576, -69_341_448, -515_625_264, -2_665_843_488, -10_653_352_512, -35_502_821_640, -102_284_205_672, -264_515_760_432, -622_498_190_688, -1_364_917_062_432, -2_799_587_834_736, -5_465_169_838_656, -10_149_567_696_576, -18_177_444_679_944, -31_307_199_395_472, -52_471_797_509_736, -85_189_552_213_920] # rubocop:disable Layout/LineLength
  }.freeze

  EISENSTEIN_SERIES_EXPECTED_GAL_F = {
    6 => [1, 1, 3, 4, 2, 1, 2, 3, 0, 3, 3, 2, 3, 4, 4, 4, 1, 3, 4, 0],
    8 => [1, 4, 6, 14, 7, 10, 4, 1, 16, 5, 15, 16, 16, 3, 10, 1, 12, 4, 16, 6],
    114 => [1, 0, 0, 0, 0, 0, 0, 56, 50, 28, 66, 52, 43, 9, 83, 70, 16, 50, 29, 59]
  }.freeze

  def test_eisenstein_series
    EISENSTEIN_SERIES_EXPECTED.each do |weight, expected|
      actual = ModularForms.eisenstein_series(weight).take(20)
      assert_equal(expected, actual, "Failed for weight k = #{weight}")
    end
  end

  def test_eisenstein_series_gal_f
    gal_f_by_weight = { 6 => 5, 8 => 17, 114 => 97 }
    EISENSTEIN_SERIES_EXPECTED_GAL_F.each do |weight, expected|
      actual = ModularForms.eisenstein_series(weight, gal_f_by_weight[weight]).take(20)
      assert_equal(expected, actual, "Failed for weight k = #{weight}")
    end
  end

  def test_eisenstein_series_with_invalid_k
    invalid_values = [-4, -1, 0, 1, 3, 5, 7, 1134.3534]

    invalid_values.each do |invalid_k|
      assert_raises(ArgumentError, "Expected error for invalid k = #{invalid_k}") do
        ModularForms.eisenstein_series(invalid_k).take(5)
      end
    end
  end

  def test_eisenstein_series_with_invalid_gal_f
    invalid_gal_f = [-4, 1, 982, 12, 30, 6_897_942_012, 1134.3534]

    invalid_gal_f.each do |invalid_val|
      assert_raises(ArgumentError, "GF must be a prime number = #{invalid_val}") do
        ModularForms.eisenstein_series(6, invalid_val).take(5)
      end
    end
  end
end
