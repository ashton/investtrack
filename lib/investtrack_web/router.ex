defmodule InvesttrackWeb.Router do
  use InvesttrackWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", InvesttrackWeb do
    pipe_through :api

    resources "/users", UserController, except: [:new, :edit]
    resources "/prices", StockController, except: [:new, :edit]
  end
end
