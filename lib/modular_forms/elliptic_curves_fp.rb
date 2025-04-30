# frozen_string_literal: true

require_relative '../numeric_helpers/numeric_helpers'

module ModularForms
  # ModularForms::EllipticCurvesFp
  #
  # This module provides methods for generating points on Elliptic Curves over Finite Fields (short Weierstrass form)
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

    def self.point_on_curve_modp?(curve, point)
      return true if point == nil # rubocop:disable Style/NilComparison

      a, b, p = curve.values_at(:a, :b, :p)
      x, y = point
      x_modp = reduction_modp(x, p)
      y_modp = reduction_modp(y, p)
      coordinates = reduction_modp(y**2, p) == reduction_modp(x**3 + x * a + b, p)

      raise "Coordinates [#{x_modp},#{y_modp}] do not define a point on curve" unless coordinates
    end

    def self.discriminant_modp(curve)
      a, b, p = curve.values_at(:a, :b, :p)
      reduction_modp(-16 * (4 * a**3 + 27 * b**2), p)
    end
  end
end
