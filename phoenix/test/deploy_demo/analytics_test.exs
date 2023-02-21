defmodule DeployDemo.AnalyticsTest do
  use DeployDemo.DataCase

  alias DeployDemo.Analytics

  describe "start_events" do
    alias DeployDemo.Analytics.Startup

    import DeployDemo.AnalyticsFixtures

    @invalid_attrs %{time: nil}

    test "list_start_events/0 returns all start_events" do
      startup = startup_fixture()
      assert Analytics.list_start_events() == [startup]
    end

    test "get_startup!/1 returns the startup with given id" do
      startup = startup_fixture()
      assert Analytics.get_startup!(startup.id) == startup
    end

    test "get_last_startup!/0 returns a startup" do
      startup_fixture()
      assert %Startup{} = Analytics.get_last_startup!()
    end

    test "get_first_startup!/0 returns a startup" do
      startup_fixture()
      assert %Startup{} = Analytics.get_first_startup!()
    end

    test "create_startup/1 with valid data creates a startup" do
      valid_attrs = %{time: ~U[2023-02-05 16:45:00Z]}

      assert {:ok, %Startup{} = startup} = Analytics.create_startup(valid_attrs)
      assert startup.time == ~U[2023-02-05 16:45:00Z]
    end

    test "create_startup/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Analytics.create_startup(@invalid_attrs)
    end

    test "log_current_startup/0 creates a startup" do
      assert {:ok, %Startup{}} = Analytics.log_current_startup()
    end

    test "update_startup/2 with valid data updates the startup" do
      startup = startup_fixture()
      update_attrs = %{time: ~U[2023-02-06 16:45:00Z]}

      assert {:ok, %Startup{} = startup} = Analytics.update_startup(startup, update_attrs)
      assert startup.time == ~U[2023-02-06 16:45:00Z]
    end

    test "update_startup/2 with invalid data returns error changeset" do
      startup = startup_fixture()
      assert {:error, %Ecto.Changeset{}} = Analytics.update_startup(startup, @invalid_attrs)
      assert startup == Analytics.get_startup!(startup.id)
    end

    test "delete_startup/1 deletes the startup" do
      startup = startup_fixture()
      assert {:ok, %Startup{}} = Analytics.delete_startup(startup)
      assert_raise Ecto.NoResultsError, fn -> Analytics.get_startup!(startup.id) end
    end

    test "change_startup/1 returns a startup changeset" do
      startup = startup_fixture()
      assert %Ecto.Changeset{} = Analytics.change_startup(startup)
    end
  end
end
