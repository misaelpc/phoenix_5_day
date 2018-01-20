defmodule CryptoMonitor.Bank do
  use Agent
  alias CryptoMonitor.Bank
  alias Crypto.User

  def start_link do
    Agent.start_link(fn -> %{"eth" => 0,
                             "eth_qty" => 100_000,
                             "btc_qty" => 100_000,
                             "btc" => 0} end, name: __MODULE__)
  end
  
  def update(key, value) do
    Agent.update(Bank, &Map.put(&1, key, value))
  end

  def get(key) do
    Agent.get(__MODULE__, &Map.get(&1, key))
  end

  def buy(currency, quantity, user) do
    sell_value = quantity * Bank.get(currency)
    with {:ok, _} <- User.commit_transaction(:buy, user, sell_value),
         {:ok, _} <- Bank.deliver_funds(currency, quantity),
         {:ok, _} <- User.increment_funds(user, currency, quantity)
    do
      {:ok, "Thank you"}
    else
      err -> err
    end
  end

  def deliver_funds(currency, quantity) do
    expend = Bank.get(currency <> "_qty") - quantity
    Bank.update(currency <> "_qty", expend)
    {:ok, "updated"}
  end
end