# frozen_string_literal: true

module ModularForms
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

    def self.binomial_coefficient(n, k)
      factorial_iter(n) / (factorial_iter(k) * factorial_iter(n - k))
    end

    def self.bernoulli_numbers_arr(n, bernoulli_numbers = [1])
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

    def self.divisor_function_sigma(n, z)
      total_sum = 0
      (1..n).each do |d|
        if n % d == 0 # rubocop:disable Style/NumericPredicate,Style/IfUnlessModifier
          total_sum += d**z
        end
      end
      total_sum
    end

    def self.prime_number?(n)
      if !n.is_a?(Integer) # rubocop:disable Style/IfUnlessModifier,Style/NegatedIf
        return false
      end
      return false if n < 2

      (2..Math.sqrt(n)).each do |i|
        if (n % i) == 0 # rubocop:disable Style/NumericPredicate,Style/IfUnlessModifier
          return false
        end
      end
      true
    end

    def self.galois_field(n, modp)
      if prime_number?(modp) == false # rubocop:disable Style/IfUnlessModifier
        raise ArgumentError, 'GF must be a prime number'
      end

      ((n % modp) + modp) % modp
    end

    def self.linear_convolve(vec1, vec2, max_degree = nil) # rubocop:disable Metrics/AbcSize
      max_degree == nil ? max_degree = (vec1.size + vec2.size) / 2 : max_degree # rubocop:disable Style/NilComparison
      arr_product = Array.new(max_degree, 0)
      (0..max_degree - 1).each do |n|
        (0..n).each do |m|
          if m < vec1.size && (n - m) < vec2.size # rubocop:disable Style/IfUnlessModifier
            arr_product[n] += vec1[m] * vec2[n - m]
          end
        end
      end
      arr_product
    end

    def self.quotient_of_series(num, den, max_degree)
      arr_coefs = []
      (0..max_degree).each do |n|
        sum = num[n] || 0
        (1..n).each do |k|
          sum -= (den[k] || 0) * (arr_coefs[n - k] || 0)
        end
        arr_coefs << sum / den[0].to_i
      end
      arr_coefs
    end

    def self.euler_criterion(x, pmod)
      (x**((pmod - 1) / 2)) % pmod == 1
    end

    def self.square_modp_list(pmod, init = 1)
      squares_fp = []
      non_squares_fp = []

      (init..pmod - 1).each do |x|
        if euler_criterion(x, pmod)
          squares_fp << x
        else
          non_squares_fp << x
        end
      end

      [squares_fp, non_squares_fp]
    end

    def self.gcd(a, m) # rubocop:disable Naming/MethodParameterName
      a, m = m, a % m while m != 0
      a.abs
    end
  end
end
