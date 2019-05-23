{application, 'leenwo', [
	{description, "Web server for telegram bot for learning english words"},
	{vsn, "0.1.0"},
	{modules, ['leenwo_app','leenwo_sup']},
	{registered, [leenwo_sup]},
	{applications, [kernel,stdlib,cowboy]},
	{mod, {leenwo_app, []}},
	{env, []}
]}.