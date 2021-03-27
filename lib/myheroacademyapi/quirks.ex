defmodule Myheroacademyapi.Quirks do
  @moduledoc """
  The Quirks context.
  """

  import Ecto.Query, warn: false
  alias Myheroacademyapi.Repo

  alias Myheroacademyapi.Quirks.Quirk

  @doc """
  Returns the list of quirks.

  ## Examples

      iex> list_quirks()
      [%Quirk{}, ...]

  """
  def list_quirks do
    Repo.all(Quirk)
  end

  @doc """
  Gets a single quirk.

  Raises `Ecto.NoResultsError` if the Quirk does not exist.

  ## Examples

      iex> get_quirk!(123)
      %Quirk{}

      iex> get_quirk!(456)
      ** (Ecto.NoResultsError)

  """
  def get_quirk!(id), do: Repo.get!(Quirk, id)

  @doc """
  Creates a quirk.

  ## Examples

      iex> create_quirk(%{field: value})
      {:ok, %Quirk{}}

      iex> create_quirk(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_quirk(attrs \\ %{}) do
    %Quirk{}
    |> Quirk.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a quirk.

  ## Examples

      iex> update_quirk(quirk, %{field: new_value})
      {:ok, %Quirk{}}

      iex> update_quirk(quirk, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_quirk(%Quirk{} = quirk, attrs) do
    quirk
    |> Quirk.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a quirk.

  ## Examples

      iex> delete_quirk(quirk)
      {:ok, %Quirk{}}

      iex> delete_quirk(quirk)
      {:error, %Ecto.Changeset{}}

  """
  def delete_quirk(%Quirk{} = quirk) do
    Repo.delete(quirk)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking quirk changes.

  ## Examples

      iex> change_quirk(quirk)
      %Ecto.Changeset{source: %Quirk{}}

  """
  def change_quirk(%Quirk{} = quirk) do
    Quirk.changeset(quirk, %{})
  end
end
