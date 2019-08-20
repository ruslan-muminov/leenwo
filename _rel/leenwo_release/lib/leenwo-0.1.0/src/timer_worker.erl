-module(timer_worker).
-export([start_link/0]).


start_link() ->
	init().


init() ->
	spawn(fun() -> loop([]) end).


loop(State) ->
	receive
		after 1000 ->
			% %%% === for slowdown
			% List = [integer_to_list(X) || X <- lists:seq(1, 10000)],
			% A = lists:foldl(fun(X, S) -> S ++ X end, "", List),
			% %%% ==================
			% {_, {H, M, S}} = calendar:local_time(),
			% io:format("Timer: ~p:~p:~p~n", [H, M, S]),

			%% spawn
			T1 = now_milli(now()),
			spawn(fun() -> request_for_events(1) end),
			T2 = now_milli(now()),
			io:format("Spended time for spawn: ~p milliseconds~n", [T2-T1]),
			loop(State)
	end.


now_milli({A, B, C}) -> (A*1000000 + B)*1000000 + C.


%%% request to mnesia
request_for_events(Time) ->
	io:format("blabla").