# DrabUmb

An example of a drab app running in an umbrella with server: false and the websockets routing correctly

In this example use MIX_ENV=dev  
localhost:4000 should route to the Unf.Endpoint, and 127.0.0.1:4000 should route to the DrabExampl.Endpoint

the key to getting this to work is to use the risky dispatch option from phoenix

(https://github.com/jschoch/drab_umbrella_example/blob/master/apps/rtr/config/dev.exs#L25-L34)

Below is a working config for the dev enf

```elixir
config :rtr, Rtr.Endpoint,
  http: [
    port: 4000,
    dispatch: [
      {:_, [
        {"/socket/websocket", Phoenix.Endpoint.CowboyWebSocket, {Phoenix.Transports.WebSocket,
            {DrabExample.Endpoint, DrabExample.UserSocket, :websocket}}},
        {"/phoenix/live_reload/socket/websocket", Phoenix.Endpoint.CowboyWebSocket,
          {Phoenix.Transports.WebSocket, {DrabExample.Endpoint, Phoenix.LiveReloader.Socket, :websocket}}
        },
        {:_, Plug.Adapters.Cowboy.Handler, {Rtr.Endpoint, []}}
      ]}]
  ],
  debug_errors: true,
  code_reloader: true,
  check_origin: false,
  watchers: []

```
Then I used a plug to select the other host routes based on the conn.host

https://github.com/jschoch/drab_umbrella_example/blob/master/apps/rtr/lib/umb.ex
```elixir
defmodule URtr do
    require Logger
    import Plug.Conn

    @doc false
    def init(default), do: default

    @doc false
    def call(conn, _router) do
      Logger.error "host " <> conn.host <> "path " <> conn.request_path
      case conn.host do
        "localhost" ->
          Logger.error "localhost"
          UnfWeb.Endpoint.call(conn,[])
            |> halt
        "127.0.0.1" ->
           Logger.error "127"
           DrabExample.Endpoint.call(conn,[])
             |> halt
        any -> 
          Logger.error "any"
          UnfWeb.Endpoint.call(conn,[])
            |> halt
      end
    end
end
```




Wondering how to support multiple drab hosts behind a single router


Along the way I found a few examples that help understand how this works

https://elixirforum.com/t/dynamic-phoenix-routes-using-ets-with-sockets-and-channels/1613
https://elixirforum.com/t/plan-old-websockets-in-phoenix-but-without-magic/10074/19
https://elixirforum.com/t/umbrella-apps-on-heroku-channels-not-connecting/8039/2



