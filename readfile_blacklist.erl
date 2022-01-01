-module(readfile_blacklist).
-define(TEXT_FILE, "C:/Users/DELL/OneDrive/Desktop/thuc_tap_dek/blacklist/DEMO_code/Blacklist.txt").
-export([readlines/1, main/0]).

% readlines(FileName) ->
%     {ok, Device} = file:open(FileName, [read]),
%     {ok, Data} = get_all_lines(Device, []),
%     list_to_tup([X || X <- get_pair(Data), X /= []]).

% get_all_lines(Device, Accum) ->
%     case io:get_line(Device, "") of
%         eof  -> file:close(Device),
%             {ok , Accum};
%         Line -> get_all_lines(Device, Accum ++ [Line])
%     end.

% list_to_tup(List) ->
%     list_to_tup(List, []).

% list_to_tup([], Acc) ->
%     Acc;
% list_to_tup([H| T], Acc) when is_list(H) ->
%     list_to_tup(T, Acc ++ [convert_to_tuple(H)]).

% convert_to_tuple([H, T]) ->
%     {binary:list_to_bin(H), binary:list_to_bin(T)};
% convert_to_tuple(["on"]) ->
%     on;
% convert_to_tuple(["off"]) ->
%     off;
% convert_to_tuple(H) ->
%     H.

% get_pair(List) ->
%     [get_pair(string:to_lower(string:trim(X)), [], []) || X <- List, X /= []].

% get_pair([], Temp, Acc) ->
%     [X || X <- Acc ++ [Temp], X /= []];

% get_pair([H | T], Temp, Acc) when H >= 48, H =< 57 ->
%     get_pair(T, Temp ++ [H], Acc);

% get_pair([_ | T], Temp, Acc) ->
%     get_pair(T, [], Acc ++ [Temp]).

readlines(FileName) ->
    {ok, Device} = file:open(FileName, [read]),
    try get_list(Device)
      after file:close(Device)
    end.

% get_all_lines(Device) ->
%     case io:get_line(Device, "") of
%         eof  -> [];
%         Line -> Line ++ get_all_lines(Device)
%     end.

% get_all_lines(Device) ->
%     io:get_line(Device, "").

get_list(Device) -> get_all_lines(Device, []).

get_all_lines(Device, Acc) ->
    Temp = io:get_line(Device, ""),
    case Temp of
        eof  -> Acc;
        _ -> get_all_lines(Device, Acc ++ [Temp])
    end.

% remove_spaces([]) -> [];

% remove_spaces([H|T]) when H == 32 ->
%     remove_spaces(T);

% remove_spaces([H|T]) ->
%     [H | remove_spaces(T)].

% separate(List) -> separate(List, []).

% separate([H|T], Acc) when H >= 48, H =< 57 ->
%     separate(T, Acc ++ [H]);
% separate([H|T], Acc) -> separate(T, Acc ++ [[H]]);
% separate([], Acc) -> Acc.

% func([H|T]) when H >= 48, H =< 57 ->
%     [H | func(T)];
% func([H|T]) ->
%     [[H] | func(T)];
% func([]) -> [].

func2(List) -> func2(List, [], []).

func2([H|T], Temp, Acc) when H >= 48, H =< 57 ->
    func2(T, Temp ++ [H], Acc);
func2([_|T], Temp, Acc) ->
    func2(T, [], Acc ++ [Temp]);
func2([], Temp, Acc) ->
    Result = Acc ++ [Temp],
    Result.

remove_blank_list(List) ->
    [X || X <- List, X /= []].

process(List) -> process(List, []).

process([], Acc) -> Acc;

process([H|T], Acc) ->
    Temp = remove_blank_list(func2(H)),
    case Temp of
        [] -> process(T, Acc);
        _ -> process(T, Acc ++ [Temp])
    end.

tail_count(List) ->  tail_count(List, 0).

tail_count([_|T], Count) ->
    tail_count(T,  Count + 1);
tail_count([], Count) -> Count.

remove_not_applicable(List) -> remove_not_applicable(List, []).

remove_not_applicable([], Acc) -> Acc;

remove_not_applicable([H|T], Acc) ->
    Temp = tail_count(H),
    case Temp of
        2 -> remove_not_applicable(T, Acc ++ [H]);
        _ -> remove_not_applicable(T, Acc)
    end.

convert_list2bin(List) -> convert_list2bin(List, []).

convert_list2bin([], Acc) -> Acc;
convert_list2bin([H|T], Acc) ->
    convert_list2bin(T, Acc ++ [list_to_binary(H)]).

convert2bin(List) -> convert2bin(List, []).

convert2bin([], Acc) -> Acc;

convert2bin([H|T], Acc) ->
    convert2bin(T, Acc ++ [list_to_tuple(convert_list2bin(H))]).

main() ->
    Content = readlines(?TEXT_FILE),
    % Content.
    Process = process(Content),
    Clean = remove_not_applicable(Process),
    convert2bin(Clean).
    % Test = convert_list2bin(["1000","1002"])
    % is_list(Content).
    % remove_spaces("1000        1003\n").
    % separate("1000        1003\n").
    % func("1000        1003\n").
    % func2("1000        1003\n").
    % func2("1001        1004").
    % func2("Caller \t\tCallee\n").
    % Test = func2("dfd12sfd545sf        dfds 1545789    "),
    % remove_blank_list(Test).
    % list_to_tuple([<<"1000">>,<<"1002">>]).


% C:/Users/DELL/OneDrive/Desktop/thuc_tap_dek/blacklist/DEMO_code/Blacklist.txt
% "##### BLACKLIST ENHANCEMENT FEATURE #####\n\nCaller \t\tCallee\n1000\t    1001\n1000\t\t1002\n1000        1003\n1000        1004\n1001        1000\n1001        1002\n1001        1003\n1001        1004"