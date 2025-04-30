# frozen_string_literal: true

require_relative '../numeric_helpers/numeric_helpers'

module ModularForms
  # ModularForms::EllipticCurves
  #
  # This module provides methods for generating points on Elliptic Curves (short Weierstrass form) over char(k) !={2, 3}
  module EllipticCurves
    def self.elliptic_curve(a, b) # rubocop:disable Naming/MethodParameterName
      raise "y^2=x^3 #{a}x #{b} defines a singular curve" if discriminant(a, b) == 0 # rubocop:disable Style/NumericPredicate

      puts "y^2 = x^3 #{a}x #{b}"
      { a: a, b: b }
    end

    def self.point_on_curve?(curve, point)
      return true if point == nil # rubocop:disable Style/NilComparison

      a, b = curve.values_at(:a, :b)
      x, y = point
      y**2 == x**3 + x * a + b
    end

    def self.discriminant(a, b) # rubocop:disable Naming/MethodParameterName
      -16 * (4 * a**3 + 27 * b**2)
    end

    def self.j_invariant(a, b) # rubocop:disable Naming/MethodParameterName
      1728 * Rational(4 * a**3, 4 * a**3 + 27 * b**2)
    end

    def self.point_addition(curve, p, q) # rubocop:disable Metrics/AbcSize,Metrics/MethodLength,Naming/MethodParameterName,Metrics/CyclomaticComplexity,Metrics/PerceivedComplexity
      raise 'P=[x,y] is not on the curve' unless point_on_curve?(curve, p)
      raise 'Q=[x,y] is not on the curve' unless point_on_curve?(curve, q)

      return p if q == nil # rubocop:disable Style/NilComparison
      return q if p == nil # rubocop:disable Style/NilComparison

      x1, y1 = p
      x2, y2 = q
      return nil if x1 == x2 && y1 + y2 == 0 # rubocop:disable Style/NumericPredicate

      a, = curve.values_at(:a)
      if p != q # rubocop:disable Style/ConditionalAssignment
        lambda_m = Rational(y2 - y1, x2 - x1)
      else
        lambda_m = Rational(3 * x1**2 + a, 2 * y1)
      end
      x3 = lambda_m**2 - x1 - x2
      y3 = lambda_m * (x1 - x3) - y1
      [x3, y3]
    end
  end
end
