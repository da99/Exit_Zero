describe "Exit_0" do
  
  it "accepts the same arguments as Exit_Zero" do
    Exit_0("grep a", :input=>"a\nb\nc")
    .out.should == "a"
  end
  
end # === Exit_0

