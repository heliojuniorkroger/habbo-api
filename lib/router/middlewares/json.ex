defmodule HabboApi.Router.Middlewares.JSON do
    import Plug.Conn

    def init(options), do: options

    def call(conn, _opts) do
        conn |> put_resp_content_type("application/json")
    end
end