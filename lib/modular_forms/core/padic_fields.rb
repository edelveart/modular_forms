# frozen_string_literal: true

require 'prime'

module ModularForms
  module Core
    # ModularForms::Core::PAdicFields
    #
    # This module provides concepts and functionality related to p-adic fields.
    module PAdicFields
      def self.padic_valuation(base_ten_number, p)
        raise "#{p} is not a prime number" unless Prime.prime?(p)

        index = 0
        return index if base_ten_number < 1

        index += 1 while base_ten_number % (p**index) == 0 # rubocop:disable Style/NumericPredicate
        index - 1
      end
    end
  end
end
