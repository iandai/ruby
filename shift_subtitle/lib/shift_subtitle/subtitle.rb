class Subtitle

  def initialize
  end
  
  def move(operation, time, duration)
    hour, min, sec, micro = time[0..1].to_i,time[3..4].to_i,time[6..7].to_i,time[9..11].to_i
    middle_secs = (hour * 60 + min) * 60 + sec

    case operation
    when 'add'
      middle_micros = micro + duration
    when 'minus'
      middle_micros = micro - duration
    end
  
    secs = middle_secs + (middle_micros)/1000.to_i
    micros = middle_micros%1000
  
    part1 = Time.at(secs).utc.strftime("%H:%M:%S")
  
    # handle situation 01:01:01,001 
    if micros < 100
      part2 = "0" + micros.to_s
    elsif micros < 10
      part2 = "00" + micros.to_s
    else
      part2 = micros.to_s
    end
  
    result = part1 + "," + part2
  end  
end