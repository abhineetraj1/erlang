%% WAP to determine whether a number is odd or even in Erlang, you can use the modulo operator %. The modulo operator returns the remainder of a division operation. If a number is divisible by 2 without leaving a remainder, it is even. Otherwise, it is odd. Here's an example function that determines whether a number is odd or even:
-module(number_checker).
-export([check/1]).

check(Number) ->
    if
        Number rem 2 == 0 ->
            io:format("~w is even.~n", [Number]);
        true ->
            io:format("~w is odd.~n", [Number])
    end.
