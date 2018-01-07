defmodule InvesttrackWeb.Router do
  use InvesttrackWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", InvesttrackWeb do
    pipe_through :api
  end
end
