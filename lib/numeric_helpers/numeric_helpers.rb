# frozen_string_literal: true

# NumericHelpers
#
# Contains functions for generating modular forms and performing
# other numerical operations.
module NumericHelpers
  def self.factorial_iter(num)
    t = 1
    (1..num).each do |i|
      t *= i
    end
    t
  end

  def self.binomial_coefficient(n, k) # rubocop:disable Naming/MethodParameterName
    factorial_iter(n) / (factorial_iter(k) * factorial_iter(n - k))
  end
end
