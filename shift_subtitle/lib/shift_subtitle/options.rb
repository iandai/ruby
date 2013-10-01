require 'optparse'


module ShiftSubtitle
  class Options
    
    def self.parse(params)
      options = {}
      params.options do |opt|

        opt.on('-p operation', '--operation operation', 'shift direction [right, left]') do |value|
          options[:operation] = value
        end
  
        opt.on('-d time', '--duration time', 'the duration of time that is going to be shifted') do |value|
          options[:duration] = value
        end
  
        opt.on('-i input', '--input input', 'input file')  do |value|
          options[:input] = value
        end
  
        opt.on('-o output', '--output output', 'output file')  do |value|
          options[:output] = value
        end
  
        opt.on_tail('-h', '--help', 'show this message') do
            puts opt
            exit
        end
        opt.parse!
      end

      if options[:operation].nil? || options[:duration].nil? || options[:input].nil? || options[:output].nil?
        puts "Missing value. See useage with -h."
        exit
      end
      
      options
    end
    
  end
end

