defmodule Hawkeye.Factory do
	use ExMachina.Ecto, repo: Hawkeye.Repo

	alias Hawkeye.ARS.{Action, Efficacy, Feedback ,Item , Recipe, RecipeItem}

    def item_factory do
	    %Item{
			description: sequence(:description, &"Item description #{&1}"),
			file_url: sequence(:file_url, &"https://factoryfile_urlno#{&1}"),
			is_public: true
	    }
    end

    def action_factory do
	    %Action{
	    	timestamp: DateTime.utc(),
			title: "LatestAction",
			description: "Non-violent Protest",
			location: "Cabbana"
	    }
  	end

    def recipe_factory do
	    %Recipe{
			is_public: true,
			keyword: sequence(:keyword,["peaceful", "non-violent", "protest"]),
			title: sequence("Action Recipe#{&1}"),
			items: build_list(3, :item),
			action_recipe: build(:action)
	    }
    end

    def recipe_item_factory do
	    %RecipeItem{
	     	recipe_id: insert(:address),
	     	item_id: insert(:item)
	    }
    end

end