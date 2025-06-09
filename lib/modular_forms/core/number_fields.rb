# frozen_string_literal: true

module ModularForms
  module Core
    # ModularForms::Core::NumberFields
    #
    # This module provides methods and objects related to number fields,
    # such as zeta_coefficients and utility helpers.
    module NumberFields
      def self.fill_arr_with_interval(length, num, interval)
        arr = Array.new(length, 0)
        (interval - 1).step(length - 1, interval) do |i|
          arr[i] = num
        end
        arr
      end

      def self.zeta_coeffs_deg2(dirichlet_char_group, num_coeffs)
        ded_zeta_to_dir_serie = []
        dirichlet_char_group.each_with_index do |i, j|
          a = 1
          while a <= num_coeffs
            ded_zeta_to_dir_serie << fill_arr_with_interval(num_coeffs, i, j + a)
            a += dirichlet_char_group.length
          end
        end
        ded_zeta_to_dir_serie.transpose.map { |component| component.sum } # rubocop:disable Style/SymbolProc
      end
    end
  end
end
