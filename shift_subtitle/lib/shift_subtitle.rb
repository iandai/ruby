require 'shift_subtitle/options.rb'
require 'shift_subtitle/subtitle.rb'

module ShiftSubtitle

  def self.run(args)
    options = Options.parse(args)
    Subtitle.run(options)
  end
  
end