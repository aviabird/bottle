defmodule Hawkeye.ARS.Efficacy do
  use Ecto.Schema
  import Ecto.Changeset


  schema "efficacies" do
    field :value, :decimal
    field :action_id, :id
    field :action_recipe_id, :id
    field :action_item_id, :id

    timestamps()
  end

  @doc false
  def changeset(efficacy, attrs) do
    efficacy
    |> cast(attrs, [:value])
    |> validate_required([:value])
  end
end
