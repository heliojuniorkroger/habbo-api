defmodule HabboApi.Models.User do
    defstruct username: nil,
    password: nil,
    email: nil,
    fb_id: nil,
    look: "ea-9036-76-1408.ch-660-92.lg-3006-110-110.hr-9534-45.hd-629-1.sh-71429789-110-1408",
    gender: "M",
    credits: 100,
    registered_at: Timex.now |> Timex.to_unix

    def create(user) do
        RethinkDB.Query.table("users")
        |> RethinkDB.Query.insert(user |> Map.from_struct, %{return_changes: true})
        |> RethinkDB.run(:rethinkdb)
    end

    def filter(filters) do
        RethinkDB.Query.table("users")
        |> RethinkDB.Query.filter(filters)
        |> RethinkDB.run(:rethinkdb)
    end

    def filter_and_update(filters, data) do
        RethinkDB.Query.table("users")
        |> RethinkDB.Query.filter(filters)
        |> RethinkDB.Query.update(data)
        |> RethinkDB.run(:rethinkdb)
    end

    def get_and_update(id, data) do
        RethinkDB.Query.table("users")
        |> RethinkDB.Query.get(id)
        |> RethinkDB.Query.update(data)
        |> RethinkDB.run(:rethinkdb)
    end
end