defmodule CoffeeShops.Repo do
  use Ecto.Repo,
    otp_app: :coffee_shops,
    adapter: Ecto.Adapters.Postgres
end
