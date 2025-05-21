# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../lib/modular_forms'

class TestModularForms < Minitest::Test
  KLEIN_J = [1, 744, 196_884, 21_493_760, 864_299_970, 20_245_856_256, 333_202_640_600, 4_252_023_300_096, 44_656_994_071_935, 401_490_886_656_000, 3_176_440_229_784_420, 22_567_393_309_593_600, 146_211_911_499_519_294, 874_313_719_685_775_360, 4_872_010_111_798_142_520, 25_497_827_389_410_525_184, 126_142_916_465_781_843_075, 593_121_772_421_445_058_560, 2_662_842_413_150_775_245_160, 11_459_912_788_444_786_513_920, 47_438_786_801_234_168_813_250].freeze # rubocop:disable Layout/LineLength

  def test_j_invariant
    actual = ModularForms.j_invariant(20)
    assert_equal(KLEIN_J, actual)
  end
end
