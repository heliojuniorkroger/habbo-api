defmodule HabboApi.Router.Client do
    import Plug.Conn
    alias HabboApi.Models.User, as: User

    @client_url "http://localhost:5050"

    def url(conn) do
        hash = "hbbr-#{Nanoid.generate}"

        conn |> get_req_header("client-id") |> hd
        |> User.get_and_update(%{hash: hash})
        
        conn |> send_resp(200, %{url: "#{@client_url}/client/#{hash}"} |> Poison.encode!)
    end

    def sso(conn) do
        sso = Nanoid.generate

        res = %{hash: conn.path_params["hash"]}
        |> User.filter_and_update(%{hash: nil, sso: sso})

        if res.data["replaced"] == 0 do
            conn |> send_resp(404, "Hash not found")
        else
            conn |> send_resp(200, %{sso: sso} |> Poison.encode!)
        end
    end
end