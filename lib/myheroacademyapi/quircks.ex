defmodule Myheroacademyapi.Quircks do
  @moduledoc """
  The Quircks context.
  """

  import Ecto.Query, warn: false
  alias Myheroacademyapi.Repo

  alias Myheroacademyapi.Quircks.Quirck

  @doc """
  Returns the list of quircks.

  ## Examples

      iex> list_quircks()
      [%Quirck{}, ...]

  """
  def list_quircks do
    Repo.all(Quirck)
  end

  @doc """
  Gets a single quirck.

  Raises `Ecto.NoResultsError` if the Quirck does not exist.

  ## Examples

      iex> get_quirck!(123)
      %Quirck{}

      iex> get_quirck!(456)
      ** (Ecto.NoResultsError)

  """
  def get_quirck!(id), do: Repo.get!(Quirck, id)
  def get_quirck(id), do: Repo.get(Quirck, id)

  @doc """
  Creates a quirck.

  ## Examples

      iex> create_quirck(%{field: value})
      {:ok, %Quirck{}}

      iex> create_quirck(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_quirck(attrs \\ %{}) do
    %Quirck{}
    |> Quirck.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a quirck.

  ## Examples

      iex> update_quirck(quirck, %{field: new_value})
      {:ok, %Quirck{}}

      iex> update_quirck(quirck, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_quirck(%Quirck{} = quirck, attrs) do
    quirck
    |> Quirck.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a quirck.

  ## Examples

      iex> delete_quirck(quirck)
      {:ok, %Quirck{}}

      iex> delete_quirck(quirck)
      {:error, %Ecto.Changeset{}}

  """
  def delete_quirck(%Quirck{} = quirck) do
    Repo.delete(quirck)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking quirck changes.

  ## Examples

      iex> change_quirck(quirck)
      %Ecto.Changeset{source: %Quirck{}}

  """
  def change_quirck(%Quirck{} = quirck) do
    Quirck.changeset(quirck, %{})
  end
end
