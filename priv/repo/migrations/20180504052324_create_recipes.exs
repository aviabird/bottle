defmodule Hawkeye.Repo.Migrations.CreateRecipes do
  use Ecto.Migration

  def change do
    create table(:recipes) do
      add :title, :string
      add :keyword, {:array, :string}
      add :is_public, :boolean, default: false
      add :parent_id, references(:recipes)

      timestamps()
    end

    create index(:recipes, [:parent_id])
  end
end
