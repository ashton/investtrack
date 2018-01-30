defmodule Investtrack.Repo.Migrations.CreateShares do
  use Ecto.Migration

  def change do
    create table(:shares) do
      add :name, :string
      add :code, :string

      timestamps()
    end

    create unique_index(:shares, [:code])
  end
end
