require 'Exit_Zero/version'
require 'Split_Lines'
require 'posix/spawn'

def Exit_Zero *cmd, &blok
  
  both = !cmd.empty? && block_given?
  raise ArgumentError, "Both command and block are not allowed." if both

  if block_given?
    cmd = blok
    r = p = blok.call
    msg = cmd
  else
    r = p = Exit_Zero::Child.new(*cmd)
    msg = p.err.strip.empty? ? p.cmd : p.err
    msg << " (command: #{cmd})"
  end


  (r = r.status) if r.respond_to?(:status)
  raise(Exit_Zero::Unknown_Exit, msg.inspect) unless r.respond_to?(:exitstatus)
  raise(Exit_Zero::Non_Zero, "#{r.exitstatus} => #{msg}") if r.exitstatus != 0

  p
end # === Exit_Zero

class Exit_Zero
  
  Non_Zero      = Class.new(RuntimeError)
  Unknown_Exit  = Class.new(RuntimeError)
  
  module Class_Methods
  end # === Class_Methods
  
  extend Class_Methods
  
  class Child
    module Base
      
      attr_reader :cmd, :child
      def initialize *cmd
        @child = POSIX::Spawn::Child.new(*cmd)
        @cmd = cmd.join(' ')
      end

      def split_lines
        Split_Lines(child.out)
      end

      %w{ out err status }.each { |m|
        eval %~
          def #{m}
            child.#{m}
          end
        ~
      }

    end # === Base
    include Base
  end # === Child
  
end # === class Exit_Zero
