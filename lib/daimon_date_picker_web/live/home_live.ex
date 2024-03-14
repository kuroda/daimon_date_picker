defmodule DaimonDatePickerWeb.HomeLive do
  use Phoenix.LiveView

  def mount(_params, _session, socket) do
    socket =
      socket
      |> assign(:selected_date, Date.utc_today())
      |> assign(:current_month, Date.beginning_of_month(Date.utc_today()))
      |> assign(:activated, false)

    {:ok, socket, layout: {DaimonDatePickerWeb.Layouts, :app}}
  end

  def handle_event("toggle_date_picker", _params, socket) do
    {:noreply, assign(socket, :activated, not socket.assigns.activated)}
  end

  defp date_picker(assigns) do
    ~H"""
    <div class="w-60 border mt-4 p-2 border-black grid grid-cols-7 gap-1">
      <div class="col-span-7 p-1 flex justify-between">
        <button type="button" class="underline">Prev</button>
        <span><%= Calendar.strftime(@current_month, "%B %Y") %></span>
        <button type="button" class="underline">Next</button>
      </div>
    </div>
    """
  end
end
