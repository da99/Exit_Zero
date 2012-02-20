describe "Exit_Zero::Result" do
  
  it "provides split_lines" do
    r = Exit_Zero::Result.new(POSIX::Spawn::Child.new('ls -Al'))
    r.split_lines.should == `ls -Al`.strip.split("\n")
  end
  
  %w{ out err status }.each { |m|
    it "sets :#{m} equal to Child##{m}" do
      cmd = %q! ruby -e "puts 'a'; warn 'b'; exit(127);"!
      target = POSIX::Spawn::Child.new(cmd)
      Exit_Zero::Result.new(POSIX::Spawn::Child.new(cmd))
      .send(m).should == target.send(m)
    end
  }
  
end # === Exit_Zero::Result

describe "Exit_Zero 'cmd'" do

  it "raises Exit_Zero::Non_Zero if command exits with non-zero" do
    lambda {
      Exit_Zero 'uptimes'
    }.should.raise(Exit_Zero::Non_Zero)
  end

  it "returns a Exit_Zero::Result" do
    Exit_Zero('whoami').class.should.be == Exit_Zero::Result
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
  
end # === Exit_Zero { }

