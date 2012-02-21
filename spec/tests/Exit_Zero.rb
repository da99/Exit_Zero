
describe "Exit_Zero 'cmd'" do

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
  
  it "raises Exit_Zero::Non_Zero if $?.exitstatus != 0" do
    lambda {
      Exit_Zero { 
        POSIX::Spawn::Child.new("uptimes")
      }
    }.should.raise(Exit_Zero::Non_Zero)
  end
  
  it "raise Unknown_Exit if block return value does not respond to :status and :exitstatus" do
    target = lambda { :a }
    lambda {
      Exit_Zero(&target)
    }.should.raise(Exit_Zero::Unknown_Exit)
    .message.should.match %r!#{Regexp.escape target.inspect}!
  end
  
end # === Exit_Zero { }

