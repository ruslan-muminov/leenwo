-module(rest_handler). 
-behavior(cowboy_rest). 

-export([init/2,allowed_methods/2]).
-export([content_types_provided/2,content_types_accepted/2]).
-export([to_json/2,from_json/2]). 

init(Req, State) -> 
	{cowboy_rest, Req, State}. 

allowed_methods(Req, State) -> 
	{[<<"GET">>, <<"POST">>], Req, State}. 


content_types_provided(Req, State) -> 
	{[{<<"application/json">>, to_json}], Req, State}. 


content_types_accepted(Req, State) -> 
	{[{<<"application/json">>, from_json}], Req, State}. 


to_json(Req, State) -> 
	{list_to_binary("{res : ok}"), Req, State}.  


from_json(Req, State) -> 
	{ok, Body, Req1} = cowboy_req:read_urlencoded_body(Req),
	message_handler:proc(Body),
	{true, Req1, State}.