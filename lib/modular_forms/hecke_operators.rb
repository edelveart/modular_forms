# frozen_string_literal: true

require_relative '../numeric_helpers/numeric_helpers'

module ModularForms
  # ModularForms::HeckeOperators
  #
  # This module provides methods for applying Hecke operators to modular forms.
  module HeckeOperators
    def self.hecke_prime_non_cusp(non_cusp_form, p, k, precision) # rubocop:disable Naming/MethodParameterName,Metrics/MethodLength,Metrics/AbcSize
      raise ArgumentError, 'p must be a prime number' unless NumericHelpers.prime_number?(p)

      len = non_cusp_form.length
      minimum_len = (precision - 1) * p + 1
      raise ArgumentError, "size of q-expansion must be at least #{minimum_len}" if len < minimum_len

      normalization_factor = p**(k - 1)
      (0..precision - 1).map do |n|
        if n % p != 0
          non_cusp_form[p * n]
        else
          non_cusp_form[p * n] + normalization_factor * non_cusp_form[n / p]
        end
      end
    end
  end
end
