defmodule CoffeeShopsWeb.DistancesJSON do
  def index(%{coffee_shops: coffee_shops}) do
    %{data: for(coffee_shop <- coffee_shops, do: data(coffee_shop))}
  end

  def error(%{error: error}) do
    %{error: error}
  end

  defp data(coffee_shop) do
    %{
      name: coffee_shop.name,
      location: coffee_shop.location,
      distance: coffee_shop.distance
    }
  end
end
