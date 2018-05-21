defmodule Hawkeye.Repo.Migrations.CreateEfficacies do
  use Ecto.Migration

  def change do
    create table(:efficacies) do
      add :value, :decimal
      add :action_id, references(:actions, on_delete: :nothing)
      add :action_recipe_id, references(:recipes, on_delete: :nothing)
      add :action_item_id, references(:items, on_delete: :nothing)

      timestamps()
    end

    create index(:efficacies, [:action_id])
    create index(:efficacies, [:action_recipe_id])
    create index(:efficacies, [:action_item_id])
  end
end
