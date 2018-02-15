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
