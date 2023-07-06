-module(web_crawler).
-export([start/1]).

% Start the web crawler
start(SeedUrl) ->
    crawl(SeedUrl, []).

% Web crawling function
crawl(Url, Visited) ->
    case lists:member(Url, Visited) of
        true ->
            io:format("Already visited: ~s~n", [Url]);
        false ->
            case httpc:request(get, {Url, []}, [], []) of
                {ok, {{_Version, 200, _ReasonPhrase}, _Headers, Body}} ->
                    io:format("Visited: ~s~n", [Url]),
                    VisitedUrls = [Url | Visited],
                    Links = extract_links(Body),
                    spawn_link(fun() -> crawl_url(Links, VisitedUrls) end),
                    ok;
                {ok, {{_Version, Code, ReasonPhrase}, _Headers, _Body}} ->
                    io:format("Error ~p: ~s~n", [Code, ReasonPhrase]);
                {error, Reason} ->
                    io:format("Error: ~p~n", [Reason])
            end
    end.

% Extract links from HTML body
extract_links(Body) ->
    {ok, {_, _, Links}} = xmerl_scan:string(Body),
    [Url || {url, _, Url} <- Links].

% Crawl each URL in parallel
crawl_url(Urls, Visited) ->
    lists:foreach(fun(Url) -> crawl(Url, Visited) end, Urls).
