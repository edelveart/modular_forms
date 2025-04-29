# frozen_string_literal: true

require_relative '../numeric_helpers/numeric_helpers'

module ModularForms
  # ModularForms::EllipticCurves
  #
  # This module provides methods for generating points of Elliptic Curves
  module EllipticCurves
    def self.point_on_curve?(point, a, b) # rubocop:disable Naming/MethodParameterName
      x, y = point
      y**2 == x**3 + x * a + b
    end

    def self.discriminant(a, b) # rubocop:disable Naming/MethodParameterName
      -16 * (4 * a**3 + 27 * b**2)
    end
  end
end
