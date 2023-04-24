%% WAP which accepts marks of five subjects in an array, and calculates and prints the percentage, highest marks, subject name, and lowest marks:

-module(marks).
-export([calculate_marks/1]).

calculate_marks(Marks) ->
    %% Calculate total marks and percentage
    Total = lists:sum(Marks),
    Percentage = Total / (length(Marks) * 100) * 100,

    %% Find highest and lowest marks
    {Max, MaxSubject} = lists:max([{M, S} || {M, S} <- lists:zip(Marks, ["Subject1", "Subject2", "Subject3", "Subject4", "Subject5"])]),
    {Min, MinSubject} = lists:min([{M, S} || {M, S} <- lists:zip(Marks, ["Subject1", "Subject2", "Subject3", "Subject4", "Subject5"])]),

    %% Print results
    io:format("Total marks: ~w~n", [Total]),
    io:format("Percentage: ~.2f%~n", [Percentage]),
    io:format("Highest marks: ~w in ~s~n", [Max, MaxSubject]),
    io:format("Lowest marks: ~w in ~s~n", [Min, MinSubject]).