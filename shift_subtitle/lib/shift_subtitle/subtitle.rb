module SubtitleShift

  class Subtitle
    require 'time'
    
    def self.run(options)
      operation = options[:operation]
      duration = options[:duration].to_f
 
      input_file  = File.read(options[:input_file])
      output_file = File.new(options[:output_file], "w")
      
      pattern = /^([0-9]{2}:[0-9]{2}:[0-9]{2},[0-9]{3}) --> ([0-9]{2}:[0-9]{2}:[0-9]{2},[0-9]{3})/
      
      output_file << input_file.gsub(pattern) do
        time_start, time_end = Time.parse($1), Time.parse($2)
        "#{shift(time_start,operation, duration)} --> #{shift(time_end, operation, duration)}"
      end
      
      output_file.flush and output_file.close
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