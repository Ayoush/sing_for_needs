defmodule SingForNeedsWeb.Schema.Mutation.CreateCauseTest do
  @moduledoc """
  Test for creating a cause
  """
  use SingForNeedsWeb.ConnCase, async: true

  @query """
  mutation ($description: String!, $endDate: Date!, $name: String!, $startDate: Date!, $amountRaised: Decimal!, $targetAmount: Decimal!, $sponsor: String!, $artists: [ID] ) {
    createCause(description: $description, endDate: $endDate, name: $name, startDate: $startDate, amountRaised: $amountRaised, targetAmount: $targetAmount, sponsor: $sponsor, artists: $artists){
        description
        name
        startDate
        endDate
        amountRaised
        targetAmount
        sponsor
      }
    }
  """

  test "createCause mutation creates a cause" do
    artists = artists_fixture()
    artist_ids = Enum.map(artists, fn artist -> artist.id end)

    input = %{
      description: "Awesome cause description",
      endDate: "2010-10-17",
      startDate: "2010-09-17",
      targetAmount: 30_000,
      amountRaised: 3000,
      sponsor: "unicef",
      name: "Awesome cause",
      artists: artist_ids
    }

    conn = build_conn()

    conn =
      post conn, "/api",
        query: @query,
        variables: input

    assert %{
             "data" => %{
               "createCause" => %{
                 "description" => "Awesome cause description",
                 "name" => "Awesome cause",
                 "sponsor" => "unicef",
                 "amountRaised" => "3000",
                 "endDate" => "2010-10-17",
                 "startDate" => "2010-09-17",
                 "targetAmount" => "30000"
               }
             }
           } == json_response(conn, 200)
  end
end
