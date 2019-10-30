-module(db_init).
-export([create/0]).

-include("records.hrl").

create() ->
	mnesia:stop(),
    mnesia:create_schema([node()]),
    mnesia:start(),
    create_tables().


create_tables() ->
    mnesia:create_table(user, [{attributes, record_info(fields, user)},
                               {disc_copies, [node()]}]).