defmodule DaimonDatePickerWeb.Router do
  use DaimonDatePickerWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {DaimonDatePickerWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  scope "/", DaimonDatePickerWeb do
    pipe_through :browser
  end
end
