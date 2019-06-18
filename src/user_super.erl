-module(user_super).
-behaviour(supervisor).

-export([init/1, start_link/0]).


% {ok, Super} = user_super:start_link().
start_link() ->
	supervisor:start_link({local, ?MODULE}, ?MODULE, []).


init(_Args) ->
	SupervisorSpec = #{
		strategy => simple_one_for_one,
		intensity => 10,
		period => 60},

	ChildSpec =
		[#{id => user_worker,
			start => {user_worker, start_link, [1,2,3]},
			restart => permanent,
			shutdown => 2000,
			type => worker,
			modules => [user_worker]}],
	{ok, {SupervisorSpec, ChildSpec}}.