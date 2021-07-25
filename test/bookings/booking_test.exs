defmodule Flightex.Bookings.BookingTest do
  use ExUnit.Case, async: false

  alias Flightex.Bookings.Booking

  import Flightex.Factory

  describe "build/4" do
    test "when all params are valid, returns a booking" do
      booking_input = build(:booking_input)

      {:ok, response} = Booking.build(booking_input)

      expected_response = build(:booking, id: response.id)

      assert response == expected_response
    end
  end
end
