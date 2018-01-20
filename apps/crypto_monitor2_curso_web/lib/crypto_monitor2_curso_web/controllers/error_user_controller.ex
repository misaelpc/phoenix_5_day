defmodule CryptoMonitor2CursoWeb.ErrorFallBackUserController do
  use CryptoMonitor2CursoWeb, :controller
  alias Crypto.User

  def call(conn, [wrong_pin: {message_error, []}]) do
    changeset = User.changeset(%User{}, %{})
    conn
      |> put_flash(:error, message_error)
      |> render("bussines.html", changeset: changeset)
  end

  def call(conn, [btc: {"is invalid", [type: :decimal, validation: :cast]}]) do
    conn
     |> put_status(400)
     |> json(%{error: "Incorrect type for btc, expected decimal"}) 
  end

  def call(conn, failure_params) do
    IO.inspect failure_params
    conn
     |> put_status(400)
     |> json(%{error: "something went wrong"}) 
  end
end