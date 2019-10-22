defmodule SingForNeedsWeb.Schema.ArtistTypes do
  @moduledoc """
  All types for artists
  """
  use Absinthe.Schema.Notation
  import Absinthe.Resolution.Helpers, only: [dataloader: 1, dataloader: 3]

  object :artist do
    field :id, :id
    field :name, :string
    field :causes, list_of(:cause), resolve: dataloader(Causes)
  end
end
