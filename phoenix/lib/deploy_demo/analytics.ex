defmodule DeployDemo.Analytics do
  @moduledoc """
  The Analytics context.
  """

  import Ecto.Query, warn: false
  alias DeployDemo.Repo

  alias DeployDemo.Analytics.Startup

  @doc """
  Returns the list of start_events.

  ## Examples

      iex> list_start_events()
      [%Startup{}, ...]

  """
  def list_start_events do
    Repo.all(Startup)
  end

  @doc """
  Gets a single startup.

  Raises `Ecto.NoResultsError` if the Startup does not exist.

  ## Examples

      iex> get_startup!(123)
      %Startup{}

      iex> get_startup!(456)
      ** (Ecto.NoResultsError)

  """
  def get_startup!(id), do: Repo.get!(Startup, id)

  def get_last_startup! do
    Startup
    |> last(:time)
    |> Repo.one!()
  end

  def get_first_startup! do
    Startup
    |> first(:time)
    |> Repo.one!()
  end

  @doc """
  Creates a startup.

  ## Examples

      iex> create_startup(%{field: value})
      {:ok, %Startup{}}

      iex> create_startup(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_startup(attrs \\ %{}) do
    %Startup{}
    |> Startup.changeset(attrs)
    |> Repo.insert()
  end

  def log_current_startup do
    %{
      time: DateTime.utc_now()
    }
    |> create_startup()
  end

  @doc """
  Updates a startup.

  ## Examples

      iex> update_startup(startup, %{field: new_value})
      {:ok, %Startup{}}

      iex> update_startup(startup, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_startup(%Startup{} = startup, attrs) do
    startup
    |> Startup.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a startup.

  ## Examples

      iex> delete_startup(startup)
      {:ok, %Startup{}}

      iex> delete_startup(startup)
      {:error, %Ecto.Changeset{}}

  """
  def delete_startup(%Startup{} = startup) do
    Repo.delete(startup)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking startup changes.

  ## Examples

      iex> change_startup(startup)
      %Ecto.Changeset{data: %Startup{}}

  """
  def change_startup(%Startup{} = startup, attrs \\ %{}) do
    Startup.changeset(startup, attrs)
  end
end
