defmodule Hawkeye.Repo.Migrations.CreateFeedbacks do
  use Ecto.Migration

  def change do
    create table(:feedbacks) do
      add :value, :decimal
      add :action_id, references(:actions, on_delete: :nothing)
      add :action_recipe_id, references(:recipes, on_delete: :nothing)

      timestamps()
    end

    create index(:feedbacks, [:action_id])
    create index(:feedbacks, [:action_recipe_id])
  end
end
