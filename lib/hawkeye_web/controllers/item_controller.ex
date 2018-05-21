defmodule HawkeyeWeb.ItemController do
  use HawkeyeWeb, :controller
  alias Hawkeye.ARS.Catalog
  alias Hawkeye.ARS.Helper.ActionManager
  
  def create(conn, %{"item" => item_params}) do
  	action = Catalog.get_action(item_params["action"])
	case Catalog.create_item(item_params) do
		{:ok, item} ->
		multi = ActionManager.associate_recipeitem(action, item)
		case multi do
			{:ok, _} ->
				conn
				|> put_flash(:info, "Item created")
				|> redirect(to: action_path(conn, :show, action.id))
		    {:error, changeset} ->
		        conn |> put_flash(:info, "Item creation failed")
		end
		{:error, changeset} -> 
			conn
			|> render(HawkeyeWeb.ActionView, "show.html", changeset: changeset, action: action)
	end
  end

end
