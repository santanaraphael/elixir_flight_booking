defmodule Flightex.Bookings.ReportTest do
  use ExUnit.Case, async: false

  alias Flightex.Bookings.Report

  import Flightex.Factory

  describe "generate/1" do
    setup do
      Flightex.start_agents()
      :ok
    end

    test "when called, return the content" do
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

      assert file =~ content
    end
  end
end
