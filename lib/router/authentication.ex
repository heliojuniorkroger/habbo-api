defmodule HabboApi.Router.Authentication do
    import Plug.Conn
    import RethinkDB.Lambda
    alias HabboApi.Models.User, as: User

    def register(conn) do
        body = conn.body_params

        res = User.filter(lambda fn (user) ->
            user[:email] == body["email"] || user[:username] == body["username"]
        end)

        if res.data == [] do
            res = %User{
                username: User.get_username,
                email: body["email"],
                password: body["password"] |> Comeonin.Bcrypt.hashpwsalt
            } |> User.create

            conn
            |> send_resp(200, (res.data["changes"] |> hd)["new_val"] |> Poison.encode!)
        else
            user = res.data |> hd

            msg = if user["email"] == body["email"] do
                "Email already registered"
            else
                "Username already registered"
            end

            conn |> send_resp(400, msg |> Poison.encode!)
        end
    end

    def login(conn) do
        body = conn.body_params

        res = %{email: body["email"]} |> User.filter

        if res.data == [] do
            conn |> send_resp(400, "Invalid email" |> Poison.encode!)
        else
            user = res.data |> hd

            if body["password"] |> Comeonin.Bcrypt.checkpw(user["password"]) do
                conn |> send_resp(200, user |> Poison.encode!)
            else
                conn |> send_resp(400, "Invalid password" |> Poison.encode!)
            end
        end
    end

    def facebook(conn) do
        body = conn.body_params

        res = %{fb_id: body["id"]} |> User.filter

        user = if res.data == [] do
                res = %User{
                    username: User.get_username,
                    email: body["email"],
                    fb_id: body["id"]
                } |> User.create

                (res.data["changes"] |> hd)["new_val"]
            else
                res.data |> hd
            end

        conn |> send_resp(200, user |> Poison.encode!) 
    end
end