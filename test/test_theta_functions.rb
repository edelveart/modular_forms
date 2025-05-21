# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../lib/modular_forms'

class TestModularForms < Minitest::Test
  THETA_J = [1, 2, 0, 0, 2, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0].freeze # rubocop:disable Layout/LineLength

  def test_jacobi_theta_function
    actual = ModularForms.jacobi_theta_function.take(140)
    assert_equal(THETA_J, actual)
  end

  THETA_J_POW = [1, -4, 4, 0, 4, -8, 0, 0, 4, -4, 8, 0, 0, -8, 0, 0, 4, -8, 4, 0, 8, 0, 0, 0, 0, -12, 8, 0, 0, -8, 0,
                 0, 4, 0, 8, 0, 4, -8, 0, 0, 8, -8, 0, 0, 0].freeze

  def test_jacobi_theta_function_pow
    actual = ModularForms.jacobi_theta_function_pow(4, 2, 45)
    assert_equal(THETA_J_POW, actual)
  end
end
