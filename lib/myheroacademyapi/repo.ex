defmodule Myheroacademyapi.Repo do
  use Ecto.Repo,
    otp_app: :myheroacademyapi,
    adapter: Ecto.Adapters.Postgres
end
