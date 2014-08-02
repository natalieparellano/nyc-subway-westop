class Time
  def day_of_week
    case self.wday
    when 0
      "SUN"
    when 6
      "SAT"
    else
      "WKD"
    end
  end

  def next_day_of_week
    if self.wday < 5
      "WKD"
    elsif self.wday == 5
      "SAT"
    elsif self.wday == 6
      "SUN"
    end 
  end

  def parse_from_hms
    Time.parse(self.strftime('%T'))
  end 
end