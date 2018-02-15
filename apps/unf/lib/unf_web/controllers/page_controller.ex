defmodule UnfWeb.PageController do
  use UnfWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
