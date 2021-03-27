defmodule MyheroacademyapiWeb.Router do
  use MyheroacademyapiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", MyheroacademyapiWeb do
    pipe_through :api

    resources "/heros", HeroController, except: [:new, :edit]
    resources "/quirks", QuirkController, except: [:new, :edit]
  end
end
