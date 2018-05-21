defmodule Hawkeye.Repo.Migrations.CreateItems do
  use Ecto.Migration

  def change do
    create table(:items) do
      add :description, :string
      add :file_url, :string
      add :is_public, :boolean, default: false

      timestamps()
    end

  end
end
