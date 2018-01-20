defmodule CryptoMonitor.BTC do
  use GenServer
  alias CryptoMonitor.Bank

  def start_link(time) do
    GenServer.start_link(__MODULE__, time, [name: :btc_monitor])
  end

  def init(time) do
    refresh(time)
    {:ok, %{time: time, value: 0}}
  end

  def handle_info(:refresh, state) do
    %{time: time, value: value} = state
    new_val = update_data(value)
    refresh(time)
    {:noreply, %{time: time, value: new_val}}
  end

  defp update_data(value) do
    response = HTTPotion.get "https://min-api.cryptocompare.com/data/price?fsym=BTC&tsyms=USD,MXN"
    case HTTPotion.Response.success?(response) do
      true ->
        IO.inspect "update"
        %{"USD" => usd} = Poison.decode!(response.body)
        Bank.update("btc", usd)
        usd
      false ->
        value
    end
  end

  defp refresh(time_in_seconds) do
    Process.send_after(self(), :refresh, (time_in_seconds * 1000))
  end
end