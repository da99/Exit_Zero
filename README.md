
Exit\_Zero
=========

A simple method that raises Exit\_Zero::Non\_Zero 
if $?.exitstatus is not zero. Be sure to use the 
"posix-spawn" since almost everything else is just 
plain wrong when handling child processes. 

Installation
------------

    gem 'Exit\_Zero'

Useage
------

    require "Exit\_Zero"
    
    Exit_Zero( 'uptime' )
    
    # The following raises an error.
    Exit_Zero( 'uptimess' )

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


