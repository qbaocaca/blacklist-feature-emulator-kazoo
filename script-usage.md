# USAGE

## General

### - This script is mainly made for users who are not interested in the code

### and want to maximise convenience. Though, users might still need an operator who can

### assist them in using the program.

### eg. configure a default folder and a default callee number in these lines:

### 15, 48, 143, 267, 479, 560, 574, 643, 678, 689

&nbsp;

## For each functionality

### **CREATE MODE**

### - This mode will prompt the user to create a new blacklist file. If file names match, new file name will be labeled with a number. eg. blacklist1.txt, blacklist2.txt

### - When users are lazy and don't want to specify a file name. There is an option to automatically create a default blacklist file in a default folder (_which should be previously defined by users or operator in General part_). Users just have to specify the script name and the -c or --create option. eg. ./blacklist-script.sh -c

&nbsp;

### **DELETE MODE**

### - This mode will prompt the user to delete a blacklist file.

&nbsp;

### **MODIFY MODE**

### - This mode will prompt the user to have some operations with a blacklist file. eg. add or delete a caller-callee pair, turn on and off BLACKLIST_STATUS_FILE.

&nbsp;

### **VIEW MODE**

### - This mode will prompt the user to view a blacklist file or a BLACKLIST_STATUS_FILE.

&nbsp;

### **CREATE BLACKLIST_STATUS_FILE MODE**

### - This mode will automatically create a BLACKLIST_STATUS_FILE for the user with a default status "off" in the content. Unlike CREATE MODE, this mode only allows the creation of ONE BLACKLIST_STATUS_FILE in a folder. If a file already exists, no more files will be created.

&nbsp;

## Some LIMITATIONs of the program

### - if there are two files that have the same name in two different folders, the program prioritized the default folder and cannot check out to the other.

### - turn on and off option: the program prioritized the default folder and cannot check out to turn on and turn off BLACKLIST_STATUS_FILE in other folders.

### - when deleting a blacklist file, it won't make a back up. so be careful!

### - some other limitations might be found by the user when using. If so, please report so I can have a look and fix them!

&nbsp;

## EXAMPLES of running the program

# SHOW HELP

## **INPUT**

    ./blacklist-script.sh -h or ./blacklist-script.sh --help

## **OUTPUT**

    Usage: ./blacklist-script_copy.sh -c file_name1 -d file_name2 -m file_name3 -v file_name4

    Create. Delete. Modify. View Blacklist Files.

    Options:
            -c,  --create   Enter a name to create a new blacklist with this name.
                            eg. bao-blacklist (NO EXTENSION PLEASE! eg. .txt)
            -d,  --delete   Enter a name to delete a blacklist with this name.
                            eg. bao-blacklist (NO EXTENSION PLEASE! eg. .txt)
            -m,  --modify   Turn on/off blacklist feature. Add a blacklist phone.
            -v,  --view     Enter a name to view a blacklist with this name.
                            eg. bao-blacklist (NO EXTENSION PLEASE! eg. .txt)

    Run ./blacklist-script_copy.sh -h,  --help to print out this instruction.
    Run ./blacklist-script_copy.sh -s,  --status to create a BLACKLIST_STATUS_FILE.

&nbsp;

# CREATE MODE

### _with file name_

## **INPUT**

    ./blacklist-script.sh -c bao-blacklist

## **OUTPUT**

    You are about to create a blacklist file.

    Do you wish to use default folder?
    eg. C:/Users/DELL/OneDrive/Desktop/new-build/ [y/n]: y
    The file has been created in:
    /root/erlang_kidz/bao/bao-blacklist.txt

&nbsp;

### _without file name_

## **INPUT**

    ./blacklist-script.sh -c

## **OUTPUT**

    Do you wish to see help function? n
    Do you wish to create a default blacklist in default folder? y
    /root/erlang_kidz/bao/BLACKLIST.txt already exists! New file will be created.
    The file has been created in:
    /root/erlang_kidz/bao/BLACKLIST1.txt

&nbsp;

### _with file name already exists_

## **INPUT**

    ./blacklist-script.sh --create bao-blacklist

## **OUTPUT**

    You are about to create a blacklist file.

    Do you wish to use default folder?
    eg. C:/Users/DELL/OneDrive/Desktop/new-build/ [y/n]: y
    /root/erlang_kidz/bao/bao-blacklist.txt already exists! New file will be created.
    /root/erlang_kidz/bao/bao-blacklist1.txt already exists! New file will be created.
    /root/erlang_kidz/bao/bao-blacklist2.txt already exists! New file will be created.
    The file has been created in:
    /root/erlang_kidz/bao/bao-blacklist3.txt

&nbsp;

# DELETE MODE

## **INPUT**

    ./blacklist-script.sh -d bao-blacklist or ./blacklist-script.sh --delete bao-blacklist

## **OUTPUT**

    You are about to delete a blacklist file.

    DELETED file /root/erlang_kidz/bao/bao-blacklist.txt

&nbsp;

# MODIFY MODE

## Add a caller-callee pair for the user and for someone else

### _you can check out the VIEW MODE below to see the result of the addition!_

## **INPUT**

    ./blacklist-script.sh -m BLACKLIST1

## **OUTPUT**

    You are about to modify a blacklist file.

    /root/erlang_kidz/bao/BLACKLIST1.txt exists in default folder. Operation continues!

    ============MODIFY.MENU============
    Do you wish to
    x. Add a caller-callee pair.
    y. Delete a caller-callee pair.
    z. Turn on the blacklist feature.
    t. Turn off the blacklist feature.
    n. Exit.
    ===================================
    Enter [x/y/z/t/n]: x
    Do you want to block someone [y/n]? y
    If so, enter a number: 2000
    ADDED pair caller-callee: 2000      1989
    Do you wish to add more [y/n]? y
    If so, enter a number: 2001
    ADDED pair caller-callee: 2001      1989
    Do you wish to add more [y/n]? n
    Do you wish to add for someone [y/n]? y
    If so, enter his/her number: 1999
    Enter a number he/she wants to block: 2003
    ADDED pair caller-callee: 2003      1999
    Do you wish to add more for 1999 [y/n]? y
    If so, enter a number: 2004
    ADDED pair caller-callee: 2004      1999
    Do you wish to add more for 1999 [y/n]? n
    Do you wish to choose another option on MODIFY.MENU [y/n]? n
    Exit operation!

&nbsp;

## Delete a caller-callee pair for the user and for someone else

### _you can check out the VIEW MODE below to see the result of the deletion!_

## **INPUT**

    ./blacklist-script.sh -m BLACKLIST1

## **OUTPUT**

    You are about to modify a blacklist file.

    /root/erlang_kidz/bao/BLACKLIST1.txt exists in default folder. Operation continues!

    ============MODIFY.MENU============
    Do you wish to
    x. Add a caller-callee pair.
    y. Delete a caller-callee pair.
    z. Turn on the blacklist feature.
    t. Turn off the blacklist feature.
    n. Exit.
    ===================================
    Enter [x/y/z/t/n]: y
    Do you wish to remove blocking for a number from your contact [y/n]? y
    If so, specify that number: 2002
    Pair 2002      1989 is DELETED.
    Do you wish to delete more for you 1989 [y/n]? n
    Do you wish to delete for someone [y/n]? y
    If so, enter his/her number: 1999
    Enter number he/she wants to remove blocking: 2003
    Pair 2003      1999 has been removed from the list.
    Do you wish to delete more for 1999 [y/n]? n
    Do you wish to choose another option on MODIFY.MENU [y/n]? n
    Exit operation!

&nbsp;

## Turn on/off the blacklist feature.

### _you can turn on/off the blacklist feature on the BLACKLIST_STATUS_FILE directly or in any blacklist file._

## **INPUT**

    ./blacklist-script.sh -m BLACKLIST_STATUS_FILE or ./blacklist-script.sh -m BLACKLIST1

## **OUTPUT**

    You are about to modify a blacklist file.

    /root/erlang_kidz/bao/BLACKLIST_STATUS_FILE.txt exists in default folder. Operation continues!

    ============MODIFY.MENU============
    Do you wish to
    x. Add a caller-callee pair.
    y. Delete a caller-callee pair.
    z. Turn on the blacklist feature.
    t. Turn off the blacklist feature.
    n. Exit.
    ===================================
    Enter [x/y/z/t/n]: z
    ====> checking BLACKLIST_FEATURE_STATUS.txt in default folder
    Exists!
    Turning on blacklist feature.
    Done

&nbsp;

# VIEW MODE

## **INPUT**

    ./blacklist-script.sh -v BLACKLIST1 or ./blacklist-script.sh --view BLACKLIST1

## **OUTPUT**

    You are about to view a blacklist file.

    ====> checking BLACKLIST1.txt in default folder
    File /root/erlang_kidz/bao/BLACKLIST1.txt exists! Content shown below

    ##### BLACKLIST ENHANCEMENT FEATURE #####

    Caller      Callee
    2000      1989
    2001      1989
    2003      1999
    2004      1999

    Done
    Exit operation!

&nbsp;

# CREATE BLACKLIST_STATUS_FILE MODE

## **INPUT**

    ./blacklist-script.sh -s or ./blacklist-script.sh --status

## **OUTPUT**

    Do you wish to use default folder to store blacklist_status_file?
    eg. C:/Users/DELL/OneDrive/Desktop/new-build/ [y/n]: y
    File is created in /root/erlang_kidz/bao/BLACKLIST_STATUS_FILE.txt
    Done
    Exit operation
