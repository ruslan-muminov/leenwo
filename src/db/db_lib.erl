-module(db_lib).
-export([update_user/1, is_user_exist/1]).

-include("records.hrl").


update_user(User) when is_record(User, user) ->
    mnesia:dirty_write(User);
update_user(Other) ->
    io:format("db_lib:update_user(~p)~n", [Other]).


is_user_exist(ChatId) ->
	case mnesia:dirty_read(user, ChatId) of
		[] -> false;
		_ -> true
	end.