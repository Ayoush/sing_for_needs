defmodule SingForNeeds.Schema.Query.ArtistsTest do
  @moduledoc false
  use SingForNeedsWeb.ConnCase, async: true

  @query """
  {
    artists {
      name
      causes {
        id
      }
    }
  }
  """
  test "artists query returns all artists" do
    artists_fixture()
    conn = build_conn()
    conn = get conn, "/api", query: @query

    assert %{"data" => %{
      "artists" => [
        %{"name" => "Artist 1", "causes"=>[]},
        %{"name" => "Artist 2", "causes"=>[]},
        %{"name" => "Artist 3", "causes"=>[]}
      ]
      }
    } = json_response(conn, 200)
  end
end
