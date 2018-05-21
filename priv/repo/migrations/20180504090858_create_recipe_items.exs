defmodule Hawkeye.Repo.Migrations.CreateRecipeItems do
  use Ecto.Migration

  def change do
    create table(:recipe_items) do
      add :recipe_id, references(:recipes, on_delete: :nothing)
      add :item_id, references(:items, on_delete: :nothing)

      timestamps()
    end

    create index(:recipe_items, [:recipe_id])
    create index(:recipe_items, [:item_id])
  end
end
