defmodule Flightex.Users.CreateOrUpdateTest do
  use ExUnit.Case, async: true

  import Flightex.Factory
  alias Flightex.Users.{Agent, CreateOrUpdate}

  describe "call/1" do
    setup do
      Agent.start_link(%{})
      # O Agent.start_link vai iniciar os 2 agents antes do teste
      # Deve ser implementado para os testes passarem
      :ok
    end

    test "when all params are valid, return a tuple" do
      params = build(:user_input)

      {:ok, user} = CreateOrUpdate.call(params)

      {_ok, response} = Agent.get(user.id)

      expected_response = build(:user, id: user.id)

      assert response == expected_response
    end

    test "when cpf is a integer, returns an error" do
      params = build(:user_input, cpf: 12_345_678_900)

      expected_response = {:error, "Cpf must be a String"}

      response = CreateOrUpdate.call(params)

      assert response == expected_response
    end
  end
end
