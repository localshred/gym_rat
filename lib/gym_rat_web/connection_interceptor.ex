defmodule GymRatWeb.Plug.ConnectionInterceptor do
  def init(default), do: default

  def call(conn, _default) do
    require IEx
    IEx.pry()
    conn
  end
end
