defmodule CoffeeShopsWeb.DistancesJSON do
  def index(%{coffee_shops: coffee_shops}) do
    %{data: for(coffee_shop <- coffee_shops, do: coffee_shop)}
  end

  def error(%{error: error}) do
    %{error: error}
  end
end
