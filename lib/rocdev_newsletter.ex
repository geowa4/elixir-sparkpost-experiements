defmodule RocDev.Newsletter do
  @moduledoc """
  Documentation for RocDev.Newsletter.
  """

  alias RocDev.Newsletter.{Email, Event}

  @doc """
  Sends email for all upcoming RocDev Events.
  """
  def notify_for_upcoming_events do
    Event.get_events |> Email.send_events_email
  end
end
