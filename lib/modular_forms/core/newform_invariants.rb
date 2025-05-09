# frozen_string_literal: true

require_relative '../core/numeric_helpers/numeric_helpers'

module ModularForms
  module Core
    # ModularForms::Core::NewFormInvariants
    #
    # This module provides methods for NewForm Invariants
    module NewFormInvariants
      BERNOULLI = NumericHelpers.bernoulli_numbers_arr(16).reject { |x| x == 0 } # rubocop:disable Style/NumericPredicate
      BERNOULLI_B_2m = BERNOULLI[2..16].each_with_index.map do |x, index|
        Rational(x, (2 * (index + 1))).abs # abs => all B2m positive
      end

      def self.digamma_func(z) # rubocop:disable Metrics/AbcSize,Metrics/MethodLength
        partial_sum = 0.0
        while z < 10
          partial_sum -= Rational(1, z)
          z += 1
        end
        inv_z = Rational(1 / z)
        inv_z2 = inv_z * inv_z
        partial_sum += Math.log(z) - 0.5 * inv_z
        BERNOULLI_B_2m.each_with_index do |b2m, index|
          partial_sum += (-1)**(index + 1) * (inv_z2**(index + 1)) * b2m
        end
        partial_sum
      end
    end
  end
end
