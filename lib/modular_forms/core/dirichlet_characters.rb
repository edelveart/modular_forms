# frozen_string_literal: true

require_relative '../core/numeric_helpers/numeric_helpers'

module ModularForms
  module Core
    # ModularForms::Core::DirichletCharacters
    #
    # This module provides generators for Dirichlet characters and related topics.
    module DirichletCharacters
      PI2 = 2 * Math::PI

      PARITY = {
        EVEN: 'even',
        ODD: 'odd'
      }.freeze

      def self.dirichlet_trivchar(modq, a)
        NumericHelpers.gcd(a, modq) == 1 ? 1 : 0
      end

      def self.conrey_p_pminus1(modp, a)
        raise "#{modp} must be a prime number" if !NumericHelpers.prime_number?(modp) # rubocop:disable Style/NegatedIf
        return 0 if a % modp == 0 # rubocop:disable Style/NumericPredicate
        return 1 if NumericHelpers.euler_criterion(a, modp)

        -1 if !NumericHelpers.euler_criterion(a, modp) # rubocop:disable Style/NegatedIf
      end

      def self.exponential(a, r, q)
        Complex.polar(1, PI2 * (a * r) / q)
      end

      def self.gauss_sum_triv(q_char, a)
        t_a = 0 + 0i
        (0..q_char - 1).each do |r|
          t_a += dirichlet_trivchar(q_char, r) * exponential(a, r, q_char)
        end
        t_a.real.to_f.round(2)
      end

      def self.gauss_sum_conrey_p_minus1(q_char, a, parity) # rubocop:disable Metrics/AbcSize
        raise "Parity '#{parity}' must be either 'even' or 'odd'" if parity != PARITY[:ODD] && parity != PARITY[:EVEN]

        t_a = 0 + 0i
        (0..q_char - 1).each do |r|
          t_a += conrey_p_pminus1(q_char, r) * exponential(a, r, q_char)
        end

        return t_a.real.round(10) if parity == PARITY[:EVEN]

        Complex(0, t_a.imaginary.round(10)) if parity == PARITY[:ODD]
      end
    end
  end
end
