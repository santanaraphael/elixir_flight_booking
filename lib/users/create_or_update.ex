defmodule Flightex.Users.CreateOrUpdate do
  alias Flightex.Users
  alias Users.Agent, as: UserAgent
  alias Users.User

  def call(%{} = params) do
    params
    |> User.build()
    |> save_user()
  end

  defp save_user({:ok, %User{} = user}) do
    UserAgent.save(user)
  end

  defp save_user({:error, _reason} = error), do: error
end
