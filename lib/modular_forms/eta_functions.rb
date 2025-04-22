# frozen_string_literal: true

module ModularForms
  # ModularForms::EtaFunctions
  #
  # This module provides a generator for Dedekind eta functions.
  module DedekindEtaFunctions
    def self.eta_function(pentagonal_coefs = false) # rubocop:disable Metrics/AbcSize,Metrics/MethodLength,Style/OptionalBooleanParameter
      Enumerator.new do |q|
        q << 1
        (1..Float::INFINITY).each do |tau|
          pentagonal_num_minus = (3 * tau**2 - tau) / 2
          pentagonal_num_plus = (3 * tau**2 + tau) / 2
          min_next_pent = (3 * (tau + 1)**2 - (tau + 1)) / 2
          sign = (-1)**tau
          q << (pentagonal_coefs == false ? sign : sign * pentagonal_num_minus)
          (pentagonal_num_plus - pentagonal_num_minus - 1).abs.times do
            q << 0
          end
          q << (pentagonal_coefs == false ? sign : sign * pentagonal_num_plus)
          (min_next_pent - pentagonal_num_plus - 1).abs.times do
            q << 0
          end
        end
      end
    end
  end
end
