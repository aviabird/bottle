defmodule Hawkeye.ARS.Feedback do
  use Ecto.Schema
  import Ecto.Changeset


  schema "feedbacks" do
    field :value, :decimal
    field :action_id, :id
    field :action_recipe_id, :id

    timestamps()
  end

  @doc false
  def changeset(feedback, attrs) do
    feedback
    |> cast(attrs, [:value])
    |> validate_required([:value])
  end
end
