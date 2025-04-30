# frozen_string_literal: true

require_relative '../numeric_helpers/numeric_helpers'

module ModularForms
  # ModularForms::EllipticCurvesFP
  #
  # This module provides methods for generating points on Elliptic Curves (short Weierstrass form) over char(k) !={2, 3}
  module EllipticCurvesFp
    def self.reduction_modp(n, modp)
      ((n % modp) + modp) % modp
    end

    def self.discriminant(a, b) # rubocop:disable Naming/MethodParameterName
      -16 * (4 * a**3 + 27 * b**2)
    end

    ## podría emular como en SAGE para que sea divertido
    def self.elliptic_curve_fp(p, a, b) # rubocop:disable Naming/MethodParameterName
      raise "#{p} is not a prime number" if NumericHelpers.prime_number?(p) == false

      d = reduction_modp(discriminant(a, b), p)

      a_modp = reduction_modp(a, p)
      b_modp = reduction_modp(b, p)
      raise "y^2=x^3 #{a_modp}x #{b_modp} defines a singular curve" if d == 0 # rubocop:disable Style/NumericPredicate

      puts "y^2 = x^3 #{a_modp}x #{b_modp} over Finite Field #{p}"
      { a: a, b: b, p: p }
    end
  end
end
