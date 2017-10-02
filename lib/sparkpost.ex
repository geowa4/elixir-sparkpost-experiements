defmodule RocDev.Newsletter.Email do
  @moduledoc """
  Send emails based on templates to predetermined recipients.
  """

  alias SparkPost.{
    Transmission, Recipient.ListRef, Content.TemplateRef, SuppressionList
  }

  @doc """
  Unsubscribe email.
  """
  def unsubscribe(email) do
    SuppressionList.upsert_one(email, "non_transactional")
  end

  @doc """
  Send event updates to interested RocDev members.
  """
  def send_events_email(events) do
    Transmission.send(%Transmission{
      recipients: %ListRef{
        list_id: "roc-dev-socialites"
      },
      content: %TemplateRef{
        template_id: "upcoming-roc-dev-events"
      },
      substitution_data: %{
        events: events
      }
    })
  end

  @doc """
  Send event updates to interested RocDev members.
  """
  def send_jobs_email(events) do
    Transmission.send(%Transmission{
      recipients: %ListRef{
        list_id: "roc-dev-job-seekers"
      },
      content: %TemplateRef{
        template_id: "upcoming-roc-dev-events"
      },
      substitution_data: %{
        events: events
      }
    })
  end
end