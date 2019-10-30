-record(user, {chat_id,
               first_name,
               username}).

-record(message, {chat_id,
                  message_id,
                  date,
                  first_name,
                  username,
                  update_id,
                  text}).