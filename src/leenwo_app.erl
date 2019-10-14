-module(leenwo_app).
-behaviour(application).

-export([start/2]).
-export([stop/1]).

start(_Type, _Args) ->
	Dispatch = cowboy_router:compile([
		{'_', [{"/hello", hello_handler, []},
			{"/leenwo/[...]", rest_handler, []}]}
	]),
	%{ok, _} = cowboy:start_clear(my_http_listener, 
	%	[{port, 8443}],
	%	#{env => #{dispatch => Dispatch}}
	%),
	%PrivDir = code:priv_dir(leenwo),
	{ok, _} = cowboy:start_tls(https, [
			{port, 8443},
			{certfile, "/etc/ssl/certs/leenwo.pem"}, 
			{keyfile, "/etc/ssl/private/leenwo.key"}
	], #{env => #{dispatch => Dispatch}}),
	leenwo_sup:start_link().

stop(_State) ->
	ok.
