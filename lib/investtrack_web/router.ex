defmodule InvesttrackWeb.Router do
  use InvesttrackWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", InvesttrackWeb do
    pipe_through :api

    resources "/users", UserController, except: [:new, :edit]
    resources "/historical", StockDataController, only: [:index, :show]
    resources "/shares", ShareController, only: [:index, :show]
  end
end
