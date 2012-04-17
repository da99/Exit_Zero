
describe "Exit_Zero *cmd" do

  it "accepts the same arguments as POSIX::Spawn::Child" do
    Exit_Zero("dc", :input=>'4 4 + p').out
    .should == "8"
  end

  it "raises Exit_Zero::Non_Zero if command exits with non-zero" do
    lambda {
      Exit_Zero 'uptimes'
    }.should.raise(Exit_Zero::Non_Zero)
    .message.should.match %r!127 => bash: uptimes: command not found!
  end

  it "returns a Exit_Zero::Child" do
    Exit_Zero('whoami').class.should.be == Exit_Zero::Child
  end

  it "executes valid command" do
    Exit_Zero('pwd').out.should == `pwd`.strip
  end

  it "raises ArgumentError if both a cmd and block are given" do
    lambda { Exit_Zero('uptime') {} }
    .should.raise(ArgumentError)
    .message.should.match %r!are not allowed!i
  end

  it "combines a multi-line string into one string, joined by \"&&\"" do
    Exit_Zero(%!
      cd ~/
      pwd
    !)
    .out.should == "#{`cd ~/ && pwd`.strip}"
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

describe "Exit_Zero::Child" do

    # ---- :out
  
    it "returns stripped :out" do
      Exit_Zero::Child.new("pwd").out
      .should == `pwd`.strip
    end

    it "returns raw output for :raw_out" do
      Exit_Zero::Child.new("pwd").raw_out
      .should == `pwd`
    end
    
    # ---- :err 
    
    it "returns stripped :err" do
      Exit_Zero::Child.new("pwdssssss").err
      .should == `bash -lc "pwdssssss" 2>&1`.strip
    end

    it "returns raw output for :raw_out" do
      Exit_Zero::Child.new("no_exist").err
      .should.match %r!no_exist: command not found!
    end
  
end # === Exit_Zero::Child



