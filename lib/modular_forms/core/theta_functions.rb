# frozen_string_literal: true

require_relative '../core/numeric_helpers/numeric_helpers'

module ModularForms
  # ModularForms::ThetaFunctions
  # This module provides a generator for Theta functions.
  module ThetaFunctions
    def self.jacobi_theta_function(jacobi_index = 3, square_coefs = false) # rubocop:disable Style/OptionalBooleanParameter,Metrics/MethodLength,Metrics/AbcSize
      Enumerator.new do |q|
        q << 1
        (1..Float::INFINITY).each do |tau|
          square_num = tau**2
          square_next_num = (tau + 1)**2
          sign = jacobi_index == 3 ? 1**tau : (-1)**tau
          q << (square_coefs == false ? sign * 2 : sign * square_num)
          (square_next_num - square_num - 1).abs.times do
            q << 0
          end
        end
      end
    end

    def self.jacobi_theta_function_power(jacobi_index, power, precision)
      vec = jacobi_theta_function(jacobi_index).take(precision)
      theta_q_coefs = [1]
      power.times do
        theta_q_coefs = NumericHelpers.linear_convolve(theta_q_coefs, vec, precision)
      end
      theta_q_coefs
    end
  end
end
