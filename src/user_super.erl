-module(user_super).
-behaviour(supervisor).

-export([init/1, start_link/0]).
-export([handle_user/2]).

start_link() ->
	supervisor:start_link({local, ?MODULE}, ?MODULE, []).


init(_Args) ->
	SupervisorSpec = #{
		strategy => simple_one_for_one,
		intensity => 10,
		period => 60},

	ChildSpec =
		[#{id => user_worker,
			start => {user_worker, start_link, []},
			restart => permanent,
			shutdown => 2000,
			type => worker,
			modules => [user_worker]}],
	{ok, {SupervisorSpec, ChildSpec}}.


handle_user(ChatId, Message) ->
	% check ChatId, maybe exist
	supervisor:start_child(?MODULE, [ChatId, Message]).