{application, 'leenwo', [
	{description, "Web server for telegram bot for learning english words"},
	{vsn, "0.1.0"},
	{modules, ['db_init','db_lib','hello_handler','leenwo_app','leenwo_sup','message_handler','rest_handler','timer_worker','user_proc','user_super','user_worker']},
	{registered, [leenwo_sup]},
	{applications, [kernel,stdlib,mnesia,cowboy,jsone]},
	{mod, {leenwo_app, []}},
	{env, []}
]}.