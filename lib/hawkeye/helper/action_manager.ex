defmodule Hawkeye.ARS.Helper.ActionManager do
	alias Ecto.Multi
	alias Hawkeye.Repo
	alias Hawkeye.ARS.{Action, Efficacy, Feedback ,Item , Recipe, RecipeItem}


	def duplicate(recipe) do
		Map.replace!(Map.from_struct(recipe), :parent_id, recipe.id)
	end


	def entry_transaction(new_action_params, parent_recipe, item_changeset) do

		multi = Multi.new
		|> Multi.insert(:item, item_changeset)
		|> Multi.run(:recipe, fn %{item: item} -> 
			preloaded_recipe = parent_recipe |> Repo.preload [:items, :parent, :action]
			forked_recipe =  preloaded_recipe |> duplicate
			recipe = %Recipe{} |> Recipe.put_changeset(forked_recipe) |> Repo.insert!
			updated_items = recipe.items ++ [item] 
			Recipe.update_changeset(recipe, updated_items) |> Repo.update
		end)
		|> Multi.run(:action, fn %{recipe: recipe}->
			params = Map.replace!(new_action_params, :action_recipe, recipe)
			%Action{} |> Action.create_changeset(params) |> Repo.insert
		end)
		|> Repo.transaction()
	end

	def associate_recipeitem( action, item) do

		multi = Multi.new
		|> Multi.run(:recipe, fn _ -> 
			preloaded_recipe = action.action_recipe |> Repo.preload [:items, :parent, :action]
			# forked_recipe =  preloaded_recipe |> duplicate
			# recipe = %Recipe{} |> Recipe.put_changeset(forked_recipe) |> Repo.insert!
			updated_items = preloaded_recipe.items ++ [item] 
			Recipe.update_changeset(preloaded_recipe, updated_items) |> Repo.update
		end)
		|> Multi.run(:action, fn %{recipe: recipe}->
			action = %{action | action_recipe: recipe} 
			action 
			|> Action.update_changeset 
			|> Repo.update
		end)
		|> Repo.transaction()
	end
end