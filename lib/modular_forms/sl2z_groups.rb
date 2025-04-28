# frozen_string_literal: true

require_relative '../numeric_helpers/numeric_helpers'

module ModularForms
  # ModularForms::SL2Zgroups
  #
  # This module provides matrices from SL_2(Z) and related algebraic structures.
  module SL2Zgroups
    T_MATRIX = [[1, 1], [0, 1]].freeze
    S_MATRIX = [[0, -1], [1, 0]].freeze
    NEGATIVE_S_MATRIX = [[0, 1], [-1, 0]].freeze
    I_MATRIX = [[1, 0], [0, 1]].freeze
    NEGATIVE_I_MATRIX = [[-1, 0], [0, -1]].freeze
    ST_MATRIX = [[0, -1], [1, 1]].freeze
    U_MATRIX = [[1, 0], [1, 1]].freeze

    def self.t_matrix(n_power)
      [[1, n_power], [0, 1]]
    end

    def self.s_matrix(n_power)
      matrix_s_power_map = {
        1 => S_MATRIX,
        2 => NEGATIVE_I_MATRIX,
        3 => NEGATIVE_S_MATRIX,
        0 => I_MATRIX
      }
      matrix_s_power_map[n_power % 4]
    end

    def self.st_matrix(n_power)
      matrix_st_power_map = {
        1 => ST_MATRIX,
        2 => [[-1, -1], [1, 0]],
        3 => NEGATIVE_I_MATRIX,
        4 => [[0, 1], [-1, -1]],
        5 => [[1, 1], [-1, 0]],
        0 => I_MATRIX
      }
      matrix_st_power_map[n_power % 6]
    end

    def self.u_matrix(n_power_mod)
      [[1, 0], [n_power_mod, 1]]
    end

    def self.product_gen_matrices(gen_mat_a, gen_mat_b) # rubocop:disable Metrics/AbcSize
      [
        [gen_mat_a[0][0] * gen_mat_b[0][0] + gen_mat_a[0][1] * gen_mat_b[1][0],
         gen_mat_a[0][0] * gen_mat_b[0][1] + gen_mat_a[0][1] * gen_mat_b[1][1]],
        [gen_mat_a[1][0] * gen_mat_b[0][0] + gen_mat_a[1][1] * gen_mat_b[1][0],
         gen_mat_a[1][0] * gen_mat_b[0][1] + gen_mat_a[1][1] * gen_mat_b[1][1]]
      ]
    end
  end
end
