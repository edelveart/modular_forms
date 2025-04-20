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

  def self.bernoulli_arr(n, bernoulli_numbers = [1]) # rubocop:disable Naming/MethodParameterName
    return bernoulli_numbers[n] if n < bernoulli_numbers.length

    (bernoulli_numbers.length..n).each do |k|
      sum = Rational(0, 1)
      (0...k).each do |j|
        sum += binomial(k + 1, j) * bernoulli_numbers[j]
      end
      bernoulli_numbers[k] = -sum / (k + 1)
    end
    bernoulli_numbers
  end
end
