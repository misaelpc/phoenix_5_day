defmodule CryptoMonitor2CursoWeb.ContentValidation do
  
  import Plug.Conn
  @auth_api "1122334455667788"
  
  def init(opts), do: opts

  def call(conn, _opts) do
    with  {:ok, conn, header_value} <- read_header(conn, "x-api-key"),
          {:ok, conn} <- validate_header(conn, header_value) do
      conn
    else
      {:error, reason} ->
        conn
          |> send_resp(400, reason)
          |> halt
    end
  end

  defp validate_header(conn, header_value) do
    case header_value == @auth_api do
      true ->
        {:ok, conn}
      false ->
        {:error, "Api key invalid"}
    end
  end

  defp read_header(conn, header) do
    case get_req_header(conn, header) do
      [] ->
        {:error, "El header #{header} es requerido"}
      [header_value] ->
        conn = assign(conn, String.to_atom(header), header_value)
        {:ok, conn, header_value}
    end
  end


end