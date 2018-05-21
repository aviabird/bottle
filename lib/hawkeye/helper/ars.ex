defmodule Hawkeye.ARS.Catalog do
  alias Hawkeye.ARS.{Action, Item , Recipe, RecipeItem}
  alias Hawkeye.Repo
  import Ecto.Query
  
  def list_actions do
    Action |> Repo.all
  end

  def list_public_items do
    from(item in Item, where: item.is_public == :true) |> Repo.all()
  end

  def list_public_recipes do
    from(recipe in Recipe, where: recipe.is_public == :true) |> Repo.all()
  end

  def get_action(id), do: Action |> Repo.get!(id) |> Repo.preload(action_recipe: :items)

  def get_recipe(id), do: Recipe |> Repo.get!(id) |> Repo.preload(:items)

  def get_item(id), do: Item |> Repo.get!(id)

  def build_action(attrs \\ %{}) do 
	%Action{} 
	|> Action.changeset(attrs)
  end

  def create_action(attrs) do	 
	attrs
	|> build_action
	|> Repo.insert
  end

  def build_item(attrs \\ %{}) do 
	%Item{} 
	|> Item.changeset(attrs)
  end

  def create_item(attrs) do	 
	attrs
	|> build_item
	|> Repo.insert
  end

  def update_recipe(recipe, items) do  
    Recipe.update_changeset(recipe, items) |> Repo.update!
  end


end