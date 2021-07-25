defmodule Flightex.Bookings.CreateOrUpdate do
  alias Flightex.Bookings
  alias Bookings.Agent, as: BookingAgent
  alias Bookings.Booking
  alias Flightex.Users.Agent, as: UserAgent

  def call(%{user_id: user_id} = params) do
    with {:ok, _user} <- UserAgent.get(user_id),
         {:ok, booking} <- Booking.build(params) do
      BookingAgent.save(booking)
    else
      error -> error
    end
  end
end
