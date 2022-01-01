-module(emulator).
-define(STATUS, "C:/Users/DELL/OneDrive/Desktop/thuc_tap_dek/blacklist/DEMO_code/emulator/BLACKLIST_STATUS_FILE.txt").
-define(BLACKLIST, "C:/Users/DELL/OneDrive/Desktop/thuc_tap_dek/blacklist/DEMO_code/emulator/BLACKLIST.txt").
-define(CALL_LOG, "C:/Users/DELL/OneDrive/Desktop/thuc_tap_dek/blacklist/DEMO_code/emulator/call_log_file.txt").
-import(rotate_log, [check_existence/2]).
-import(readblacklist, [test2/1]).
-export([check_blacklist_status_file/0, phone/2]).

write_log(Caller, Callee) ->
    check_existence(Caller, Callee),
    {ok, S} = file:open(?CALL_LOG, [append]),
    Get_Date = calendar:system_time_to_rfc3339(erlang:system_time(second)),
    Data1 = string:concat(Get_Date, " "),
    Data2 = string:concat(Data1, Callee),
    Data3 = string:concat(Data2, " blocked "),
    Data4 = string:concat(Data3, Caller),
    Data5 = string:concat(Data4, "\n"),
    file:write(S, Data5),
    file:close(S),
    io:fwrite("Call is blocked.\n").

write_log2(Caller_number, Callee_number) ->
    {ok, S} = file:open(?CALL_LOG, [append]),
    Get_Date = calendar:system_time_to_rfc3339(erlang:system_time(second)),
    Data1 = string:concat(Get_Date, " "),
    Data2 = string:concat(Data1, integer_to_list(Caller_number)),
    Data3 = string:concat(Data2, " called "),
    Data4 = string:concat(Data3, integer_to_list(Callee_number)),
    Data5 = string:concat(Data4, "\n"),
    file:write(S, Data5),
    file:close(S),
    io:fwrite("Call flows as normal.\n").

blacklist(Caller, Callee) ->
    Temp = {integer_to_binary(Caller), integer_to_binary(Callee)},
    ReadBlFile = test2(?BLACKLIST),
    case lists:member(Temp, ReadBlFile) of
        'true' -> write_log(integer_to_list(Caller), integer_to_list(Callee));
        'false' -> write_log2(Caller, Callee)
    end.

phone(Caller, Callee) ->
    Status = check_blacklist_status_file(),
    io:fwrite("BLACKLIST FEATURE STATUS: ~p\n", [Status]),
    case Status of
        "off\n" -> write_log2(Caller, Callee);
        "on\n" -> blacklist(Caller, Callee)
    end.

check_blacklist_status_file() ->
    {ok, Device} = file:open(?STATUS, [read]),
    io:get_line(Device, "").
