defmodule Flightex.Bookings.ReportTest do
  use ExUnit.Case, async: false

  alias Flightex.Bookings.{Report, Booking}

  import Flightex.Factory

  describe "generate/1" do
    setup do
      Flightex.start_agents()
      :ok
    end

    test "when called, persist the content" do
      {:ok, user} =
        :user
        |> build()
        |> Flightex.create_or_update_user()

      :booking
      |> build(user_id: user.id)
      |> Flightex.create_or_update_booking()

      content = "12345678900,Brasilia,Bananeiras,2001-05-07 03:05:00\n"

      Report.generate("report-test.csv")
      {:ok, file} = File.read("report-test.csv")

      assert file == content
    end
  end

  describe "generate_by_period/3" do
    setup do
      Flightex.start_agents()
      :ok
    end

    test "when called, persist the content based on the period" do
      {:ok, user} =
        :user
        |> build()
        |> Flightex.create_or_update_user()

      bookings =
        build_list(5, :booking_input, %{user_id: user.id})
        |> Enum.map(&Booking.build/1)
        |> Enum.map(fn {:ok, %Booking{} = booking} -> booking end)

      Enum.map(bookings, &Flightex.create_or_update_booking/1)

      :booking
      |> build(user_id: user.id, complete_date: ~N[2002-05-07 03:05:00])
      |> Flightex.create_or_update_booking()

      content =
        "12345678900,Brasilia,Bananeiras,2001-05-07 03:05:00\n" <>
          "12345678900,Brasilia,Bananeiras,2001-05-07 03:05:00\n" <>
          "12345678900,Brasilia,Bananeiras,2001-05-07 03:05:00\n" <>
          "12345678900,Brasilia,Bananeiras,2001-05-07 03:05:00\n" <>
          "12345678900,Brasilia,Bananeiras,2001-05-07 03:05:00\n"

      Report.generate_by_period(
        "report-test.csv",
        ~N[2001-05-02 03:05:00],
        ~N[2001-05-20 03:05:00]
      )

      {:ok, file} = File.read("report-test.csv")

      assert file == content
    end
  end
end
