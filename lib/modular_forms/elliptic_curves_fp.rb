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

    def self.fermat_inverse_modp(a, p) # rubocop:disable Naming/MethodParameterName
      a.pow(p - 2, p)
    end

    def self.j_invariant_modp(curve)
      a, b, p = curve.values_at(:a, :b, :p)
      reduction_modp(1728 * (4 * a**3) * fermat_inverse_modp(4 * a**3 + 27 * b**2, p), p)
    end

    def self.point_addition_modp(curve, p_point, q_point) # rubocop:disable Metrics/AbcSize,Metrics/MethodLength
      a, _, p = curve.values_at(:a, _, :p)
      return p_point if q_point == nil # rubocop:disable Style/NilComparison
      return q_point if p_point == nil # rubocop:disable Style/NilComparison

      x1, y1 = p_point
      x2, y2 = q_point
      return nil if x1 == x2 && reduction_modp(y1 + y2, p) == 0 # rubocop:disable Style/NumericPredicate

      if p_point != q_point
        num1 = y2 - y1
        den1 = x2 - x1
        lambda_m = num1 * fermat_inverse_modp(den1, p)
      else
        num2 = 3 * x1**2 + a
        den2 = 2 * y1
        lambda_m = num2 * fermat_inverse_modp(den2, p)
      end

      x3 = lambda_m**2 - x1 - x2
      y3 = lambda_m * (x1 - x3) - y1
      [reduction_modp(x3, p), reduction_modp(y3, p)]
    end

    def self.scalar_mul_point_mopd(curve, n, point)
      n_times_point = nil
      addend = point

      while n > 0 # rubocop:disable Style/NumericPredicate
        n_times_point = point_addition_modp(curve, n_times_point, addend) if n.odd?
        addend = point_addition_modp(curve, addend, addend)
        n >>= 1
      end

      n_times_point
    end
  end
end
