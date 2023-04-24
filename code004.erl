%% WAP to create CLI Calculator
-module(calculator).
-export([run/0]).

run() ->
    io:format("Enter first number: "),
    {ok, [Num1]} = io:fread("","~d"),

    io:format("Enter second number: "),
    {ok, [Num2]} = io:fread("","~d"),

    io:format("Enter operator (+, -, *, /): "),
    {ok, [Op]} = io:fread("","~s"),

    case Op of
        "+" ->
            io:format("Result: ~w~n", [Num1 + Num2]);
        "-" ->
            io:format("Result: ~w~n", [Num1 - Num2]);
        "*" ->
            io:format("Result: ~w~n", [Num1 * Num2]);
        "/" ->
            case Num2 of
                0 ->
                    io:format("Error: division by zero~n");
                _ ->
                    io:format("Result: ~.2f~n", [Num1 / Num2])
            end;
        _ ->
            io:format("Error: unknown operator '~s'~n", [Op])
    end.
