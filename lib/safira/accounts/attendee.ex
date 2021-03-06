defmodule Safira.Accounts.Attendee do
  use Ecto.Schema
  use Arc.Ecto.Schema
  import Ecto.Changeset

  alias Safira.Accounts.User
  alias Safira.Contest.Redeem
  alias Safira.Contest.Badge
  alias Safira.Contest.Referral

  @primary_key {:id, :binary_id, autogenerate: true}
  @derive {Phoenix.Param, key: :id}
  schema "attendees" do
    field :nickname, :string
    field :volunteer, :boolean, default: false
    field :avatar, Safira.Avatar.Type

    belongs_to :user, User
    many_to_many :badges, Badge, join_through: Redeem
    has_many :referrals, Referral

    timestamps()
  end

  def changeset(attendee, attrs) do
    attendee
    |> cast(attrs, [:nickname, :volunteer, :user_id])
    |> cast_attachments(attrs, [:avatar])
    |> cast_assoc(:user)
    |> validate_required([:nickname, :volunteer])
    |> unique_constraint(:nickname)
  end
end
