defmodule Hawkeye.ARS.Recipe do
  use Ecto.Schema
  alias Hawkeye.Repo
  import Ecto.Changeset


  schema "recipes" do
    field :keyword, {:array, :string}
    field :title, :string
    belongs_to :parent, __MODULE__
    field :is_public, :boolean, default: false
    has_one :action, Hawkeye.ARS.Action, foreign_key: :action_recipe_id
    many_to_many :items, Hawkeye.ARS.Item, join_through: Hawkeye.ARS.RecipeItem, on_replace: :delete

    timestamps()
  end

  @doc false
  def update_changeset(recipe, items) do
    recipe
    |> change
    |> put_assoc(:items, items)
  end
  
  def changeset(recipe, attrs) do
    recipe
    |> cast(attrs, [:title, :keyword, :is_public, :parent_id])
    |> validate_required([:title, :keyword, :is_public])
    |> cast_assoc(:items, required: true)
  end

  def put_changeset(recipe, attrs) do
    recipe
    |> Repo.preload(:items)
    |> cast(attrs, [:title, :keyword, :is_public, :parent_id])
    |> validate_required([:title, :keyword, :is_public])
    |> put_assoc(:items, attrs.items)
  end


end
