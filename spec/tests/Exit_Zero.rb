
describe "Exit_Zero *cmd" do

  it "accepts the same arguments as POSIX::Spawn::Child" do
    Exit_Zero("dc", :input=>'4 4 + p').out
    .should == "8\n"
  end
  
  it "raises Exit_Zero::Non_Zero if command exits with non-zero" do
    lambda {
      Exit_Zero 'uptimes'
    }.should.raise(Exit_Zero::Non_Zero)
    .message.should == %!127 => uptimes!
  end

  it "returns a Exit_Zero::Child" do
    Exit_Zero('whoami').class.should.be == Exit_Zero::Child
  end

  it "executes valid command" do
    Exit_Zero('pwd').out.should == `pwd`
  end

  it "raises ArgumentError if both a cmd and block are given" do
    lambda { Exit_Zero('uptime') {} }
    .should.raise(ArgumentError)
    .message.should.match %r!are not allowed!i
  end

end # === Exit_Zero 'cmd'

describe "Exit_Zero { }" do
  
  it "returns last value of the block" do
    Exit_Zero{ POSIX::Spawn::Child.new("ls ~") }
    .out.should. == `ls ~`
  end

  it "raises Exit_Zero::Non_Zero if return value has exitstatus != 0" do
    b = lambda { POSIX::Spawn::Child.new("something_not_found") }
    lambda {
      Exit_Zero(&b)
    }.should.raise(Exit_Zero::Non_Zero)
    .message.should == "127 => #{b.inspect}"
  end
  
  it "raise Unknown_Exit if block return value does not respond to :status and :exitstatus" do
    target = lambda { :a }
    lambda {
      Exit_Zero(&target)
    }.should.raise(Exit_Zero::Unknown_Exit)
    .message.should.match %r!#{Regexp.escape target.inspect}!
  end
  
end # === Exit_Zero { }

