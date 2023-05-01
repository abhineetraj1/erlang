%% WAP to accept grades and print percentage

-module(calculator)
-export([run/0])

run() ->
	io:format("Enter your marks in subject A:"),
	{"ok",[a]} = io:fread("","~d"),
	
	io:format("Enter your marks in subject B:"),
	{"ok",[b]} = io:fread("","~d"),
	
	io:format("Enter your marks in subject C:"),
	{"ok",[c]} = io:fread("","~d"),
	
	io:format("Your percentage is: ~w~n",[a/3 +b/3 +c/3 ])
