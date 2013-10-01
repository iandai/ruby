require_relative 'shift_subtitle/options.rb'
require_relative 'shift_subtitle/subtitle.rb'



module SubtitleShift

  def self.run(args)
    options = Options.parse(args)
    Subtitle.run(options)
  end
  
end


SubtitleShift::run(ARGV)

# ruby shift_subtitle.rb -p add -d 200 -i input.txt -o output.txt
# 01:31:51,210 --> 01:31:54,893
# 
# operation = options[:operation]
# duration = options[:duration].to_i
# input_file = options[:input]
# output_file = options[:output] 
# 
# st = SubtitleShift::Subtitle.new
# 
# IO.foreach(input_file) do |line|
#   match_str = /^\d{2}:\d{2}:\d{2},\d{3}\s--> [0-9]{2}:[0-9]{2}:[0-9]{2},[0-9]{3}$/.match(line)
#   
#   if match_str
#     times = line.scan(/\d{2}:\d{2}:\d{2},\d{3}\s/)
#     new_line = "#{st.move(operation, times[0], duration)} --> #{st.move(operation, times[1], duration)}"
#     File.open(output_file, "a+") { |file| file.puts new_line}
#   else
#     File.open(output_file, "a+") { |file| file.puts line}
#   end
# end


# https://github.com/JoshCheek/ruby-kickstart/blob/master/session5/notes/05-nesting-classes-and-modules.rb
# # You can declare classes and modules inside of each other.
# class A
# 
#   class B
#   end
# 
#   module C
#     module D
#       class C
#         def self.deep_in_the_hole
#           "The further down I go, pulls the strings on my violin bow"
#         end
#       end
#     end
#   end
# 
# end
# 
# # You can then access them with ::
# A                             # => A
# A::B                          # => A::B
# A::C                          # => A::C
# A::C::D                       # => A::C::D
# A::C::D::C                    # => A::C::D::C
# A::C::D::C.deep_in_the_hole   # => "The further down I go, pulls the strings on my violin bow"
# 
# 
# # Note that even though they're named the same, these are different,
# # like similarly named files in different directories
# A::C == A::C::D::C            # => false


# add gem excutable