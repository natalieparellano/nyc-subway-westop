class String
  def adjust_mod_24
    hour = self[0..1].to_i

    new_hour = if hour < 24
      hour
    else
      hour - 24
    end

    new_hour_s = if new_hour < 10
      "0" + new_hour.to_s
    else
      new_hour.to_s
    end    

    new_hour_s + self[2..-1]
  end
end 