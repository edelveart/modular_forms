# frozen_string_literal: true

require_relative '../numeric_helpers/numeric_helpers'

module ModularForms
  # ModularForms::EllipticCurves
  #
  # This module provides methods for generating points on Elliptic Curves (short Weierstrass form) over char(k) !={2, 3}
  module EllipticCurves
    def self.point_on_curve?(point, a, b) # rubocop:disable Naming/MethodParameterName
      x, y = point
      y**2 == x**3 + x * a + b
    end

    def self.discriminant(a, b) # rubocop:disable Naming/MethodParameterName
      -16 * (4 * a**3 + 27 * b**2)
    end

    def self.j_invariant(a, b) # rubocop:disable Naming/MethodParameterName
      1728 * Rational(4 * a**3, 4 * a**3 + 27 * b**2)
    end

    def self.point_addition(p, q, a) # rubocop:disable Metrics/AbcSize,Metrics/MethodLength,Naming/MethodParameterName
      x1, y1 = p
      x2, y2 = q
      return :infinity if x1 == x2 && y1 + y2 == 0 # rubocop:disable Style/NumericPredicate

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
