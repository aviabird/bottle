defmodule Hawkeye.Repo.Migrations.CreateActions do
  use Ecto.Migration

  def change do
    create table(:actions) do
      add :title, :string
      add :description, :string
      add :location, :string
      add :timestamp, :datetime
      add :action_recipe_id, references(:recipes, on_delete: :nothing)

      timestamps()
    end

    create index(:actions, [:action_recipe_id])
  end
end
