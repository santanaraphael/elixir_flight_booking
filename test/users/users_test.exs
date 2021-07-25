defmodule Flightex.Users.UserTest do
  use ExUnit.Case

  alias Flightex.Users.User

  import Flightex.Factory

  describe "build/4" do
    test "when all params are valid, returns the user" do
      user_input = build(:user_input)

      {:ok, response} = User.build(user_input)

      expected_response = build(:user, id: response.id)

      assert response == expected_response
    end

    test "when cpf is a integer" do
      user_input = build(:user_input, cpf: 123)

      response = User.build(user_input)

      expected_response = {:error, "Cpf must be a String"}

      assert response == expected_response
    end
  end
end
