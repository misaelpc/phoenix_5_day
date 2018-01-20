defmodule CryptoMonitor2CursoWeb.PageControllerTest do
  use CryptoMonitor2CursoWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "Welcome to Phoenix!"
  end
end
