#!/bin/bash

turn_off2()
{
    echo "Exists!"
    echo "off" > "$file_name"
    echo "Turning off blacklist feature."
    echo "Done"
    modify_menu
}

turn_off()
{
    echo "====> checking BLACKLIST_FEATURE_STATUS.txt in default folder"
    file_name="C:/Users/DELL/OneDrive/Desktop/thuc_tap_dek/blacklist/DEMO_code/emulator/BLACKLIST_STATUS_FILE.txt"
    [ -e "$file_name" ] && turn_off2
    echo "File $file_name DOES NOT exist."
    check_another_folder
}

check_another_folder()
{
    while true;
        do
            read -p "Do you wish to create one [y/n]? " yn
                case $yn in
                    [Yy]* ) create_blacklist_status_file1
                            break ;;
                    [Nn]* ) modify_menu
                            break ;;
                        * ) echo "Please answer yes or no." ;;
                esac
    done
}

turn_on2()
{
    echo "Exists!"
    echo "on" > "$file_name"
    echo "Turning on blacklist feature."
    echo "Done"
    echo "Exit operation!"
    exit 1
}

turn_on()
{
    echo "====> checking BLACKLIST_FEATURE_STATUS.txt in default folder"
    file_name="C:/Users/DELL/OneDrive/Desktop/thuc_tap_dek/blacklist/DEMO_code/emulator/BLACKLIST_STATUS_FILE.txt"
    [ -e "$file_name" ] && turn_on2
    echo "File $file_name DOES NOT exist."
    check_another_folder
}

delete_a_number_for_someone2()
{
    echo -n "If so, enter a number: "
    read;
    deleted_line="$REPLY      $callee_number"
    grep -Fxq "$deleted_line" "$path" && delete_a_number2
    echo "Unable to find $deleted_line in the list."
    echo "$REPLY was not previously added for $default_callee"
    delete_more_for_someone
}

delete_more_for_someone()
{
    while true;
        do
            read -p "Do you wish to delete more for $callee_number [y/n]? " yn
                case $yn in
                    [Yy]* ) delete_a_number_for_someone2
                            break ;;
                    [Nn]* ) modify_menu
                            break ;;
                        * ) echo "Please answer yes or no." ;;
                esac
    done
}

delete_a_number2()
{
    sed -i "/$deleted_line/d" "$path"
    echo "Pair $deleted_line has been removed from the list."
    delete_more_for_someone
}

delete_a_number_for_someone()
{
    echo -n "If so, enter his/her number: "
    read;
    callee_number="$REPLY"
    echo -n "Enter number he/she wants to remove blocking: "
    read;
    caller_number="$REPLY"
    deleted_line="$caller_number      $callee_number"
    grep -Fxq "$deleted_line" "$path" && delete_a_number2
    echo "Unable to find $deleted_line in the list."
    echo "$caller_number was not previously added for $callee_number"
    delete_more_for_someone
}

delete_for_someone()
{
    while true;
        do
            read -p "Do you wish to delete for someone [y/n]? " yn
                case $yn in
                    [Yy]* ) delete_a_number_for_someone
                            break ;;
                    [Nn]* )
                            break ;;
                        * ) echo "Please answer yes or no." ;;
                esac
    done
}

delete_more()
{
    while true;
        do
            read -p "Do you wish to delete more for you $default_callee [y/n]? " yn
                case $yn in
                    [Yy]* ) delete_a_pair
                            break ;;
                    [Nn]* ) delete_for_someone
                            break ;;
                        * ) echo "Please answer yes or no." ;;
                esac
    done
}

delete_a_number()
{
    sed -i "/$deleted_line/d" "$path"
    echo "Pair $deleted_line is DELETED."
    delete_more
}

delete_a_pair()
{
    echo -n "If so, specify that number: "
    read;
    default_callee="1989"
    deleted_line="$REPLY      $default_callee"
    grep -Fxq "$deleted_line" "$path" && delete_a_number
    echo "Unable to find $deleted_line in the list."
    echo "$REPLY was not previously added for $default_callee"
    delete_more
}

delete_option()
{
    while true;
        do
            read -p "Do you wish to remove blocking for a number from your contact [y/n]? " yn
                case $yn in
                    [Yy]* ) delete_a_pair
                            break ;;
                    [Nn]* )
                            break ;;
                        * ) echo "Please answer yes or no." ;;
                esac
    done
}

modify_menu()
{
    while true;
        do
            read -p "Do you wish to choose another option on MODIFY.MENU [y/n]? " yn
                case $yn in
                    [Yy]* ) modify_prompt
                            break ;;
                    [Nn]* ) echo "Putting down warning in BLACKLIST_STATUS_FILE"
                            echo "off" > "$file_name"
                            echo "Turning off blacklist feature."
                            echo "Done"
                            echo "Exit operation!"
                            exit ;;
                        * ) echo "Please answer yes or no." ;;
                esac
    done
}

add_a_number_for_someone2()
{
    echo -n "If so, enter a number: "
    read;
    added_line="$REPLY      $someones_number"
    grep -Fxq "$added_line" "$path" || added2
    echo "Number $REPLY already added to blocking list for callee $someones_number"
    add_more_for_someone
}

add_more_for_someone()
{
    while true;
        do
            read -p "Do you wish to add more for $someones_number [y/n]? " yn
                case $yn in
                    [Yy]* ) add_a_number_for_someone2
                            break ;;
                    [Nn]* ) modify_menu
                            break ;;
                        * ) echo "Please answer yes or no." ;;
                esac
    done
}

added2()
{
    echo "$added_line" >> "$path"
    echo "ADDED pair caller-callee: $added_line"
    add_more_for_someone
}

add_a_number_for_someone()
{
    echo -n "If so, enter his/her number: "
    read;
    someones_number="$REPLY"
    echo -n "Enter a number he/she wants to block: "
    read;
    added_line="$REPLY      $someones_number"
    grep -Fxq "$added_line" "$path" || added2
    echo "Number $REPLY already added to blocking list for callee $someones_number"
    add_more_for_someone
}

add_for_someone()
{
    while true;
        do
            read -p "Do you wish to add for someone [y/n]? " yn
                case $yn in
                    [Yy]* ) add_a_number_for_someone
                            break ;;
                    [Nn]* ) modify_menu
                            break ;;
                        * ) echo "Please answer yes or no." ;;
                esac
    done
}

add_more()
{
    while true;
        do
            read -p "Do you wish to add more [y/n]? " yn
                case $yn in
                    [Yy]* ) add_a_number
                            break ;;
                    [Nn]* ) add_for_someone
                            break ;;
                        * ) echo "Please answer yes or no." ;;
                esac
    done
}

added()
{
    echo "$added_line" >> "$path"
    echo "ADDED pair caller-callee: $added_line"
    add_more
}

add_a_number()
{
    echo -n "If so, enter a number: "
    read;
    default_callee="1989"
    added_line="$REPLY      $default_callee"
    grep -Fxq "$added_line" "$path" || added
    echo "Number $REPLY already added to blocking list for callee $default_callee"
    add_more
}

add_a_pair()
{
    while true;
        do
            read -p "Do you want to block someone [y/n]? " yn
                case $yn in
                    [Yy]* ) add_a_number
                            break ;;
                    [Nn]* ) add_for_someone
                            break ;;
                        * ) echo "Please answer yes or no." ;;
                esac
    done
}

exit_operation2()
{
    echo "Directory $path DOES NOT exist."
    echo "Exit operation!"
    exit 1
}

modify_prompt2()
{
    echo "File $path DOES NOT exists."
    echo -n "Which folder is it in? Enter: "
    read;
    [ ! -d "$REPLY" ] && exit_operation
    [ "${REPLY: -1}" != "/" ] && REPLY="${REPLY}/"
    path="$REPLY${file_name3}.txt"
    [ -e "$path" ] || exit_operation2
    echo ""
    echo "File $path exists. Operation continues!"
    warning_mess
}

modify_prompt()
{
    echo ""
    while true;
        do
            echo "============MODIFY.MENU============"
            echo "Do you wish to"
            echo "x. Add a caller-callee pair."
            echo "y. Delete a caller-callee pair."
            echo "z. Turn on the blacklist feature."
            echo "t. Turn off the blacklist feature."
            echo "n. Exit."
            echo "==================================="
            read -p "Enter [x/y/z/t/n]: " xyztn
                case $xyztn in
                    [Xx]* ) add_a_pair
                            break ;;
                    [Yy]* ) delete_option
                            break ;;
                    [Zz]* ) turn_on
                            break ;;
                    [Tt]* ) turn_off
                            break ;;
                    [Nn]* ) echo "Putting down warning in BLACKLIST_STATUS_FILE"
                            echo "off" > "$file_name"
                            echo "Turning off blacklist feature."
                            echo "Done"
                            echo "Exit operation!"
                            exit ;;
                        * ) echo "Please answer yes or no." ;;
                esac
    done
}

delete_prompt()
{
    echo "File $path DOES NOT exists."
    echo -n "Which folder is it in? Enter: "
    read;
    [ ! -d "$REPLY" ] && exit_operation
    [ "${REPLY: -1}" != "/" ] && REPLY="${REPLY}/"
    new_path="$REPLY${file_name2}.txt"
    [ -e "$new_path" ] && delete_2
    echo "File $new_path DOES NOT exists."
    echo "Exit operation!"
}

delete_()
{
    rm -f "$path"
    echo "DELETED file $path"
    exit 1
}

delete_2()
{
    rm -f "$new_path"
    echo "DELETED file $new_path"
    exit 1
}

write_to_blank_file3()
{
    cat >"$result_dir$default_file_name${X}.txt" <<EOL
##### BLACKLIST ENHANCEMENT FEATURE #####

Caller      Callee
EOL
}

create_new_file3()
{
    CREATED=FALSE
    while [[ $CREATED == FALSE ]]; do
        if ! [ -e "$result_dir$default_file_name${X}.txt" ]; then
            touch "$result_dir$default_file_name${X}.txt"
            write_to_blank_file3
            echo "The file has been created in:"
            echo "$result_dir$default_file_name${X}.txt"
            CREATED=TRUE
        else
            echo "$result_dir$default_file_name${X}.txt already exists! New file will be created."
            X=$((X+1))
        fi
    done
}

write_to_blank_file2()
{
    cat >"$REPLY$file_name1${X}.txt" <<EOL
##### BLACKLIST ENHANCEMENT FEATURE #####

Caller      Callee
EOL
}

create_new_file2()
{
    CREATED=FALSE
    while [[ $CREATED == FALSE ]]; do
        if ! [ -e "$REPLY$file_name1${X}.txt" ]; then
            touch "$REPLY$file_name1${X}.txt"
            write_to_blank_file2
            echo "The file has been created in:"
            echo "$REPLY$file_name1${X}.txt"
            CREATED=TRUE
        else
            echo "$REPLY$file_name1${X}.txt already exists! New file will be created."
            X=$((X+1))
        fi
    done
}

write_to_blank_file()
{
    cat >"$result_dir$file_name1${X}.txt" <<EOL
##### BLACKLIST ENHANCEMENT FEATURE #####

Caller      Callee
EOL
}

create_new_file()
{
    CREATED=FALSE
    while [[ $CREATED == FALSE ]]; do
        if ! [ -e "$result_dir$file_name1${X}.txt" ]; then
            touch "$result_dir$file_name1${X}.txt"
            write_to_blank_file
            echo "The file has been created in:"
            echo "$result_dir$file_name1${X}.txt"
            CREATED=TRUE
        else
            echo "$result_dir$file_name1${X}.txt already exists! New file will be created."
            X=$((X+1))
        fi
    done
}

exit_operation()
{
    echo "Directory $REPLY DOES NOT exist."
    echo "Exit operation!"
    exit 1
}

create_continue_prompt()
{
    while true;
        do
            read -p "Do you wish to continue operation [y/n]? " yn
                case $yn in
                    [Yy]* ) echo "Enter your desired path"
                            echo -n "eg. C:/Users/DELL/OneDrive/Desktop/new-build/: "
                            read;
                            [ ! -d "$REPLY" ] && exit_operation
                            [ "${REPLY: -1}" != "/" ] && REPLY="${REPLY}/"
                            create_new_file2
                            break ;;
                    [Nn]* ) echo "Exit operation!"
                            exit ;;
                        * ) echo "Please answer yes or no." ;;
                esac
    done
}

create_prompt()
{
    while true;
        do
            echo "Do you wish to use default folder?"
            read -p "eg. C:/Users/DELL/OneDrive/Desktop/new-build/ [y/n]: " yn
                case $yn in
                    [Yy]* ) result_dir="C:/Users/DELL/OneDrive/Desktop/thuc_tap_dek/blacklist/DEMO_code/emulator/"
                            create_new_file
                            break ;;
                    [Nn]* ) create_continue_prompt
                            exit ;;
                        * ) echo "Please answer yes or no." ;;
                esac
    done
}

helpFunction()
{
	echo ""
	echo "Usage: $0 -c file_name1 -d file_name2 -m file_name3 -v file_name4"
	echo ""
	echo "Create. Delete. Modify. View Blacklist Files."
	echo ""
	echo "Options:"
	echo -e "\t-c,  --create\tEnter a name to create a new blacklist with this name."
	echo -e "\t             \teg. bao-blacklist (NO EXTENSION PLEASE! eg. .txt)"
    echo -e "\t-d,  --delete\tEnter a name to delete a blacklist with this name."
	echo -e "\t             \teg. bao-blacklist (NO EXTENSION PLEASE! eg. .txt)"
    echo -e "\t-m,  --modify\tTurn on/off blacklist feature. Add a blacklist phone."
    echo -e "\t-v,  --view\tEnter a name to view a blacklist with this name."
    echo -e "\t           \teg. bao-blacklist (NO EXTENSION PLEASE! eg. .txt)"
    echo ""
    echo "Run $0 -h,  --help to print out this instruction."
    echo "Run $0 -s,  --status to create a BLACKLIST_STATUS_FILE."
  exit 1
}

continue_operation()
{
    while true;
        do
            read -p "Do you wish to continue operation [y/n]? " yn
                case $yn in
                    [Yy]* ) echo "Enter your desired path"
                            echo -n "eg. C:/Users/DELL/OneDrive/Desktop/new-build/: "
                            read;
                            [ ! -d "$REPLY" ] && exit_operation
                            [ "${REPLY: -1}" != "/" ] && REPLY="${REPLY}/"
                            file_name="${REPLY}BLACKLIST_STATUS_FILE.txt"
                            [ -e "$file_name" ] && exit_message
                            touch "$file_name"
                            echo "off" >> "$file_name"
                            echo "File is created in $file_name"
                            break ;;
                    [Nn]* ) echo "Exit operation!"
                            exit ;;
                        * ) echo "Please answer yes or no." ;;
                esac
    done
}

create_blacklist_status_file1()
{
    while true;
        do
            echo ""
            echo "Do you wish to use default folder to store blacklist_status_file?"
            read -p "eg. C:/Users/DELL/OneDrive/Desktop/new-build/ [y/n]: " yn
                case $yn in
                    [Yy]* ) create_blacklist_status_file2
                            echo "Done"
                            echo "Exit operation"
                            exit ;;
                    [Nn]* ) continue_operation
                            echo "Done"
                            echo "Exit operation"
                            exit ;;
                        * ) echo "Please answer yes or no." ;;
                esac
    done
}

exit_message()
{
    echo "$file_name already exists. No new file is created."
    echo "Exit operation!"
    exit 1
}

create_blacklist_status_file2()
{
    default_folder="C:/Users/DELL/OneDrive/Desktop/thuc_tap_dek/blacklist/DEMO_code/emulator/"
    file_name="${default_folder}BLACKLIST_STATUS_FILE.txt"
    [ -e "$file_name" ] && exit_message
    touch "$file_name"
    echo "off" >> "$file_name"
    echo "File is created in $file_name"
}

fix_bug2()
{
    while true;
        do
            read -p "Do you wish to create a default blacklist in default folder? " yn
                case $yn in
                    [Yy]* ) result_dir="C:/Users/DELL/OneDrive/Desktop/thuc_tap_dek/blacklist/DEMO_code/emulator/"
                            default_file_name="BLACKLIST"
                            create_new_file3
                            break ;;
                    [Nn]* ) echo "Exit operation!"
                            exit ;;
                        * ) echo "Please answer yes or no." ;;
                esac
    done
}

fix_bug()
{
    while true;
        do
            read -p "Do you wish to see help function? " yn
                case $yn in
                    [Yy]* ) helpFunction
                            break ;;
                    [Nn]* ) fix_bug2
                            break ;;
                        * ) echo "Please answer yes or no." ;;
                esac
    done
}

exit_message2()
{
    echo "Directory $file_name DOES NOT exist."
    echo "Exit operation!"
    exit 1
}

view_in_another_folder()
{
    while true;
        do
            read -p "Do you wish to view in another folder? [y/n]: " yn
                case $yn in
                    [Yy]* ) echo "Enter your desired path"
                            echo -n "eg. C:/Users/DELL/OneDrive/Desktop/new-build/: "
                            read;
                            [ ! -d "$REPLY" ] && exit_operation
                            [ "${REPLY: -1}" != "/" ] && REPLY="${REPLY}/"
                            file_name="$REPLY${file_name4}.txt"
                            [ -e "$file_name" ] || exit_message2
                            view1
                            break ;;
                    [Nn]* ) echo "Exit operation!"
                            exit ;;
                        * ) echo "Please answer yes or no." ;;
                esac
    done
}

view1()
{
    echo "File $file_name exists! Content shown below"
    echo ""
    cat $file_name
    echo ""
    echo "Done"
    echo "Exit operation!"
    exit 1
}

view()
{
    echo "====> checking $file_name4.txt in default folder"
    default_folder="C:/Users/DELL/OneDrive/Desktop/thuc_tap_dek/blacklist/DEMO_code/emulator/"
    file_name="$default_folder${file_name4}.txt"
    [ -e "$file_name" ] && view1
    view_in_another_folder
}

print_mess()
{
    echo "Found default BLACKLIST_STATUS_FILE in default folder!"
    writing_mess
}

writing_mess()
{
    echo "======> Blocking it..."
    cat >"$file_name" <<EOL
#####     SOMEBODY IS MODIFYING THE LIST     #####
##### PLEASE DO NOT TURN ON/OFF THIS FEATURE #####
#####             THANK YOU                  #####
EOL
    echo "======> Writing to BLACKLIST_STATUS_FILE..."
    echo "Done"
    echo ""
    echo "======== You can safely modify the your list from now! ========"
    echo ""
    modify_prompt
}

exit_prompt()
{
    echo "Directory $file_name DOES NOT exist."
    echo "Exit operation!"
    exit 1
}

warning_option()
{
    while true;
        do
            read -p "Do you put it somewhere else? " yn
                case $yn in
                    [Yy]* ) echo "If so, enter the path"
                            echo -n "eg. /root/erlang_kidz/bao/: "
                            read;
                            file_name="${REPLY}BLACKLIST_STATUS_FILE.txt"
                            [ -e "${file_name}" ] || exit_prompt
                            echo "Found your BLACKLIST_STATUS_FILE.txt"
                            writing_mess
                            break ;;
                    [Nn]* ) echo "A BLACKLIST_STATUS_FILE will be created in default location"
                            echo "and you can continue operation."
                            create_blacklist_status_file2
                            writing_mess
                            break ;;
                        * ) echo "Please answer yes or no." ;;
                esac
    done
}

warning_mess()
{
    echo " ========> finding and blocking default BLACKLIST_STATUS_FILE..."
    default_folder="C:/Users/DELL/OneDrive/Desktop/thuc_tap_dek/blacklist/DEMO_code/emulator/"
    file_name="${default_folder}BLACKLIST_STATUS_FILE.txt"
    [ -e "$file_name" ] && print_mess
    echo "Sorry BLACKLIST_STATUS_FILE not found for putting up warning!"
    echo "This prevents others from turning on feature while you are modifying"
    warning_option
}

ARGS=$(getopt -a --options c:d:m:v:sh "file_name1:, file_name2:, file_name3:, file_name4:, status, help" -- "$@")
eval set -- "$ARGS"

while (( $# )); do
  case $1 in
    -c|--create) file_name1="$2" ;;
    -d|--delete) file_name2="$2" ;;
    -m|--modify) file_name3="$2" ;;
    -v|--view) file_name4="$2" ;;
    -s|--status) create_blacklist_status_file1 ;;
    -h|--help) helpFunction ;;
    *)         args+=( "$1" ) ;;
  esac
  shift
done
set -- "${args[@]}"

if [ ! -z "$file_name1" ]; then
    echo ""
    echo "You are about to create a blacklist file."
    echo ""
    create_prompt
    exit
fi

if [ ! -z "$file_name2" ]; then
    echo ""
    echo "You are about to delete a blacklist file."
    echo ""
    result_dir="C:/Users/DELL/OneDrive/Desktop/thuc_tap_dek/blacklist/DEMO_code/emulator/"
    path="$result_dir${file_name2}.txt"
    [ -e "$path" ] && delete_
    delete_prompt
    exit
fi

if [ ! -z "$file_name3" ]; then
    echo ""
    echo "You are about to modify a blacklist file."
    echo ""
    result_dir="C:/Users/DELL/OneDrive/Desktop/thuc_tap_dek/blacklist/DEMO_code/emulator/"
    path="$result_dir${file_name3}.txt"
    ([ -e "$path" ] && echo "$path exists in default folder. Operation continues!") || modify_prompt2
    warning_mess
fi

if [ ! -z "$file_name4" ]; then
    echo ""
    echo "You are about to view a blacklist file."
    echo ""
    view
fi

if [ -z "$file_name1" ]; then
    echo ""
    fix_bug
fi
