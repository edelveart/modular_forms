# frozen_string_literal: true

require_relative './modular_forms/eisenstein_series'

# ModularForms
#
# This module provides functionality for working with modular forms, a class of
# complex functions that are invariant under the action of a modular group.
# The module is useful in number theory and can be applied
# in areas such as creating musical patterns in Sonic Pi.
module ModularForms
  module_function

  def eisenstein_series(k_weight)
    EisensteinSeries.eisenstein_modular_form(k_weight)
  end
end
