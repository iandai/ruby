require 'optparse'
require_relative 'shift_subtitle/subtitle.rb'

options = {}
ARGV.options do |opt|

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


# ruby shift_subtitle.rb -p add -d 200 -i input.txt -o output.txt
# 01:31:51,210 --> 01:31:54,893

operation = options[:operation]
duration = options[:duration].to_i
input_file = options[:input]
output_file = options[:output] 

st = Subtitle.new

IO.foreach(input_file) do |line|
  match_str = /^\d{2}:\d{2}:\d{2},\d{3}\s--> [0-9]{2}:[0-9]{2}:[0-9]{2},[0-9]{3}$/.match(line)
  
  if match_str
    times = line.scan(/\d{2}:\d{2}:\d{2},\d{3}\s/)
    new_line = "#{st.move(operation, times[0], duration)} --> #{st.move(operation, times[1], duration)}"
    File.open(output_file, "a+") { |file| file.puts new_line}
  else
    File.open(output_file, "a+") { |file| file.puts line}
  end
end

