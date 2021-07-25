defmodule Flightex.Users.User do
  @keys [:name, :email, :cpf, :id]
  @enforce_keys @keys
  defstruct @keys

  def build(%{name: _name, email: _email, cpf: cpf}) when not is_bitstring(cpf) do
    {:error, "Cpf must be a String"}
  end

  def build(%{name: name, email: email, cpf: cpf}) do
    {
      :ok,
      %__MODULE__{
        name: name,
        email: email,
        cpf: cpf,
        id: UUID.uuid1()
      }
    }
  end
end
