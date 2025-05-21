# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../lib/modular_forms'

class TestModularForms < Minitest::Test # rubocop:disable Metrics/ClassLength
  T_CASES = {
    7 => [[1, 7], [0, 1]],
    0 => [[1, 0], [0, 1]],
    -3 => [[1, -3], [0, 1]]
  }.freeze

  def test_t_gen_matrix
    T_CASES.each do |n_power, expected|
      actual = ModularForms.t_gen_matrix(n_power)
      assert_equal(expected, actual, "Failed for t_gen_matrix with n_power = #{n_power}")
    end
  end

  S_CASES = {
    1 => ModularForms::Core::SL2Zgroups::S_MATRIX,
    2 => ModularForms::Core::SL2Zgroups::NEGATIVE_I_MATRIX,
    3 => ModularForms::Core::SL2Zgroups::NEGATIVE_S_MATRIX,
    0 => ModularForms::Core::SL2Zgroups::I_MATRIX,
    5 => ModularForms::Core::SL2Zgroups::S_MATRIX,
    -1 => ModularForms::Core::SL2Zgroups::NEGATIVE_S_MATRIX,
    -2 => ModularForms::Core::SL2Zgroups::NEGATIVE_I_MATRIX
  }.freeze

  def test_s_gen_matrix
    S_CASES.each do |n_power, expected|
      actual = ModularForms.s_gen_matrix(n_power)
      assert_equal(expected, actual, "Failed for s_gen_matrix with n_power = #{n_power}")
    end
  end

  ST_CASES = {
    1 => ModularForms::Core::SL2Zgroups::ST_MATRIX,
    2 => [[-1, -1], [1, 0]],
    3 => ModularForms::Core::SL2Zgroups::NEGATIVE_I_MATRIX,
    4 => [[0, 1], [-1, -1]],
    5 => [[1, 1], [-1, 0]],
    0 => ModularForms::Core::SL2Zgroups::I_MATRIX,
    6 => ModularForms::Core::SL2Zgroups::I_MATRIX,
    -1 => [[1, 1], [-1, 0]],
    -2 => [[0, 1], [-1, -1]]
  }.freeze

  def test_st_gen_matrix
    ST_CASES.each do |n_power, expected|
      actual = ModularForms.st_gen_matrix(n_power)
      assert_equal(expected, actual, "Failed for st_gen_matrix with n_power = #{n_power}")
    end
  end

  U_CASES = {
    7 => [[1, 0], [7, 1]],
    0 => [[1, 0], [0, 1]],
    -3 => [[1, 0], [-3, 1]],
    5 => [[1, 0], [5, 1]],
    10 => [[1, 0], [10, 1]],
    -1 => [[1, 0], [-1, 1]]
  }.freeze

  def test_u_gen_matrix
    U_CASES.each do |n_power_mod, expected|
      actual = ModularForms.u_gen_matrix(n_power_mod)
      assert_equal(expected, actual, "Failed for u__gen_matrix with n_power_mod = #{n_power_mod}")
    end
  end

  PRODUCT_CASES = [
    {
      gen_mat_a: [[1, 2], [3, 4]],
      gen_mat_b: [[5, 6], [7, 8]],
      expected: [[19, 22], [43, 50]]
    },
    {
      gen_mat_a: [[0, 0], [0, 0]],
      gen_mat_b: [[5, 6], [7, 8]],
      expected: [[0, 0], [0, 0]]
    },
    {
      gen_mat_a: [[1, -1], [2, 3]],
      gen_mat_b: [[4, 5], [-6, 7]],
      expected: [[10, -2], [-10, 31]]
    },
    {
      gen_mat_a: [[-1, -2], [-6, -9]],
      gen_mat_b: [[5, 3], [9, 24]],
      expected: [[-23, -51], [-111, -234]]
    }
  ].freeze

  def test_product_gen_mats
    PRODUCT_CASES.each do |test_case|
      actual = ModularForms.product_gen_mats(test_case[:gen_mat_a], test_case[:gen_mat_b])
      assert_equal(test_case[:expected], actual)
    end
  end

  GAMMA_0 = [1, 3, 4, 6, 6, 12, 8, 12, 12, 18, 12, 24, 14,
             24, 24, 24, 18, 36, 20, 36, 32, 36, 24, 48, 30, 42, 36, 48,
             30, 72, 32, 48, 48, 54, 48, 72, 38, 60, 56, 72,
             42, 96, 44, 72, 72, 72, 48, 96, 56, 90].freeze

  def test_gamma0_index
    actual = (1..50).map { |x| ModularForms.gamma0_index(x) }
    assert_equal(GAMMA_0, actual)
  end

  GAMMA_1 = [1, 3, 8, 12, 24, 24, 48, 48, 72, 72, 120, 96, 168, 144,
             192, 192, 288, 216, 360, 288, 384, 360, 528, 384,
             600, 504, 648, 576, 840, 576, 960, 768,
             960, 864, 1152, 864, 1368, 1080, 1344, 1152, 1680,
             1152, 1848, 1440, 1728, 1584, 2208, 1536, 2352, 1800].freeze

  def test_gamma1_index
    actual = (1..50).map { |x| ModularForms.gamma1_index(x) }
    assert_equal(GAMMA_1, actual)
  end
end
