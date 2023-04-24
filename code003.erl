%% WAP which accepts a password from the user, stores the password in a file, and verifies it when the user enters it again

-module(password).
-export([run/0]).

run() ->
    %% Read password from user
    Password = read_password(),

    %% Write password to file
    file:write_file("password.txt", Password),

    %% Verify password from user
    case verify_password(read_password()) of
        true ->
            io:format("Password verified.~n");
        false ->
            io:format("Incorrect password.~n")
    end.

read_password() ->
    %% Read password from user
    io:format("Enter password: "),
    {ok, [Password]} = io:fread("","~s"),
    Password.

verify_password(Expected) ->
    %% Read password from file
    {ok, [Actual]} = file:consult("password.txt"),

    %% Compare passwords
    Expected == Actual.
