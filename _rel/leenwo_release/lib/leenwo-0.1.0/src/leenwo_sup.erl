-module(leenwo_sup).
-behaviour(supervisor).

-export([start_link/0]).
-export([init/1]).

start_link() ->
	supervisor:start_link({local, ?MODULE}, ?MODULE, []).


init(_Args) ->
	SupervisorSpec = #{
		strategy => one_for_one,
		intensity => 10,
		period => 60
	},

	ChildSpec = [
		#{	id => timer_worker,
			start => {timer_worker, start_link, []},
			restart => permanent,
			shutdown => 2000,
			type => worker,
			modules => [timer_worker]
		},
		#{	id => user_sup,
			start => {user_sup, start_link, []},
			restart => permanent,
			shutdown => 2000,
			type => supervisor,
			modules => [user_sup]
		}
	],

	{ok, {SupervisorSpec, ChildSpec}}.
