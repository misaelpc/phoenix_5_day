defmodule CryptoMonitor2CursoWeb.ErrorFallBackCurrencyController do
  use CryptoMonitor2CursoWeb, :controller

  def call(conn, [invalid_data: {message_error, []}]) do
    conn
      |> put_flash(:error, message_error)
      |> redirect(to: "/balance")
  end
end