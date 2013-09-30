require_relative 'spec_helper'

describe Subtitle do
  
  it "shoud move forward correctly" do
    time = "01:31:51,210"
    st = Subtitle.new
    result = st.move('add', time, 200)
    result.should eql "01:31:51,410"
  end
   
  it "shoud move backward correctly" do
    time = "01:31:51,210"
    st = Subtitle.new
    result = st.move('minus', time, 300)
    result.should eql "01:31:50,910"
  end
end