-module(matrix).
-export([multiply/2, inverse/1]).

%% Multiplies two matrices
multiply(A, B) ->
    N1 = length(A), N2 = length(B), N3 = length(B !! 1),
    if N2 /= length(A !! 1) -> error;
       true -> [[sum([lists:nth(K, lists:nth(I, A)) * lists:nth(J, lists:transpose(B)) || K <- lists:seq(1, N2)]) || J <- lists:seq(1, N3)] || I <- lists:seq(1, N1)]
    end.

%% Inverts a matrix
inverse(A) ->
    %% check if A is square matrix
    N = length(A), 
    if N /= length(A !! 1) -> error;
       true ->
           %% Create augmented matrix
           Aug = [[A !! I ++ [if I == J -> 1; true -> 0 end] || J <- lists:seq(1, N)] || I <- lists:seq(1, N)],
           %% Gaussian elimination to get reduced row echelon form
           Red = reduce_row_echelon(Aug),
           %% Extract inverse matrix
           [[Red !! I ++ [Red !! I2 !! J] || J <- lists:seq(N+1, N*2)] || I <- lists:seq(1, N)]
    end.

%% Reduce an augmented matrix to reduced row echelon form
reduce_row_echelon(Aug) ->
    %% find pivot elements
    PivotCols = pivot_cols(Aug, 1, []),
    case PivotCols of
        [] -> Aug;
        [PivotCol | Rest] ->
            Pivot = lists:nth(PivotCol, lists:nth(PivotCol, Aug)),
            Row = get_pivot_row(Aug, PivotCol),
            Red = reduce_rows(Aug, PivotCol, Row),
            reduce_row_echelon(Red)
    end.

%% Find the columns of pivot elements
pivot_cols(Aug, Col, Acc) ->
    if Col > length(Aug !! 1) -> Acc;
       true -> 
           case find_pivot(Aug, Col) of
               none -> pivot_cols(Aug, Col+1, Acc);
               PivotCol -> pivot_cols(Aug, Col+1, [PivotCol|Acc])
           end
    end.

%% Find the row with a pivot element in a given column
get_pivot_row(Aug, Col) ->
    Pivot = lists:nth(Col, lists:nth(Col, Aug)),
    {_,Row} = lists:min([{abs(lists:nth(Col, Row)), Row} || Row <- lists:nthtail(Col, Aug)]),
    Row.

%% Reduce rows using a given pivot column and row
reduce_rows(Aug, PivotCol, Row) ->
    P = lists:nth(PivotCol, lists:nth(Row, Aug)),
    Red = [[if I == Row -> lists:map(fun(X) -> X/P end, lists:nthtail(PivotCol, lists:nth(Row, Aug))) ++ lists:nthtail(PivotCol+1, lists:nth(Row, Aug));
            true -> lists:map(fun(X) -> X-(P*lists:nth(K, lists:nth(I, Aug))) end, lists:nthtail(PivotCol, lists:nth(I, Aug))) ++ lists:nthtail(PivotCol+1, lists:nth(I, Aug)) end || I <- lists:seq(1, length(Aug))]],
    reduce_rows(Red, PivotCol+1, Row+1);
reduce_rows(Aug, _, _)
