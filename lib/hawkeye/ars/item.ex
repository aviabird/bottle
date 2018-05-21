defmodule Hawkeye.ARS.Item do
  use Ecto.Schema
  import Ecto.Changeset


  schema "items" do
    field :description, :string
    field :file_url, :string
    field :is_public, :boolean, default: false

    timestamps()
  end

  @doc false
  def changeset(item, attrs) do
    item
    |> cast(attrs, [:description, :file_url, :is_public])
    |> validate_required([:description, :file_url, :is_public])
    |> validate_length(:description, min: 10)
    |> validate_length(:file_url, min: 6)
  end
end
