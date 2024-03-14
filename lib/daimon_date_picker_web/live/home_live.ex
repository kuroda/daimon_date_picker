defmodule DaimonDatePickerWeb.HomeLive do
  use Phoenix.LiveView

  def mount(_params, _session, socket) do
    socket =
      socket
      |> assign(:selected_date, Date.utc_today())

    {:ok, socket, layout: {DaimonDatePickerWeb.Layouts, :app}}
  end
end
