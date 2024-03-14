defmodule DaimonDatePickerWeb.HomeLive do
  use Phoenix.LiveView

  def mount(_params, _session, socket) do
    socket =
      socket
      |> assign(:selected_date, Date.utc_today())
      |> assign(:activated, false)

    {:ok, socket, layout: {DaimonDatePickerWeb.Layouts, :app}}
  end

  def handle_event("toggle_date_picker", _params, socket) do
    {:noreply, assign(socket, :activated, not socket.assigns.activated)}
  end

  defp date_picker(assigns) do
    ~H"""
    <div class="w-60 border mt-4 p-2 border-black">
      Date Picker
    </div>
    """
  end
end
