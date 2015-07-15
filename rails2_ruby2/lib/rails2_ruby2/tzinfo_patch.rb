# from https://gist.github.com/cypriss/1976864

require 'tzinfo'

TZInfo::RubyCoreSupport.class_eval do
  HALF_DAYS_IN_DAY = rational_new!(1, 2)

  def self.datetime_new!(ajd = 0, of = 0, sg = Date::ITALY)
    # Convert from an Astronomical Julian Day number to a civil Julian Day number.
    jd = ajd + of + HALF_DAYS_IN_DAY

    # Ruby trunk revision 31862 changed the behaviour of DateTime.jd so that it will no
    # longer accept a fractional civil Julian Day number if further arguments are specified.
    # Calculate the hours, minutes and seconds to pass to jd.

    jd_i = jd.to_i
    jd_i -= 1 if jd < 0
    hours = (jd - jd_i) * 24
    hours_i = hours.to_i
    minutes = (hours - hours_i) * 60
    minutes_i = minutes.to_i
    seconds = (minutes - minutes_i) * 60

    DateTime.jd(jd_i, hours_i, minutes_i, seconds, of, sg)
  end
end
