-module(user_worker).
-behaviour(gen_server).

-export([start_link/2,init/1,handle_cast/2,handle_call/3]).
-export([get_user_worker_name/1]).


start_link(ChatId, Message) ->
	Name = get_user_worker_name(?MODULE),
	gen_server:start_link({local, Name}, ?MODULE, [ChatId, Message], []).


init([_ChatId, Message]) ->
	User = message_handler:message_to_user(Message),
	db_lib:update_user(User),

	% (2) create user_schedule, if absent
	{ok, []}.


handle_call(Request, _From, State) ->
	{reply, Request, State}.


handle_cast(_Request, State) ->
	{noreply, State}.


%%%--------------------------------------------------------------

get_user_worker_name(ChatId) ->
	ModuleName = atom_to_binary(?MODULE, utf8),
	binary_to_atom(<<ModuleName/binary, "_", ChatId/binary>>, utf8).