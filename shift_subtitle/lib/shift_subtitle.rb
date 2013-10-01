require 'shift_subtitle/options.rb'
require 'shift_subtitle/subtitle.rb'

module SubtitleShift

  def self.run(args)
    options = Options.parse(args)
    Subtitle.run(options)
  end
  
end

# ruby shift_subtitle.rb -p add -d 200 -i input.txt -o output.txt
# 01:31:51,210 --> 01:31:54,893
# SubtitleShift::run(ARGV)