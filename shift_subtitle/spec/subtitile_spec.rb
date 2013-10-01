require_relative 'spec_helper'

describe SubtitleShift::Subtitle do
  
  it "should correctly convert format 00:01:40,200 to usec" do 
    SubtitleShift::Subtitle.format_time_to_usec('00:01:40,200').should eql 100200
  end
  
  it "should correctly convert usec to format 00:01:40,200" do
    SubtitleShift::Subtitle.format_usec_to_time(100020).should eql '00:01:40,020'
  end
  
  it "shoud move forward correctly" do
    time = "01:31:51,210"
    result = SubtitleShift::Subtitle.shift(time ,'right', 1.200)
    result.should eql "01:31:52,410"
  end
   
  it "shoud move backward correctly" do
    time = "01:31:51,210"
    result = SubtitleShift::Subtitle.shift(time, 'left', 1.300)
    result.should eql "01:31:49,910"
  end
  
  it "should run correctly" do
    options = {:operation=>"right", :duration=>"1.200", :input=>"input.srt", :output=>"output.srt"}
    File.open(options[:input], "w") { |f| f.write "01:31:51,210 --> 01:31:54,893" }
    SubtitleShift::Subtitle.run(options)
    File.exist?(options[:output]).should eql true
    File.read(options[:output]).should eql "01:31:52,410 --> 01:31:56,093"
  end
end