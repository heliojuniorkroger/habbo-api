defmodule HabboApi do
    import Supervisor.Spec

    def start(_type, _args) do
        [
            {Plug.Cowboy, scheme: :http, plug: HabboApi.Router, options: [port: 9090]},
            worker(RethinkDB.Connection, [[name: :rethinkdb, host: "localhost", db: "habbo", port: 28015]])
        ] |> Supervisor.start_link(strategy: :one_for_one)
    end
end