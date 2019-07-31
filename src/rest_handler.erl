-module(rest_handler). 
-behavior(cowboy_rest). 

-export([init/2,allowed_methods/2,content_types_provided/2,content_types_accepted/2]).
-export([to_json/2,to_text/2,from_text/2,from_json/2]). 

init(Req, State) -> 
	{cowboy_rest, Req, State}. 

allowed_methods(Req, State) -> 
	Methods = [<<"GET">>, <<"POST">>], 
	{Methods, Req, State}. 

% for GET 
content_types_provided(Req, State) -> 
	io:format("content_types_provided~n"),
	io:format("Path Info: ~p~n", [cowboy_req:path_info(Req)]),
	io:format("Body: ~p~n", [cowboy_req:read_urlencoded_body(Req)]),
	%io:format("content_types_provided: Req=~p State=~p~n", [Req, State]),
	{[ {<<"application/json">>, to_json}, 
	   {<<"application/x-www-form-urlencode">>, to_text},
	   {<<"text/plain">>, to_text} ], 
	Req, State}. 

% for POST 
content_types_accepted(Req, State) -> 
	io:format("content_types_accepted~n"),
	%io:format("content_types_accepted: Req=~p State=~p~n", [Req, State]),
	{[ {<<"text/plain">>, from_text}, 
	   {<<"application/json">>, from_json},
	   {<<"application/x-www-form-urlencoded">>, from_text} 
	], Req, State}. 

to_json(Req, State) -> 
	io:format("to_json: Req=~p State=~p~n", [Req, State]),
	{list_to_binary("{res : ok}"), Req, State}. 

to_text(Req, State) -> 
	io:format("to_text: Req=~p State=~p~n", [Req, State]),
	{list_to_binary("ok"), Req, State}. 

from_text(Req, State) -> 
	io:format("from_text: Req=~p State=~p~n", [Req, State]),
	{ok, Body, Req1} = cowboy_req:read_urlencoded_body(Req),
	io:format("Body: ~p~n", [Body]),
	{true, Req1, State}. 

from_json(Req, State) -> 
	io:format("from_json: Req=~p State=~p~n", [Req, State]),
	{true, Req, State}.
