defmodule HawkeyeWeb.ActionController do
  use HawkeyeWeb, :controller
  alias Hawkeye.ARS.Catalog
  


  def show(conn, %{"id" => id}) do

	action = Catalog.get_action(id) 
  	changeset = Catalog.build_item()
  	public_items = Catalog.list_public_items
	conn
	|> assign(:action, action)
	|> assign(:items, public_items)
	|> render("show.html", changeset: changeset)
  end

  def delete(conn, %{"id" => id}) do

  	params = conn.query_params
  	item = params["item"] |>Catalog.get_item
  	recipe = params["recipe"] |> Catalog.get_recipe
  	items = recipe.items -- [item]
  	action = Catalog.get_action(id) 
  	changeset = Catalog.build_item()
	recipe = Catalog.update_recipe(recipe, items)
	public_items = Catalog.list_public_items
	conn
	|> assign(:action, action)
	|> assign(:items, public_items)
	|> render("show.html", changeset: changeset)
  end

end