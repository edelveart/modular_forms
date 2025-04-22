# frozen_string_literal: true

require_relative '../../lib/numeric_helpers/numeric_helpers'

module ModularForms
  # ModularForms::EisensteinSeries
  #
  # This module provides a generator for Eisenstein series, modular functions
  # that are invariant under modular group transformations. It can be used to
  # calculate coefficients and is suitable for applications in Sonic Pi.
  module EisensteinSeries
    def self.eisenstein_modular_form(k, gal_f = nil) # rubocop:disable Metrics/AbcSize,Metrics/MethodLength
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
  end
end
