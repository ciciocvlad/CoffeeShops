defmodule CoffeeShops.Repo.Migrations.CreateCoffeeShops do
  use Ecto.Migration

  def change do
    create table(:coffee_shops) do
      add :title, :string
      add :x, :float
      add :y, :float

      timestamps(type: :utc_datetime)
    end
  end
end
