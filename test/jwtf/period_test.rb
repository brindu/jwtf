require 'test_helper'
require 'jwtf/period'

class JWTF::PeriodTest < Minitest::Test
  def test_convert_period_in_seconds
    period = ::JWTF::Period.new(months: 2)
    period_in_seconds = period.in_seconds

    # 30 days month is 2_592_000 seconds
    assert_equal period_in_seconds, 5_184_000
  end
end
