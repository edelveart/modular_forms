# frozen_string_literal: true

module ModularForms
  module Core
    module PAdicFields
      # ModularForms::Core::PAdicFields::PAdicPol
      #
      # Provides a constructor for a hash of defining polynomials of finite extensions of p-adic fields.
      module PAdicPol
        require_relative './data_pol_2deg'

        def self.build_padic_label_hash(data_padic)
          padic_coefs_by_label = {}
          data_padic.each do |label, coefs|
            p, _y, z, w = label.split('.').map(&:to_i)

            padic_coefs_by_label[p] ||= {}
            padic_coefs_by_label[p][z] ||= {}
            padic_coefs_by_label[p][z][w] = coefs
          end
          padic_coefs_by_label
        end

        def self.gen_quadratic_pol_string(coefs)
          c, b, = coefs
          terms = []
          terms << 'x**2'

          if (b != 0) && (b == 1)
            terms << '+ x'
          elsif b > 1
            terms << "+ #{b}*x"
          end

          terms << "+ #{c}"

          terms.join(' ')
        end

        def self.get_defining_polynomial(hash, p, z, w)
          gen_quadratic_pol_string(hash.dig(p, z, w)).inspect
        end

        DEF_POL_HASH_2DEG = build_padic_label_hash(DATA_POL_2DEG)
      end
    end
  end
end
