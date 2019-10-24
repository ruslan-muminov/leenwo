-module(message_handler).
-export([proc/1]).

-record(message, {chat_id, message_id, date, first_name, username, update_id, text}).

proc(Message) ->
	MapMessage = json_body_to_map(Message),
	parse_map_message(MapMessage).


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