# frozen_string_literal: true

require_relative '../core/numeric_helpers/numeric_helpers'

module ModularForms
  module Core
    # ModularForms::Core::EisensteinSeries
    #
    # This module provides a generator for Eisenstein series.
    module EisensteinSeries
      def self.eisenstein_series(k, gal_f = nil) # rubocop:disable Metrics/AbcSize,Metrics/MethodLength
        raise ArgumentError, 'k must be even and >= 2' if k < 2 || k % 2 != 0 # rubocop:disable Style/EvenOdd

        bernoulli_k = NumericHelpers.bernoulli_numbers_arr(k)[k]
        normalization_factor = - Rational(2 * k, bernoulli_k)
        Enumerator.new do |q|
          q << 1
          (1..Float::INFINITY).each do |tau|
            nth_term = (normalization_factor * NumericHelpers.divisor_function_sigma(tau, k - 1)).to_i
            if gal_f != nil # rubocop:disable Style/ConditionalAssignment,Style/NonNilCheck
              q << NumericHelpers.galois_field(nth_term, gal_f)
            else
              q << nth_term
            end
          end
        end
      end

      def self.eisenstein_series_product(weight_k1, weight_k2, precision)
        vec1 = eisenstein_series(weight_k1).take(precision)
        vec2 = eisenstein_series(weight_k2).take(precision)
        NumericHelpers.linear_convolve(vec1, vec2, precision)
      end

      def self.eisenstein_series_pow(weight_k, power, precision)
        vec = eisenstein_series(weight_k).take(precision)
        eisenstein_q_coefs = [1]
        power.times do
          eisenstein_q_coefs = NumericHelpers.linear_convolve(eisenstein_q_coefs, vec, precision)
        end
        eisenstein_q_coefs
      end
    end
  end
end
