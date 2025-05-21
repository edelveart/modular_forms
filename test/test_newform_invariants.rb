# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../lib/modular_forms'

class TestModularForms < Minitest::Test
  def test_analytic_conductor
    levels = [8, 13, 21]
    expected_aconductor = [0.472015280046, 0.767024830075, 1.239040110121]

    levels.each_with_index do |level_n, j|
      actual = ModularForms.analytic_conductor(level_n, 4)
      assert_equal(expected_aconductor[j], actual)
    end
  end
end
