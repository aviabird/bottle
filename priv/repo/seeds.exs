# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Hawkeye.Repo.insert!(%Hawkeye.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
require Ecto.Query
alias Ecto.DateTime
alias Hawkeye.Repo
alias Hawkeye.ARS.Helper.ActionManager
alias Hawkeye.ARS.{Action, Efficacy, Feedback ,Item , Recipe, RecipeItem}

IO.inspect "**********CREATING ACTION ITEMS***************"
for i <- 1..4 do
  item_params = %{
    description: "description no. #{i}",
    file_url: "https://file_urlno.#{i}",
    is_public: true
  }

  case %Item{} |> Item.changeset(item_params) |> Repo.insert do
    {:ok, struct}       -> IO.inspect struct
    {:error, changeset} -> IO.inspect changeset
  end
end


:timer.sleep(2000);

IO.inspect "**********CREATING ACTION RECIPE WITH ABOVE ITEMS***************"

items = Repo.all(Item)
recipe_params = %{
	title: "Action Recipe1",
	keyword: ["peaceful", "non-violent", "protest"],
  is_public: :true,
  items: items
}
recipe = %Recipe{} |> Recipe.put_changeset(recipe_params) |> Repo.insert!

:timer.sleep(2000); 

IO.inspect "********CREATING ACTION FORKING THE GIVEN ACTION RECIPE********" 
preloaded_recipe = recipe |> Repo.preload [:items, :parent, :action]
forked_recipe = %Recipe{} |> Recipe.put_changeset(ActionManager.duplicate(preloaded_recipe)) |> Repo.insert!

action_params = %{
	timestamp: DateTime.utc(),
	title: "First Action",
	description: "Protest for BLM in Washington Park",
	location: "Manhattan",
	action_recipe: forked_recipe
}

action = %Action{} |> Action.create_changeset(action_params) |> Repo.insert!

IO.inspect action 

newitem_params = %{
    description: "latest description",
    file_url: "https://file_urlno5",
    is_public: true,
    updated_at: DateTime.utc()
}


IO.inspect "*****CREATING ACTION RECIPE WITH A NEW ACTION ITEM*****"

IO.inspect Repo.all(Action) |> Repo.preload(:action_recipe)

item_changeset = Item.changeset(%Item{}, newitem_params)

parent_recipe = Repo.all(Recipe) |> List.last 

new_action_params = %{
  timestamp: DateTime.utc(),
  title: "LatestAction",
  description: "Non-violent Protest",
  location: "Cabbana",
  action_recipe: nil
} 

multi = ActionManager.entry_transaction(new_action_params, parent_recipe, item_changeset)

IO.inspect multi

IO.inspect "**A F T E R**"

IO.inspect Repo.all(Action) |> Repo.preload(:action_recipe)