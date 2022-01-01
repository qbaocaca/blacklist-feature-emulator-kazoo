# rotate_log_usage

## What is this code used for?

### Rotate the log mechanism. When a call is determined to be blacklisted. It is written to a log file with a format like below. When the log file reaches a specified maximum of Bytes (default is 1MB), a new log file will be created and new content will be written. When a maximum of log files reaches (default is 10), all gets deleted and new log files written.

&nbsp;

## black_list_log format

    2021-12-09T17:52:51+07:00 1808 blocked 1989
    2021-12-09T18:15:14+07:00 1048 blocked 1808
    2021-12-09T18:15:16+07:00 1010 blocked 1000

## The log files will appear like this:

    black_list_log1.txt
    black_list_log2.txt
    black_list_log3.txt
    black_list_log4.txt
    black_list_log5.txt

&nbsp;

# How to use the code?

## **Step 1**: Replace the directory in line 2 with the directory you want your log files to be in, plus the name of the log file.

### \*eg. your desired directory is **C:/Users/DELL/OneDrive/Desktop/blacklist/** and the name of the log file is **black_list_log\***

    -define(LOG_FILE, "C:/Users/DELL/OneDrive/Desktop/blacklist/black_list_log").

&nbsp;

## **Step 2**: Compile the module and calling function count_dir_character to get the number of characters of the directory you specified in step 1.

    1> c(rotate_log).
    {ok,rotate_log}
    2> rotate_log:count_dir_character().
    56

&nbsp;

## **Step 3**: Copy the number you get from calling the function from Step 2 to line 33 and 67, and paste in between File_name and 1.

### _In case the lines were shifted, it is the second line of delete and create_file function._

    Extract_number_string = string:substr(File_name, 56, 1)

&nbsp;

## **Step 4**: Calling function check_existence to start writing log files.

    1> rotate_log:check_existence("1989", "1808").
    ok
    2> rotate_log:check_existence("1048", "1010").
    ok
    3> rotate_log:check_existence("1000", "1989").
    ok

&nbsp;

## **\*NOTE:**

&nbsp;

### - You can **set a limit on the number of Bytes that a log file is allowed to be written** on line 50. A default is set at 1000 Bytes, which is 1MB.

### _In case the lines were shifted, it is the third line of check_size function._

&nbsp;

    if  File_size > 1000 -> create_file(File_name, Caller_number, Callee_number);

    if  File_size > 250 -> create_file(File_name, Caller_number, Callee_number);

&nbsp;

### - Other than that, you can **set the maximum number of log files allowed** on line 25 before they get deleted and written new files. A default is set at 10 files with a .txt extension. You can set 15 files with a .log extension, for example.

### _In case the lines were shifted, it is the first line of check_existence function._

&nbsp;

    File_name = ?LOG_FILE ++ "10.txt"
    File_name = ?LOG_FILE ++ "15.log"
