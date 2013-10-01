require 'shift_subtitle/options.rb'
require 'shift_subtitle/subtitle.rb'

module SubtitleShift

  def self.run(args)
    options = Options.parse(args)
    Subtitle.run(options)
  end
  
end

# shift_subtitle -p right -d 1.200 -i input.srt -o output.srt
# 01:31:51,210 --> 01:31:54,893
# SubtitleShift::run(ARGV)