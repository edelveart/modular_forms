# frozen_string_literal: true

module ModularForms
  module Core
    # ModularForms::Core::NumberFields
    #
    # This module provides methods and objects related to number fields,
    # such as zeta_coefficients and utility helpers.
    module NumberFields
      def self.fill_array_with_interval(length, num, interval)
        arr = Array.new(length, 0)
        (interval - 1).step(length - 1, interval) do |i|
          arr[i] = num
        end
        arr
      end
    end
  end
end
