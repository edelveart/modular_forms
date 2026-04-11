# frozen_string_literal: true

require_relative '../core/numeric_helpers/numeric_helpers'

module ModularForms
  module Core
    # ModularForms::Core::EllipticCurves
    #
    # This module provides methods for generating points on Elliptic Curves (short Weierstrass form) over Q
    module EllipticCurvesQ # rubocop:disable Metrics/ModuleLength
      def self.discriminant(a, b)
        -16 * (4 * a**3 + 27 * b**2)
      end

      def self.show_curve_equation(a, b) # rubocop:disable Metrics/MethodLength,Lint/RedundantCopDisableDirective
        eq = 'y^2 = x^3'
        eq += a != 0 ? " #{a > 0 ? '+' : '-'} #{a.abs}x" : '' # rubocop:disable Style/NestedTernaryOperator,Style/NumericPredicate
        eq += b != 0 ? " #{b > 0 ? '+' : '-'} #{b.abs}" : '' # rubocop:disable Style/NestedTernaryOperator,Style/NumericPredicate
        eq
      end

      def self.singular?(a, b)
        delta = discriminant(a, b)
        return unless delta.zero?

        type = begin
          x_s = a.zero? ? 0 : Math.sqrt(-a / 3) rescue 0 # rubocop:disable Style/RescueModifier
          x_s.zero? ? 'cusp' : 'node'
        end

        # Concatenar la ecuación directamente en el mensaje
        raise "#{show_curve_equation(a, b)} defines a singular curve (#{type})"
      end

      def self.elliptic_curve_q(coefs)
        a, b = coefs
        singular?(a, b)
        puts show_curve_equation(a, b)
        { a: a, b: b }
      end

      def self.point_on_curve?(curve, point)
        return true if point == nil # rubocop:disable Style/NilComparison

        a, b = curve.values_at(:a, :b)
        x, y = point
        coordinates = y**2 == x**3 + x * a + b
        raise "Coordinates [#{x},#{y}] do not define a point on curve" unless coordinates

        true
      end

      def self.negate_p(point)
        raise ArgumentError, 'Expected a point with two coordinates [x, y]' unless point.length == 2

        x, y = point
        [x, -y]
      end

      def self.discriminant_qq(curve)
        a, b = curve.values_at(:a, :b)
        -16 * (4 * a**3 + 27 * b**2)
      end

      def self.j_invariant(curve)
        a, b = curve.values_at(:a, :b)
        return 0 if a == 0 # rubocop:disable Style/NumericPredicate
        return 1728 if b == 0 # rubocop:disable Style/NumericPredicate

        1728 * Rational(4 * a**3, 4 * a**3 + 27 * b**2)
      end

      def self.point_addition(curve, p, q) # rubocop:disable Metrics/AbcSize,Metrics/MethodLength
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

      def self.scalar_mul_point(curve, n, point)
        n_times_point = nil
        addend = point

        while n > 0 # rubocop:disable Style/NumericPredicate
          n_times_point = point_addition(curve, n_times_point, addend) if n.odd?
          addend = point_addition(curve, addend, addend)
          n >>= 1
        end

        n_times_point
      end

      def self.isogeny_2deg(curve, point_2tor)
        a, b = curve.values_at(:a, :b)
        x0 = point_2tor[0]
        t = 3 * x0**2 + a
        w = x0 * t
        a_isog = a - 5 * t
        b_isog = b - 7 * w
        elliptic_curve_q([a_isog, b_isog])
      end

      def self.isogeny_ndeg(curve, point_ntor, order) # rubocop:disable Metrics/AbcSize,Metrics/MethodLength
        a, b = curve.values_at(:a, :b)
        t = 0
        w = 0
        (1..order - 1).each do |n|
          x0, y0 = scalar_mul_point(curve, n, point_ntor)
          t_q = 3 * x0**2 + a
          u_q = 2 * y0**2
          w_q = u_q + t_q * x0
          t += t_q
          w += w_q
        end
        a_isog = a - 5 * t
        b_isog = b - 7 * w
        elliptic_curve_q([a_isog, b_isog])
      end

      def self.weil_height(x_point)
        return 0 if x_point == nil # rubocop:disable Style/NilComparison

        Math.log(NumericHelpers.q_height(x_point))
      end

      def self.canonical_height(curve, point, prec = 64)
        n = prec
        dim = 1 # To be implemented in a new module for ECurves over extensions of the rationals
        two_pow_n = scalar_mul_point(curve, n, point)[0]
        Rational(1, dim) * (weil_height([two_pow_n.numerator,
                                         two_pow_n.denominator]) * n**-2)
      end
    end
  end
end
# # [-1, 2],
# ModularForms::Core::EllipticCurvesQ.elliptic_curve_q([-27, 54])
# # ModularForms::Core::EllipticCurvesQ.show_curve_equation([-0, 0])
