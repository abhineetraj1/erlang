-module(my_server).
-export([start/0]).

start() ->
    {ok, ListenSocket} = gen_tcp:listen(8080, [{active, false}, {reuseaddr, true}]),
    accept_clients(ListenSocket).

accept_clients(ListenSocket) ->
    {ok, ClientSocket} = gen_tcp:accept(ListenSocket),
    spawn(fun() -> handle_client(ClientSocket) end),
    accept_clients(ListenSocket).

handle_client(Socket) ->
    loop(Socket).

loop(Socket) ->
    case gen_tcp:recv(Socket, 0) of
        {ok, Data} ->
            handle_data(Socket, Data),
            loop(Socket);
        {error, _} ->
            gen_tcp:close(Socket)
    end.

handle_data(Socket, Data) ->
    % process the received data
    io:format("Received: ~s~n", [Data]),
    % send a response
    gen_tcp:send(Socket, "OK").


% to start server
%  1> c(my_server).
%  {ok,my_server}
%  2> my_server:start().
