# frozen_string_literal: true

module ModularForms
  module Core
    # ModularForms::Core::LFunctions
    #
    # The LFunctions module provides methods related to L-functions,
    # particularly those associated with modular forms and elliptic curves.
    module LFunctions
      def self.a_p(p, cardinality)
        p + 1 - cardinality
      end

      def self.good_reduction_ap(curve) # rubocop:disable Metrics/MethodLength
        a, b = curve

        Enumerator.new do |y|
          p = 2

          loop do
            if NumericHelpers.prime_number?(p)
              discriminant_modp =
                EllipticCurvesFp.discriminant_modp(
                  { a: a, b: b, p: p }
                )

              unless discriminant_modp.zero?
                # The discriminant is checked again in elliptic_curve_fp, but that's fine for now.
                curve_fp =
                  EllipticCurvesFp.elliptic_curve_fp(p, [a, b])

                ap = a_p(p, EllipticCurvesFp.cardinality(curve_fp))

                y << [p, ap]
              end
            end

            p += 1
          end
        end
      end
    end
  end
end
