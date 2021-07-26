defmodule Flightex.Bookings.Report do
  alias Flightex.Bookings
  alias Bookings.Agent, as: BookingAgent
  alias Bookings.Booking
  alias Flightex.Users.Agent, as: UserAgent

  def generate(filename) do
    BookingAgent.list_all()
    |> Map.values()
    |> Enum.map(&generate_booking_line/1)
    |> then(fn line -> File.write!(filename, line) end)
  end

  def generate_by_period(filename, start_date, end_date) do
    BookingAgent.list_all()
    |> Map.values()
    |> Enum.filter(fn booking -> is_booking_in_period?(booking, start_date, end_date) end)
    |> Enum.map(&generate_booking_line/1)
    |> then(fn line -> File.write!(filename, line) end)
  end

  defp generate_booking_line(%Booking{
         user_id: user_id,
         local_origin: local_origin,
         local_destination: local_destination,
         complete_date: complete_date
       }) do
    {:ok, user} = UserAgent.get(user_id)
    "#{user.cpf},#{local_origin},#{local_destination},#{complete_date}\n"
  end

  defp is_booking_in_period?(%Booking{complete_date: complete_date}, start_date, end_date) do
    NaiveDateTime.compare(complete_date, start_date) == :gt and
      NaiveDateTime.compare(complete_date, end_date) == :lt
  end
end
