defmodule MyheroacademyapiWeb.Router do
  use MyheroacademyapiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", MyheroacademyapiWeb do
    pipe_through :api
  end
end
