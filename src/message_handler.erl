-module(message_handler).
-export([proc/1]).

proc(Message) ->
	json_body_to_map(Message),
	ok.

% Body: [{<<"{\"update_id\":702475916,\n\"message\":{\"message_id\":38,\"from\":{\"id\":70487131,\"is_bot\":false,\"first_name\":\"Ruslan\",\"username\":\"rusik_pusik_sidodgi_skrskr\",\"language_code\":\"ru\"},\"chat\":{\"id\":70487131,\"first_name\":\"Ruslan\",\"username\":\"rusik_pusik_sidodgi_skrskr\",\"type\":\"private\"},\"date\":1571775755,\"text\":\"Ahhaha\"}}">>,
%         true}]
json_body_to_map([{JsonBin, true}]) ->
	jsone:decode(JsonBin);
json_body_to_map(Body) ->
	io:format("wrong body format: ~p~n", [Body]),
	undefined.