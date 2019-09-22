-module(user_proc).
-export([init/2,set_words_number/2]).

%% after USER send /start
init(State, _Data) ->
	% save Data to DB: Data = chat_id

	% send answer to USER: DESCRIPTION ++ "How many words are you want to learn?"

	% change State: chat_id = Data, status = init
	NewState = State,
	NewState.


%% after USER answer the question: "How many words are you want to learn?"
set_words_number(State, _Data) ->
	% save Data to DB : Data = numWords

	% send answer to USER: 

	% change State: status = ready
	NewState = State,
	NewState.