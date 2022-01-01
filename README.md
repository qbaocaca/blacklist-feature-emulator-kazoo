# blacklist feature emulator kazoo

To use this, download emulator.erl file. At the top of this file, there are
pretty much what you need.

- A black_list_status file show the status on/off of the blacklist feature.
- A blacklist to store the extension number you or somebody else wants to block.
- A call_log_file to log both successful and blocked calls. (This is pretty
  much a txt file that has other special operations).

In order to use this, make sure you know a bit of Erlang and Bash shell
scripting to use them along.

## A simple callflow.

### Initiate phone function to make a call.

    1>emulator:phone(1989, 2001). # with 1989 being the caller, 2001 the callee.

_If 1989 was not blocked by 2001, the result shows:_

    BLACKLIST FEATURE STATUS: "on\n"
    Call flows as normal.
    ok

### To turn off the blacklist feature, initiate the script.

    ./blacklist-script.sh -m  BLACKLIST

_Pretend to modify a file and type n to exit. Check out the script usage for
more information. To turn it on again, pretend to modify a file and type z._

### To create a default blacklist and add a number.

    ./blacklist-script.sh

This will prompt some questions, follow them along. Check out the script usage
for more information.

_The rotate_log module only logs blocked call. Each log file only has 350
Bytes and will write to a new file if exceeded. Check out rotate_log usage
for more information._
