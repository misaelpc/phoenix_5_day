defmodule CryptoMonitor2CursoWeb.UserController do
  use CryptoMonitor2CursoWeb, :controller
  alias Crypto.User
  action_fallback  CryptoMonitor2CursoWeb.ErrorFallBackUserController

  def signup(conn, params) do
    changeset = User.signup_changeset(%User{}, params["user"])
    if changeset.valid? do
      user_name = params["user"]["name"]
      pin = params["user"]["pin"]
      User.create(changeset)
      conn
        |> put_session(:user, user_name)
        |> put_session(:token, pin)
        |> redirect(to: "/balance")
    else
      changeset.errors
    end
  end
end
