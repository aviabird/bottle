defmodule Hawkeye.ARS.RecipeItem do
  use Ecto.Schema

  schema "recipe_items" do
    belongs_to :recipe, Hawkeye.ARS.Recipe
    belongs_to :item, Hawkeye.ARS.Item

    timestamps()
  end

end
