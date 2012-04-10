
Exit\_Zero
=========

A simple method that raises Exit\_Zero::Non\_Zero 
if $?.exitstatus is not zero. 

If you want other functionality, such as capturing 
standard output/error, then you should use
[posix-spawn](https://github.com/rtomayko/posix-spawn).
That is the easiest way to handle child processes 
(aka shelling out a command). 
[Here are other alternatives](http://stackoverflow.com/questions/6338908/ruby-difference-between-exec-system-and-x-or-backticks).



Installation
------------

    gem 'Exit_Zero'

Useage
------

    require "Exit_Zero"
    
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


