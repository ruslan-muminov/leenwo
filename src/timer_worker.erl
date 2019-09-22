-module(timer_worker).
-behaviour(gen_server).
-export([now_milli/1]).
-export([start_link/0,init/1,handle_cast/2,handle_call/3]).


start_link() ->
	gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).


% init() ->
% 	spawn(fun() -> loop([]) end).
init(_Args) ->
	{ok, []}.


handle_call(Request, _From, State) ->
	{reply, Request, State}.


handle_cast(_Request, State) ->
	{noreply, State}.


% loop(State) ->
% 	receive
% 		after 1000 ->
% 			% %%% === for slowdown
% 			% List = [integer_to_list(X) || X <- lists:seq(1, 10000)],
% 			% A = lists:foldl(fun(X, S) -> S ++ X end, "", List),
% 			% %%% ==================
% 			% {_, {H, M, S}} = calendar:local_time(),
% 			% io:format("Timer: ~p:~p:~p~n", [H, M, S]),

% 			%% spawn
% 			%T1 = now_milli(now()),
% 			spawn(fun() -> request_for_events(1) end),
% 			%T2 = now_milli(now()),
% 			%io:format("Spended time for spawn: ~p milliseconds~n", [T2-T1]),
% 			loop(State)
% 	end.


now_milli({A, B, C}) -> (A*1000000 + B)*1000000 + C.


%%% request to mnesia
% request_for_events(_Time) ->
% 	io:format("blabla").