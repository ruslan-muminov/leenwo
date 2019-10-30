-module(message_handler).
-export([proc/1]).

-include("records.hrl").

proc(JsonMessage) ->
	MapMessage = json_body_to_map(JsonMessage),
	Message = parse_map_message(MapMessage),
	TextMessage = get_text_from_message(Message),
	handle_message_text(TextMessage, Message).


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


get_text_from_message(#message{text = Text}) ->
	Text.


message_to_user(#message{chat_id = ChatId, 
						 first_name = FirstName,
						 username = Username}) ->
	#user{chat_id = ChatId, first_name = FirstName, username = Username}.


handle_message_text(<<"/start">>, Message) ->
	db_lib:update_user(message_to_user(Message));
	%user_proc:init(Message);
handle_message_text(_, Message) ->
	io:format("message is received: ~p~n", [Message]).