defmodule Flightex.Factory do
  use ExMachina

  alias Flightex.Bookings.Booking
  alias Flightex.Users.User

  def user_input_factory do
    %{
      name: "Jp",
      email: "jp@banana.com",
      cpf: "12345678900"
    }
  end

  def user_factory do
    %User{
      id: UUID.uuid4(),
      name: "Jp",
      email: "jp@banana.com",
      cpf: "12345678900"
    }
  end

  def booking_input_factory do
    %{
      complete_date: ~N[2001-05-07 03:05:00],
      local_origin: "Brasilia",
      local_destination: "Bananeiras",
      user_id: "12345678900"
    }
  end

  def booking_factory do
    %Booking{
      complete_date: ~N[2001-05-07 03:05:00],
      local_origin: "Brasilia",
      local_destination: "Bananeiras",
      user_id: "12345678900",
      id: UUID.uuid4()
    }
  end
end
