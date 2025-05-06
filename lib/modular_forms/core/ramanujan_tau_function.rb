# frozen_string_literal: true

require_relative '../numeric_helpers/numeric_helpers'

module ModularForms
  # ModularForms::RamanujanTauFunction
  #
  # This module provides a generator for Ramanujan tau functions.
  module RamanujanTauFunction
    def self.niebur_sigma_formula # rubocop:disable Metrics/AbcSize,Metrics/MethodLength
      Enumerator.new do |q|
        (1..Float::INFINITY).each do |n|
          sum_term = 0
          (1..(n - 1)).each do |i|
            sum_term += i**2 * (35 * i**2 - 52 * i * n + 18 * n**2) *
                        NumericHelpers.divisor_function_sigma(i, 1) *
                        NumericHelpers.divisor_function_sigma(n - i, 1)
          end
          q << n**4 * NumericHelpers.divisor_function_sigma(n, 1) - 24 * sum_term
        end
      end
    end
  end
end
