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
    case self.wday
    when 0
      "WKD"
    when 6
      "SUN"
    else
      "SAT"
    end
  end

  def parse_from_hms
    Time.parse(self.strftime('%T'))
  end 
end