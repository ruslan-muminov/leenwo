{application, 'leenwo', [
	{description, "Web server for telegram bot for learning english words"},
	{vsn, "0.1.0"},
	{modules, ['hello_handler','leenwo_app','leenwo_sup','rest_handler','timer_worker','user_proc','user_super','user_worker']},
	{registered, [leenwo_sup]},
	{applications, [kernel,stdlib,cowboy,jsone]},
	{mod, {leenwo_app, []}},
	{env, []}
]}.