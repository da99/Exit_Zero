describe "Exit_Zero" do
  
  it "accepts the same arguments as Exit_0" do
    Exit_Zero("grep a", :input=>"a\nb\nc")
    .out.should == "a"
  end
  
end # === Exit_Zero

