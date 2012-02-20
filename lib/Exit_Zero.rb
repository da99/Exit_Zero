require 'Exit_Zero/version'
require 'Split_Lines'
require 'posix/spawn'

def Exit_Zero cmd=:no_cmd, &blok
  
  if cmd == :no_cmd
    r = yield
    Exit_Zero.check blok, r
    r
  else
    raise ArgumentError, "Both command and block are not allowed." if block_given?
    r = Exit_Zero::Result.new(POSIX::Spawn::Child.new(cmd))
    Exit_Zero.check cmd, r.status
    r
  end
  
end # === Exit_Zero

class Exit_Zero
  
  module Class_Methods
    
    def check cmd, r = :no_status
      r = $? if !r.respond_to?(:exitstatus)
      raise(Exit_Zero::Non_Zero, cmd) if r.exitstatus != 0
    end
    
  end # === Class_Methods
  
  extend Class_Methods

  class Non_Zero < RuntimeError
  end # === class Non_Zero
  
  class Result
    module Base
      
      attr_reader :child
      def initialize child
        @child = child
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
  end # === Result
  
end # === class Exit_Zero
