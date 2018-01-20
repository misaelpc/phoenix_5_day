defmodule Crypto.Currency do
  use Ecto.Schema
  import Ecto.Changeset

  schema "currency" do
    field :name
    field :quantity
  end

  def changeset(currency, params \\ :empty) do
    currency
      |> cast(params, [:quantity, :name])
  end
end