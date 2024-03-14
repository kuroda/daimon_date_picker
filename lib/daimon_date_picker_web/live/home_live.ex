defmodule DaimonDatePickerWeb.HomeLive do
  use Phoenix.LiveView

  def mount(_params, _session, socket) do
    {:ok, socket, layout: {DaimonDatePickerWeb.Layouts, :app}}
  end
end
