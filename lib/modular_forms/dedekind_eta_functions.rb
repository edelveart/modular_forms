# frozen_string_literal: true

require_relative '../numeric_helpers/numeric_helpers'

module ModularForms
  # ModularForms::DedekindEtaFunctions
  #
  # This module provides a generator for Dedekind eta functions.
  module DedekindEtaFunctions
    def self.eta_function(m_scale = 1, pent_coefs = false) # rubocop:disable Style/OptionalBooleanParameter,Metrics/MethodLength,Metrics/AbcSize
      Enumerator.new do |q|
        q << 1
        (m_scale - 1).times do
          q << 0
        end
        (1..Float::INFINITY).each do |tau|
          pentagonal_num_minus = ((3 * tau**2 - tau) / 2) * m_scale
          pentagonal_num_plus = ((3 * tau**2 + tau) / 2) * m_scale
          min_next_pent = ((3 * (tau + 1)**2 - (tau + 1)) / 2) * m_scale
          sign = (-1)**tau
          q << (pent_coefs == false ? sign : sign * pentagonal_num_minus)
          (pentagonal_num_plus - pentagonal_num_minus - 1).abs.times do
            q << 0
          end
          q << (pent_coefs == false ? sign : sign * pentagonal_num_plus)
          (min_next_pent - pentagonal_num_plus - 1).abs.times do
            q << 0
          end
        end
      end
    end

    def self.eta_function_pow(power, precision, m_scale = 1)
      vec = eta_function(m_scale).take(precision)
      eta_q_coefs = [1]
      power.times do
        eta_q_coefs = NumericHelpers.linear_convolve(eta_q_coefs, vec, precision)
      end
      eta_q_coefs
    end

    def self.centered_fractional_part(num, den)
      return 0 if num % den == 0 # rubocop:disable Style/NumericPredicate

      Rational(num, den) - (num / den).floor - Rational(1, 2)
    end
  end
end
