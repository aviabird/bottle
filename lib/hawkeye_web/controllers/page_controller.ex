defmodule HawkeyeWeb.PageController do
  use HawkeyeWeb, :controller

  def index(conn, _params) do
  	actions = Hawkeye.ARS.Catalog.list_actions 
    render conn, "index.html", actions: actions
  end
end
