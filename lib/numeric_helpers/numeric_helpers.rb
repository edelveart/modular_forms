# frozen_string_literal: true

# NumericHelpers
#
# Contains functions used in the definitions of modular forms,
# as well as other related numerical operations.
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

  def self.bernoulli_numbers_arr(n, bernoulli_numbers = [1]) # rubocop:disable Naming/MethodParameterName
    return bernoulli_numbers[n] if n < bernoulli_numbers.length

    (bernoulli_numbers.length..n).each do |k|
      sum = Rational(0, 1)
      (0...k).each do |j|
        sum += binomial_coefficient(k + 1, j) * bernoulli_numbers[j]
      end
      bernoulli_numbers[k] = -sum / (k + 1)
    end
    bernoulli_numbers
  end

  def self.divisor_function_sigma(n, z) # rubocop:disable Naming/MethodParameterName
    total_sum = 0
    (1..n).each do |d|
      if n % d == 0 # rubocop:disable Style/NumericPredicate,Style/IfUnlessModifier
        total_sum += d**z
      end
    end
    total_sum
  end
end
