defmodule Hawkeye.ARS.Action do
  use Ecto.Schema
  alias Hawkeye.Repo
  import Ecto.Changeset


  schema "actions" do
    field :description, :string
    field :location, :string
    field :timestamp, Ecto.DateTime
    field :title, :string
    belongs_to :action_recipe, Hawkeye.ARS.Recipe, on_replace: :update

    timestamps()
  end

  @doc false
  def changeset(action, attrs) do
    action
    |> cast(attrs, [:title, :description, :location, :timestamp, :action_recipe])
    |> validate_required([:title, :description, :location, :timestamp])
    |> cast_assoc(:action_recipe, required: true, with: &Hawkeye.ARS.Recipe.changeset/2)
  end

  def create_changeset(action, attrs) do
    action
    |> Repo.preload(:action_recipe)
    |> cast(attrs, [:title, :description, :location, :timestamp])
    |> validate_required([:title, :description, :location, :timestamp])
    |> put_assoc(:action_recipe, attrs.action_recipe)
  end

  def update_changeset(action) do
    action
    |> change
    |> put_change(:action_recipe_id, action.action_recipe.id)
  end
end

