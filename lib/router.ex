defmodule HabboApi.Router do
    use Plug.Router

    plug HabboApi.Router.Middlewares.JSON
    plug CORSPlug, [headers: ["client-id" | CORSPlug.defaults[:headers]]]
    plug Plug.Parsers, parsers: [:json], json_decoder: Poison
    plug :match
    plug :dispatch

    post "/authentication/register", do: conn |> HabboApi.Router.Authentication.register
    post "/authentication/login", do: conn |> HabboApi.Router.Authentication.login
    post "/authentication/facebook", do: conn |> HabboApi.Router.Authentication.facebook

    get "/client/url", do: conn |> HabboApi.Router.Client.url
    get "/client/sso/:hash", do: conn |> HabboApi.Router.Client.sso

    match _ do
        conn |> send_resp(404, "404 not found" |> Poison.encode!)
    end
end