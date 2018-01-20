defmodule CryptoMonitor2CursoWeb.PageController do
  use CryptoMonitor2CursoWeb, :controller
  action_fallback  CryptoMonitor2CursoWeb.ErrorFallBackUserController
  alias Crypto.User
  def index(conn, _params) do
    render conn, "index.html"
  end

  def create(conn, params) do
    IO.inspect self
    changeset = User.changeset(%Crypto.User{},params)
    case changeset.valid? do
      true ->
        user = User.create(changeset)
        conn  
          |> put_status(201)
          |> json(%{user: %{name: user.name}})
      false ->
        changeset.errors
    end
  end
end
