defmodule RocDev.Newsletter.Slack do
  @moduledoc """
  Provides access to Slack API.
  """

  use Tesla

  plug Tesla.Middleware.BaseUrl,
    Application.get_env(:rocdev_newsletter, :slack_base_url)
  plug Tesla.Middleware.Query, [
    {"token", Application.get_env(:rocdev_newsletter, :slack_api_token)}
  ]
  plug Tesla.Middleware.JSON

  defp careers_channel_id do
    Application.get_env(:rocdev_newsletter, :rocdev_careers_channel_id)
  end

  @doc """
  Lists pinned messages in #careers.
  """
  def list_career_pins do
    get("/pins.list", query: [channel: careers_channel_id()]).body["items"]
  end

  defp format_datetime(dt) do
    "#{dt.year}-#{dt.month}-#{dt.day}"
  end

  def parse_pin_date(created) when is_integer(created) do
    case DateTime.from_unix(created) do
      {:ok, dt} -> format_datetime(dt)
      {:error, _} -> format_datetime(DateTime.utc_now)
    end
  end

  def get_user_data(user_id) do
    get("/users.info", query: [user: user_id]).body["user"]
  end

  @doc """
  company | title | {remote, onsite} | location | salary
  free form
  """
  def parse_pin_message(message_text) do
    message_text
  end

  def get_pin_data do
    list_career_pins() |>
    Enum.map(fn(pin) ->
      user = get_user_data(pin["message"]["user"])
      %{
        message: parse_pin_message(pin["message"]["text"]),
        date: parse_pin_date(pin["created"]),
        user: %{
          real_name: user["profile"]["real_name"],
          display_name: user["profile"]["display_name"]
        }
      }
    end)
  end
end