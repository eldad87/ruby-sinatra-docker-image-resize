require './components/image_component'
require 'test/unit'


class TestImageComponent < Test::Unit::TestCase

  # Check what happen if we don't change the dimension
  def test_scale_down_and_keep_ratio_no_change()
    final_width, final_height = ImageComponent.scale_down_and_keep_ratio(400, 800, 400, 800)
    assert_equal(400, final_width)
    assert_equal(800, final_height)
  end

  # Check what happen if we change the required width
  def test_scale_down_and_keep_ratio_shrink_width()
    final_width, final_height = ImageComponent.scale_down_and_keep_ratio(400, 800, 100, 800)
    assert_equal(100, final_width)
    assert_equal(200, final_height)
  end

  # Check what happen if we change the required height
  def test_scale_down_and_keep_ratio_shrink_height()
    final_width, final_height = ImageComponent.scale_down_and_keep_ratio(400, 800, 400, 100)
    assert_equal(50, final_width)
    assert_equal(100, final_height)
  end

  # Use odd numbers to scale both width and height
  def test_scale_down_and_keep_ratio_shrink_width_and_height()
    final_width, final_height = ImageComponent.scale_down_and_keep_ratio(640, 457, 576, 751)
    assert_equal(576, final_width)
    assert_equal(411, final_height)
  end
end