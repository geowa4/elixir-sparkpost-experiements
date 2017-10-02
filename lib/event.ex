defmodule RocDev.Newsletter.Event do
  @moduledoc """
  Provides simple access to Meetup objects.
  """

  use Tesla

  plug Tesla.Middleware.BaseUrl, "https://api.meetup.com"
  plug Tesla.Middleware.JSON

  @doc """
  Retrieves RocDev events from Meetup.
  """
  def get_events do
    get(
      "/meetup-group-BkuJclOW/events",
      query: [page: 20, status: "upcoming"]
    ).body
  end
end
