defmodule Safira.Factory do
  use ExMachina.Ecto, repo: Safira.Repo
  import Safira.Helper, only: [random_string: 1]
  alias Safira.Accounts.User
  alias Safira.Accounts.Attendee
  alias Safira.Accounts.Company

  def user_factory do
    password = random_string(8)
    %User{
      email: Faker.Internet.email(),
      password: password,
      password_confirmation: password
    }
  end
end