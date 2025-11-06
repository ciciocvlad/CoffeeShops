defmodule CoffeeShopsWeb.DistancesController do
  @moduledoc false

  use CoffeeShopsWeb, :controller

  import CoffeeShopsWeb.Utils.CoffeeShops

  def get_closest(conn, %{"x" => x, "y" => y}) do
    with {:ok, coffee_shops} <- get_closest_coffee_shops(x, y) do
      conn
      |> put_status(200)
      |> render(:index, %{coffee_shops: elem(coffee_shops, 1)})
    else
      {:error, error} -> conn |> put_status(400) |> render(:error, %{error: error})
    end
  end
end
