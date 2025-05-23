# frozen_string_literal: true

require_relative '../core/numeric_helpers/numeric_helpers'

module ModularForms
  module Core
    # ModularForms::Core::HeckeOperators
    #
    # This module provides methods for applying Hecke operators to modular forms.
    module HeckeOperators
      def self.hecke_prime_non_cusp(non_cusp_form, p, k, precision) # rubocop:disable Metrics/MethodLength,Metrics/AbcSize
        raise ArgumentError, 'p must be a prime number' unless NumericHelpers.prime_number?(p)

        q_size = non_cusp_form.length
        minimum_q_size = (precision - 1) * p + 1
        raise ArgumentError, "size of q-expansion must be at least #{minimum_q_size}" if q_size < minimum_q_size

        normalization_factor = p**(k - 1)
        (0..precision - 1).map do |n|
          if n % p != 0
            non_cusp_form[p * n]
          else
            non_cusp_form[p * n] + normalization_factor * non_cusp_form[n / p]
          end
        end
      end

      def self.hecke_prime_cusp(cusp_form, p, k, precision) # rubocop:disable Metrics/MethodLength,Metrics/AbcSize
        raise ArgumentError, 'p must be a prime number' unless NumericHelpers.prime_number?(p)

        q_size = cusp_form.length
        minimum_q_size = precision * p
        raise ArgumentError, "size of q-expansion must be at least #{minimum_q_size}" if q_size < minimum_q_size

        cusp_form.unshift(0)
        normalization_factor = p**(k - 1)

        (1..precision).map do |n|
          if n % p != 0
            cusp_form[p * n]
          else
            cusp_form[p * n] + normalization_factor * cusp_form[n / p]
          end
        end
      end
    end
  end
end
