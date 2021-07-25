defmodule Flightex.Bookings.AgentTest do
  use ExUnit.Case

  import Flightex.Factory

  alias Flightex.Bookings.Agent, as: BookingsAgent

  describe "save/1" do
    setup do
      BookingsAgent.start_link(%{})
      {:ok, id: UUID.uuid4()}
    end

    test "when the param are valid, return the saved booking", %{id: id} do
      response =
        :booking
        |> build(id: id)
        |> BookingsAgent.save()

      expected_response = {:ok, build(:booking, id: id)}
      assert response == expected_response
    end
  end

  describe "get/1" do
    setup do
      BookingsAgent.start_link(%{})
      {:ok, id: UUID.uuid4()}
    end

    test "when the booking is found, return it", %{id: id} do
      :booking
      |> build(id: id)
      |> BookingsAgent.save()

      response = BookingsAgent.get(id)

      expected_response =
        {:ok,
         %Flightex.Bookings.Booking{
           complete_date: ~N[2001-05-07 03:05:00],
           id: id,
           local_destination: "Bananeiras",
           local_origin: "Brasilia",
           user_id: "12345678900"
         }}

      assert response == expected_response
    end

    test "when the user wasn't found, returns an error", %{id: id} do
      booking = build(:booking, id: id)
      {:ok, _uuid} = BookingsAgent.save(booking)

      response = BookingsAgent.get("banana")

      expected_response = {:error, "Booking not found"}

      assert response == expected_response
    end
  end
end
