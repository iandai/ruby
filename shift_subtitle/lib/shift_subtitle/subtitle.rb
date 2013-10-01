module SubtitleShift

  class Subtitle
    require 'time'
    
    def self.run(options)
      operation = options[:operation]
      duration = options[:duration].to_f
      input_file = options[:input]
      output_file = options[:output]
      
      IO.foreach(input_file) do |line|
        match_str = /^\d{2}:\d{2}:\d{2},\d{3}\s--> [0-9]{2}:[0-9]{2}:[0-9]{2},[0-9]{3}$/.match(line)
        
        if match_str
          times = line.scan(/\d{2}:\d{2}:\d{2},\d{3}\s/)
          new_line = "#{shift(times[0],operation, duration)} --> #{shift(times[1], operation, duration)}"
          File.open(output_file, "a+") { |file| file.puts new_line}
        else
          File.open(output_file, "a+") { |file| file.puts line}
        end
      end
    end
  
    #01:31:51,210 + 1.200
    def self.shift(time, operation, duration)  
      t_usec = format_time_to_usec(time)
      d_usec = duration * 1000
    
      case operation
      when 'right'
        final_usec = t_usec + d_usec
      when 'left'
        final_usec = t_usec - d_usec
      end

      format_usec_to_time(final_usec)
    end
  
    def self.format_time_to_usec(time)
      t = Time.parse(time)
      hour, min, sec, usec = t.hour, t.min, t.sec, t.usec/1000
      t_usec = ((hour * 60 + min) * 60 + sec) * 1000 + usec
    end
  
    def self.format_usec_to_time(usec)    
      "#{Time.at(usec/1000).gmtime.strftime('%R:%S')},#{sprintf("%.3d", usec%1000)}"
    end
     
  end
end