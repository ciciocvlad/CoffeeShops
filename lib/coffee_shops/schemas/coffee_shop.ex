defmodule CoffeeShops.Schemas.CoffeeShop do
  use Ecto.Schema

  import Ecto.Changeset

  schema "coffee_shops" do
    field :title, :string
    field :x, :float
    field :y, :float

    timestamps(type: :utc_datetime)
  end

  @castable ~w(title x y)a

  @doc false
  def changeset(coffee_shop, attrs) do
    coffee_shop
    |> cast(attrs, @castable)
    |> validate_required(@castable)
  end
end
