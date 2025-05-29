# frozen_string_literal: true

require 'prime'

module ModularForms
  module Core
    # ModularForms::Core::PAdicFields
    #
    # This module provides concepts and functionality related to p-adic fields.
    module PAdicFields
      def self.padic_valuation(num_b10, p)
        raise "#{p} is not a prime number" unless Prime.prime?(p)

        index = 0
        return index if num_b10 < 1

        index += 1 while num_b10 % (p**index) == 0 # rubocop:disable Style/NumericPredicate
        index - 1
      end

      def self.padic_norm(num_b10, p)
        return 0 if num_b10 == 0 # rubocop:disable Style/NumericPredicate

        power = padic_valuation(num_b10, p)
        1.0 / p**power
      end

      def self.padic_expansion(num_b10, p, prec = 11, reverse_trim = false) # rubocop:disable Metrics/AbcSize,Metrics/MethodLength,Style/OptionalBooleanParameter
        inverse_limit_arr = []
        (1...prec).each do |index|
          power = p**index
          inverse_limits = ((num_b10 % power) + power) % power
          inverse_limit_arr << inverse_limits
        end
        p_adic_expansion_array = [inverse_limit_arr[0]]

        (0...(prec - 2)).each do |index|
          a1 = inverse_limit_arr[index + 1]
          a0 = inverse_limit_arr[index]
          power = p**(index + 1)
          digits = (a1 - a0) / power
          p_adic_expansion_array << digits
        end

        if reverse_trim
          reversed = p_adic_expansion_array.reverse
          first_nonzero_index = reversed.index { |digit| digit != 0 } || 0
          reversed[first_nonzero_index..-1] # rubocop:disable Style/SlicingWithRange
        else
          p_adic_expansion_array
        end
      end
    end
  end
end
