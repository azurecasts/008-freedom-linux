defmodule Freedom.HelloWorldPlug do
  import Plug.Conn

  def init(options), do: options

  def call(conn, _opts) do

    {:ok, res} = Redix.command(:redix, ["PING"])

    conn
    |> put_resp_content_type("text/html")
    |> send_resp(200, "<h2>Hello Elixirirs!</h2><p>Redis says <B>#{res}</p>\n")
  end
end
