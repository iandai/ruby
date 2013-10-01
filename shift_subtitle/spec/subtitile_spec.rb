require_relative 'spec_helper'

describe Subtitle do
  
  it "should correctly convert format 00:01:40,200 to usec" do 
    Subtitle.format_time_to_usec('00:01:40,200').should eql 100200
  end
  
  it "should correctly convert usec to format 00:01:40,200" do
    Subtitle.format_usec_to_time(100020).should eql '00:01:40,020'
  end
  
  it "shoud move forward correctly" do
    time = "01:31:51,210"
    result = Subtitle.shift(time ,'right', 1.200)
    result.should eql "01:31:52,410"
  end
   
  it "shoud move backward correctly" do
    time = "01:31:51,210"
    result = Subtitle.shift(time, 'left', 1.300)
    result.should eql "01:31:49,910"
  end

end