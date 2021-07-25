defmodule Flightex.Bookings.CreateOrUpdateTest do
  use ExUnit.Case, async: false

  import Flightex.Factory

  alias Flightex.Bookings.{Agent, CreateOrUpdate}
  alias Flightex.Users.Agent, as: UserAgent

  describe "call/1" do
    setup do
      Agent.start_link(%{})
      UserAgent.start_link(%{})

      :ok
    end

    test "when all params are valid, returns a valid tuple" do
      user = build(:user)
      UserAgent.save(user)

      params = build(:booking_input, user_id: user.id)

      {:ok, booking} = CreateOrUpdate.call(params)

      {:ok, response} = Agent.get(booking.id)

      expected_response = build(:booking, user_id: user.id, id: booking.id)

      assert response == expected_response
    end
  end
end
