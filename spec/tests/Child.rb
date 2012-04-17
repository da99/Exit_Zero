describe "Child.new" do
  
  it 'executes given string' do
    Exit_Zero::Child.new("pwd").raw_out.should == `pwd`
  end
  
end # === Exit_Zero::Child

describe "Child#split_lines" do
  
  it "returns split lines of output through :split_lines" do
    r = Exit_Zero::Child.new('ls -Al')
    r.split_lines.should == `ls -Al`.strip.split("\n")
  end
  
end # === Child#split_lines

describe "Child delegate methods" do
  
  %w{ raw_out raw_err status }.each { |m|
    o_m = m.sub("raw_", '')
    it "sets :#{m} equal to Child :#{o_m}" do
      cmd = %q! ruby -e "puts 'a'; warn 'b'; exit(127);"!
      target = POSIX::Spawn::Child.new(cmd)
      Exit_Zero::Child.new(cmd)
      .send(m).should == target.send(o_m)
    end
  }
  
end # === Child delegate methods

