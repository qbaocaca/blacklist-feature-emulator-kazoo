-module(readblacklist).
-define(TEXT_FILE, "C:/Users/DELL/OneDrive/Desktop/thuc_tap_dek/blacklist/DEMO_code/emulator").
-export([readlines/1, testt/0, func2/1, main/0, remove_blank_list/1, process/1,
    remove_not_applicable/1, convert_list2bin/1, convert2tup/1, test2/1]).

-include_lib("eunit/include/eunit.hrl").

readlines(FileName) ->
    {ok, Device} = file:open(FileName, [read]),
    try get_list(Device)
      after file:close(Device)
    end.

%-------------------------------------------------------------------------------
% readlines/1
% Desc: reads each line from a file and returns them as elements in a list.
% Example: readlines("C:/Users/DELL/OneDrive/Desktop/thuc_tap_dek/blacklist/DEMO
% _code/Blacklist.txt") ->
% ["##### BLACKLIST ENHANCEMENT FEATURE #####\n","\n",
%  "Caller \t\tCallee\n","1weq000\t    1001\n",
%  "1000\t\t1002\n","10sfds00        1003\n",
%  "1000        1004\n","100ads1        1000\n",
%  "1001        1002v\n","1001        100xvc3\n",
%  "10zc01        1004"]
%-------------------------------------------------------------------------------
-spec readlines(FileName :: string()) -> List when
    List :: list().

get_list(Device) -> get_all_lines(Device, []).

get_all_lines(Device, Acc) ->
    Temp = io:get_line(Device, ""),
    case Temp of
        eof  -> Acc;
        _ -> get_all_lines(Device, Acc ++ [Temp])
    end.

%-------------------------------------------------------------------------------
% func2/1
% Desc: get the integers from a string to a list.
% Example: func2("1000        1003\n") ->
% ["1000",[],[],[],[],[],[],[],"1003",[]].
%-------------------------------------------------------------------------------

func2(List) -> func2(List, [], []).

func2([H|T], Temp, Acc) when H >= 48, H =< 57 ->
    func2(T, Temp ++ [H], Acc);
func2([_|T], Temp, Acc) ->
    func2(T, [], Acc ++ [Temp]);
func2([], Temp, Acc) ->
    Result = Acc ++ [Temp],
    Result.

%-------------------------------------------------------------------------------
% func2/1
% Desc: get the integers from a string to a list.
% Example: func2("1000        1003\n") ->
% ["1000",[],[],[],[],[],[],[],"1003",[]].
%-------------------------------------------------------------------------------

main() ->
    ?TEXT_FILE ++ "BLACKLIST1.txt".

%-------------------------------------------------------------------------------
% remove_blank_list/1
% Desc: removes black lists from a list.
% Example: remove_blank_list(["1000",[],[],[],[],[],[],[],"1003",[]]) ->
% ["1000","1003"].
%-------------------------------------------------------------------------------

remove_blank_list(List) ->
    [X || X <- List, X /= []].

%-------------------------------------------------------------------------------
% process/1
% Desc: converts elements of a list into lists containing number type string.
% Example: process(["##### BLACKLIST ENHANCEMENT FEATURE #####\n","\n",
%  "Caller \t\tCallee\n","1weq000\t    1001\n",
%  "1000\t\t1002\n","10sfds00        1003\n",
%  "1000        1004\n","100ads1        1000\n",
%  "1001        1002v\n","1001        100xvc3\n",
%  "10zc01        1004"]) ->
% [["1","000","1001"],
%  ["1000","1002"],
%  ["10","00","1003"],
%  ["1000","1004"],
%  ["100","1","1000"],
%  ["1001","1002"],
%  ["1001","100","3"],
%  ["10","01","1004"]]
%-------------------------------------------------------------------------------

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

%-------------------------------------------------------------------------------
% remove_not_applicable/1
% Desc: returns a list of sublists containing only 2 elements.
% Example: remove_not_applicable([["1","000","1001"],
%  ["1000","1002"],
%  ["10","00","1003"],
%  ["1000","1004"],
%  ["100","1","1000"],
%  ["1001","1002"],
%  ["1001","100","3"],
%  ["10","01","1004"]]) ->
% [["1000","1002"],["1000","1004"],["1001","1002"]].
%-------------------------------------------------------------------------------

remove_not_applicable(List) -> remove_not_applicable(List, []).

remove_not_applicable([], Acc) -> Acc;

remove_not_applicable([H|T], Acc) ->
    Temp = tail_count(H),
    case Temp of
        2 -> remove_not_applicable(T, Acc ++ [H]);
        _ -> remove_not_applicable(T, Acc)
    end.

%-------------------------------------------------------------------------------
% convert_list2bin/1
% Desc: converts elements of a list into binary form.
% Example: convert_list2bin(["1000","1002"]) ->
% [<<"1000">>,<<"1002">>].
%-------------------------------------------------------------------------------

convert_list2bin(List) -> convert_list2bin(List, []).

convert_list2bin([], Acc) -> Acc;
convert_list2bin([H|T], Acc) ->
    convert_list2bin(T, Acc ++ [list_to_binary(H)]).

%-------------------------------------------------------------------------------
% convert2tup/1
% Desc: converts a list of sublists into a list of tuple keeping binary.
% Example: convert2tup([["1000","1002"],["1000","1004"],["1001","1002"]]) ->
% [{<<"1000">>,<<"1002">>},
%  {<<"1000">>,<<"1004">>},
%  {<<"1001">>,<<"1002">>}]
%-------------------------------------------------------------------------------

convert2tup(List) -> convert2tup(List, []).

convert2tup([], Acc) -> Acc;

convert2tup([H|T], Acc) ->
    convert2tup(T, Acc ++ [list_to_tuple(convert_list2bin(H))]).

testt() ->
    Content = readlines(?TEXT_FILE ++ "BLACKLIST3.txt"),
    Process = process(Content),
    Clean = remove_not_applicable(Process),
    convert2tup(Clean).

test2(Filename) ->
    Content = readlines(Filename),
    Process = process(Content),
    Clean = remove_not_applicable(Process),
    convert2tup(Clean).

test2_test_() ->
    [?_assert(test2(?TEXT_FILE ++ "BLACKLIST1.txt") =:=
        [{<<"2010">>,<<"1989">>}, {<<"2020">>,<<"1989">>}]),
    ?_assert(test2(?TEXT_FILE ++ "BLACKLIST2.txt") =:=
        [{<<"123">>,<<"1989">>},
 {<<"1515">>,<<"105">>},
 {<<"1010">>,<<"1989">>},
 {<<"2020">>,<<"1989">>}]),
    ?_assert(test2(?TEXT_FILE ++ "BLACKLIST3.txt") =:=
        [{<<"5060">>,<<"1989">>},
 {<<"5789">>,<<"1989">>},
 {<<"4567">>,<<"1989">>},
 {<<"4567">>,<<"1010">>},
 {<<"7894">>,<<"1010">>}])
        ].