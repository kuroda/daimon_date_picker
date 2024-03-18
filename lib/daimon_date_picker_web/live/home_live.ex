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

  def handle_event("prev_month", _params, socket) do
    prev_month =
      socket.assigns.current_month
      |> Date.add(-1)
      |> Date.beginning_of_month()

    socket = assign(socket, :current_month, prev_month)
    {:noreply, socket}
  end

  def handle_event("next_month", _params, socket) do
    next_month =
      socket.assigns.current_month
      |> Date.end_of_month()
      |> Date.add(1)

    socket = assign(socket, :current_month, next_month)
    {:noreply, socket}
  end

  def handle_event("select_date", %{"day" => day} = _params, socket) do
    eom = Date.end_of_month(socket.assigns.current_month)

    selected_date =
      case Integer.parse(day) do
        {d, ""} when d in 1..eom.day ->
          %{socket.assigns.current_month | day: d}

        _ ->
          socket.assigns.current_month
      end

    socket =
      socket
      |> assign(:selected_date, selected_date)
      |> assign(:activated, false)

    {:noreply, socket}
  end

  defp date_picker(assigns) do
    ~H"""
    <div class="w-60 border mt-4 p-2 border-black grid grid-cols-7 gap-1">
      <div class="col-span-7 p-1 flex justify-between">
        <button type="button" class="underline" phx-click="prev_month">
          Prev
        </button>
        <span><%= Calendar.strftime(@current_month, "%B %Y") %></span>
        <button type="button" class="underline" phx-click="next_month">
          Next
        </button>
      </div>
      <%= for wd <- ~w(Su Mo Tu We Th Fr Sa) do %>
        <div class="p-1 bg-gray-300 text-center"><%= wd %></div>
      <% end %>
      <%= for day <- get_days_for_date_picker(@current_month) do %>
        <%= if day do %>
          <button
            type="button"
            class="p-1 bg-gray-700 text-white text-right"
            phx-click="select_date"
            phx-value-day={day}
          >
            <%= day %>
          </button>
        <% else %>
          <div class="p-1 bg-gray-100"></div>
        <% end %>
      <% end %>
    </div>
    """
  end

  defp get_days_for_date_picker(current_month) do
    day1 = Date.beginning_of_week(current_month, :sunday)
    eom = Date.end_of_month(current_month)
    len = if Date.diff(eom, day1) >= 35, do: 42, else: 35

    for n <- 0..(len - 1) do
      d = Date.add(day1, n)
      if d.month == current_month.month, do: d.day, else: nil
    end
  end
end
