defmodule InvesttrackWeb.ShareView do
  use InvesttrackWeb, :view
  alias InvesttrackWeb.ShareView

  def render("index.json", %{shares: shares}) do
    %{data: render_many(shares, ShareView, "share.json")}
  end

  def render("show.json", %{share: share}) do
    %{data: render_one(share, ShareView, "share.json")}
  end

  def render("share.json", %{share: share}) do
    %{id: share.id,
      name: share.name,
      code: share.code}
  end
end
