defmodule CryptoMonitor2CursoWeb.Router do
  use CryptoMonitor2CursoWeb, :router
  alias Crypto.Authentication
  
  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
    plug CryptoMonitor2CursoWeb.ContentValidation
  end

  pipeline :auth do
    plug :authenticate
  end

  scope "/", CryptoMonitor2CursoWeb do
    pipe_through :browser # Use the default browser stack
    get "/", CryptoController, :index
    get "/bussines", CryptoController, :bussines
    post "/signup", UserController, :signup
  end

  scope "/", CryptoMonitor2CursoWeb do
    pipe_through :browser # Use the default browser stack
    pipe_through :auth # Use auth browser stack
    get "/balance", CryptoController, :balance
  end

  # Other scopes may use custom stacks.
  scope "/api/v1", CryptoMonitor2CursoWeb do
    pipe_through :api
    post "/users", PageController, :create
  end

  defp authenticate(conn, _params) do
    if Authentication.authenticated?(conn) do
      conn
    else
      conn
      |> redirect(to: "/bussines")
      |> halt
    end
  end
end
