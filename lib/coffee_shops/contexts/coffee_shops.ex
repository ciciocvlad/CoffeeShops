defmodule CoffeeShops.Contexts.CoffeeShops do
  @moduledoc """
  Module used to retrieve data
  """

  @url "https://static.reasig.ro/interview/coffee_shops_exerceise/coffee_shops.csv"

  def list_coffee_shops do
    with {:ok, response} <- HTTPoison.get(@url), 200 <- response.status_code do
      {:ok, response.body}
    else
      _ -> {:error, "Could not read CSV data"}
    end
  end
end
