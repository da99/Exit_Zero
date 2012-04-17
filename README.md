
Exit\_Zero
=========

A simple method that raises Exit\_Zero::Non\_Zero 
if $?.exitstatus is not zero. 

Don't like Exit\_Zero? Try:

* [posix-spawn](https://github.com/rtomayko/posix-spawn).
That is the easiest way to handle child processes 
(aka shelling out). 
* [POpen4](https://github.com/shairontoledo/popen4) Don't confuse it with regular popen4.
* [Here are other alternatives](http://stackoverflow.com/questions/6338908/ruby-difference-between-exec-system-and-x-or-backticks).

Windows
------

Use something else. Check the previous list above
for other alternatives, 
especialy [POpen4](https://github.com/shairontoledo/popen4),
which is Windows and POSIX compatible.

Implementation
----

Exit\_Zero runs your command through bash:

    your command: uptime
    Final result: POSIX::Spawn::Child.new "bash -lc #{cmd.inspect}"

Exit\_Zero lives in one file. So if you have any questions, [here
it is](https://github.com/da99/Exit\_Zero/blob/master/lib/Exit\_Zero.rb).


Installation
------------

    gem install Exit_Zero

Usage
------

    require "Exit_Zero"
    
    Exit_Zero( 'uptime' )
    Exit_Zero( 'ls', :input=>' /some/dir ')
    Exit_Zero { system "uptime" }
    
    # The following raises an error.
    Exit_Zero( 'uptimess' )
    Exit_Zero { `uptimesss` }

Run Tests
---------

    git clone git@github.com:da99/Exit_Zero.git
    cd Exit_Zero
    bundle update
    bundle exec bacon spec/main.rb

"I hate writing."
-----------------------------

If you know of existing software that makes the above redundant,
please tell me. The last thing I want to do is maintain code.


