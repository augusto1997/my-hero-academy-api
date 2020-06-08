defmodule MyheroacademyapiWeb.Router do
  use MyheroacademyapiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", MyheroacademyapiWeb do
    pipe_through :api

    resources "/heros", HeroController, except: [:new, :edit]
  end

  scope "/docs/swagger" do
    forward "/", PhoenixSwagger.Plug.SwaggerUI, otp_app: :myheroacademyapi, swagger_file: "swagger.json"
  end

  def swagger_info do
    %{
      info: %{
        version: "1.0",
        title: "My Hero Academy API"
      }
    }
  end
end
