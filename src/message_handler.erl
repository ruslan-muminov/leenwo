-module(message_handler).
-export([proc/1]).

-include("records.hrl").

proc(JsonMessage) ->
	MapMessage = json_body_to_map(JsonMessage),
	Message = parse_map_message(MapMessage),
	ChatId = get_chat_id_from_message(Message),
	handle_chat_id(ChatId, Message).


json_body_to_map([{JsonBin, true}]) ->
	jsone:decode(JsonBin);
json_body_to_map(Body) ->
	io:format("wrong body format: ~p~n", [Body]),
	undefined.


parse_map_message(#{<<"message">> := Message, <<"update_id">> := UpdateId}) ->
	#{<<"id">>         := ChatId}   = maps:get(<<"chat">>, Message),
	#{<<"date">>       := Date,
	  <<"message_id">> := MessageId,
	  <<"text">>       := Text}     = Message,
	#{<<"first_name">> := FirstName, 
	  <<"username">>   := Username} = maps:get(<<"from">>, Message),

	#message{chat_id    = ChatId,
	         message_id = MessageId,
	         date       = Date,
	         first_name = FirstName,
	         username   = Username,
	         update_id  = UpdateId,
	         text       = Text};
parse_map_message(Other) ->
	io:format("wrong message format: ~p~n", [Other]),
	undefined.


get_chat_id_from_message(#message{chat_id = ChatId}) ->
	ChatId.


% message_to_user(#message{chat_id = ChatId, 
% 						 first_name = FirstName,
% 						 username = Username}) ->
% 	#user{chat_id = ChatId, first_name = FirstName, username = Username}.


handle_chat_id(ChatId, Message) ->
	user_super:handle_user(ChatId, Message).