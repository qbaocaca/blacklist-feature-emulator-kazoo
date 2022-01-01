-module(rotate_log).
-define(LOG_FILE, "C:/Users/DELL/OneDrive/Desktop/thuc_tap_dek/blacklist/DEMO_code/emulator/black_list_log").
-export([get_File_size/1, check_size/3, create_file/3,
    rotate_log/2, write_content/3,create_initial_file/3,create_new_list/2,
    delete/1, check_existence/2, convert_to_number/1, count_dir_character/0,
    tail_len/2]).

tail_len([], Count) -> Count;

tail_len([_|T], Count) ->
    tail_len(T, Count+1).

count_dir_character() ->
    tail_len(?LOG_FILE, 0) + 1.

convert_to_number(Binary_number) ->
    [ X || <<X>> <= Binary_number].

get_File_size(File_name) ->
    Num_charac = filelib:file_size(File_name),
    Num_byte = Num_charac * 4,
    Num_byte.

check_existence(Caller_number, Callee_number) ->
    File_name = ?LOG_FILE ++ "10.txt",
    case filelib:is_regular(File_name) of
        'true' -> create_new_list(Caller_number, Callee_number);
        'false' -> rotate_log(Caller_number, Callee_number)
    end.

delete(File_name) ->
    file:delete(File_name),
    Extract_number_string = string:substr(File_name, 88, 1),
    Convert_string2number = list_to_integer(Extract_number_string),
    Increment = Convert_string2number + 1,
    Convert_number2string = integer_to_list(Increment),
    New_file_name = ?LOG_FILE ++ Convert_number2string ++ ".txt",
    case filelib:is_regular(New_file_name) of
        'true' -> delete(New_file_name);
        'false' -> 'ok'
    end.

create_new_list(Caller_number, Callee_number) ->
    File_name = ?LOG_FILE ++ "1.txt",
    delete(File_name),
    rotate_log(Caller_number, Callee_number).

check_size(File_name, Caller_number, Callee_number) ->
    File_size = get_File_size(File_name),
    if  File_size > 350 -> create_file(File_name, Caller_number, Callee_number);
        true -> write_content(File_name, Caller_number, Callee_number)
    end.

create_initial_file(File_name, Caller_number, Callee_number) ->
    {ok, S} = file:open(File_name, [write]),
    Get_Date = calendar:system_time_to_rfc3339(erlang:system_time(second)),
    Data1 = string:concat(Get_Date, " "),
    Data2 = string:concat(Data1, Callee_number),
    Data3 = string:concat(Data2, " blocked "),
    Data4 = string:concat(Data3, Caller_number),
    Data5 = string:concat(Data4, "\n"),
    file:write(S, Data5),
    file:close(S).


create_file(File_name, Caller_number, Callee_number) ->
    Extract_number_string = string:substr(File_name, 88, 1),
    Convert_string2number = list_to_integer(Extract_number_string),
    Increment = Convert_string2number + 1,
    Convert_number2string = integer_to_list(Increment),
    New_file_name = ?LOG_FILE ++ Convert_number2string ++ ".txt",
    case filelib:is_regular(New_file_name) of
        'true' -> check_size(New_file_name, Caller_number, Callee_number);
        'false' -> write_content(New_file_name, Caller_number, Callee_number)
    end.

rotate_log(Caller_number, Callee_number) ->
    File_name = ?LOG_FILE ++ "1.txt",
    case filelib:is_regular(File_name) of
        'true' -> check_size(File_name, Caller_number, Callee_number);
        'false' -> create_initial_file(File_name, Caller_number, Callee_number)
    end.

write_content(File, Caller_number, Callee_number) ->
    {ok, S} = file:open(File, [append]),
    Get_Date = calendar:system_time_to_rfc3339(erlang:system_time(second)),
    Data1 = string:concat(Get_Date, " "),
    Data2 = string:concat(Data1, Callee_number),
    Data3 = string:concat(Data2, " blocked "),
    Data4 = string:concat(Data3, Caller_number),
    Data5 = string:concat(Data4, "\n"),
    file:write(S, Data5).