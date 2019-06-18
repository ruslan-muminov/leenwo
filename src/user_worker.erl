-module(user_worker).

-export([start_link/3,loop/1]).


start_link(A, B, C) ->
	io:format("A=~p B=~p C=~p~n", [A,B,C]),
	init().


init() ->
	%spawn(user_worker, loop, [state]).
	spawn(fun() -> loop([]) end).


% State: chat_id, status
loop(State) ->
	receive
		% message from Timer, 
		% Data from table "daily"
		{timer, Data} -> 
			NewState = State,
			loop(NewState);
		% message from User,
		% Data from request
		{user, Data} ->
			% user_proc:some_func
			NewState = State,
			loop(NewState);
		stop ->
			ok;
		Other ->
			io:format("Unknown type of message:~n~p~n", [Other]),
			loop(State)
	end.