# frozen_string_literal: true

require_relative '../../lib/numeric_helpers/numeric_helpers'

module ModularForms
  # ModularForms::EisensteinSeries
  #
  # This module provides a generator for Eisenstein series, modular functions
  # that are invariant under modular group transformations. It can be used to
  # calculate coefficients and is suitable for applications in Sonic Pi.
  module EisensteinSeries
    def self.eisenstein_modular_form(k)
      raise 'k must be even >= 2' if k < 2 || k % 2 != 0 # rubocop:disable Style/EvenOdd

      bernoulli_k = NumericHelpers.bernoulli_numbers_arr(k)[k]
      factor_normalization = - Rational(2 * k, bernoulli_k)
      Enumerator.new do |q|
        q << 1
        (1..Float::INFINITY).each do |tau|
          coeff = NumericHelpers.divisor_function_sigma(tau, k - 1)
          q << (factor_normalization * coeff).to_i
        end
      end
    end
  end
end
