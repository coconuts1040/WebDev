defmodule Tasks.TodoTest do
  use Tasks.DataCase

  alias Tasks.Todo

  describe "tasks" do
    alias Tasks.Todo.Task

    @valid_attrs %{description: "some description", progress: ~T[14:00:00.000000], title: "some title"}
    @update_attrs %{description: "some updated description", progress: ~T[15:01:01.000000], title: "some updated title"}
    @invalid_attrs %{description: nil, progress: nil, title: nil}

    def task_fixture(attrs \\ %{}) do
      {:ok, task} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Todo.create_task()

      task
    end

    test "list_tasks/0 returns all tasks" do
      task = task_fixture()
      assert Todo.list_tasks() == [task]
    end

    test "get_task!/1 returns the task with given id" do
      task = task_fixture()
      assert Todo.get_task!(task.id) == task
    end

    test "create_task/1 with valid data creates a task" do
      assert {:ok, %Task{} = task} = Todo.create_task(@valid_attrs)
      assert task.description == "some description"
      assert task.progress == ~T[14:00:00.000000]
      assert task.title == "some title"
    end

    test "create_task/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Todo.create_task(@invalid_attrs)
    end

    test "update_task/2 with valid data updates the task" do
      task = task_fixture()
      assert {:ok, task} = Todo.update_task(task, @update_attrs)
      assert %Task{} = task
      assert task.description == "some updated description"
      assert task.progress == ~T[15:01:01.000000]
      assert task.title == "some updated title"
    end

    test "update_task/2 with invalid data returns error changeset" do
      task = task_fixture()
      assert {:error, %Ecto.Changeset{}} = Todo.update_task(task, @invalid_attrs)
      assert task == Todo.get_task!(task.id)
    end

    test "delete_task/1 deletes the task" do
      task = task_fixture()
      assert {:ok, %Task{}} = Todo.delete_task(task)
      assert_raise Ecto.NoResultsError, fn -> Todo.get_task!(task.id) end
    end

    test "change_task/1 returns a task changeset" do
      task = task_fixture()
      assert %Ecto.Changeset{} = Todo.change_task(task)
    end
  end

  describe "manager" do
    alias Tasks.Todo.Manage

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def manage_fixture(attrs \\ %{}) do
      {:ok, manage} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Todo.create_manage()

      manage
    end

    test "list_manager/0 returns all manager" do
      manage = manage_fixture()
      assert Todo.list_manager() == [manage]
    end

    test "get_manage!/1 returns the manage with given id" do
      manage = manage_fixture()
      assert Todo.get_manage!(manage.id) == manage
    end

    test "create_manage/1 with valid data creates a manage" do
      assert {:ok, %Manage{} = manage} = Todo.create_manage(@valid_attrs)
    end

    test "create_manage/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Todo.create_manage(@invalid_attrs)
    end

    test "update_manage/2 with valid data updates the manage" do
      manage = manage_fixture()
      assert {:ok, manage} = Todo.update_manage(manage, @update_attrs)
      assert %Manage{} = manage
    end

    test "update_manage/2 with invalid data returns error changeset" do
      manage = manage_fixture()
      assert {:error, %Ecto.Changeset{}} = Todo.update_manage(manage, @invalid_attrs)
      assert manage == Todo.get_manage!(manage.id)
    end

    test "delete_manage/1 deletes the manage" do
      manage = manage_fixture()
      assert {:ok, %Manage{}} = Todo.delete_manage(manage)
      assert_raise Ecto.NoResultsError, fn -> Todo.get_manage!(manage.id) end
    end

    test "change_manage/1 returns a manage changeset" do
      manage = manage_fixture()
      assert %Ecto.Changeset{} = Todo.change_manage(manage)
    end
  end

  describe "timeblocks" do
    alias Tasks.Todo.Timeblock

    @valid_attrs %{end: ~T[14:00:00.000000], start: ~T[14:00:00.000000]}
    @update_attrs %{end: ~T[15:01:01.000000], start: ~T[15:01:01.000000]}
    @invalid_attrs %{end: nil, start: nil}

    def timeblock_fixture(attrs \\ %{}) do
      {:ok, timeblock} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Todo.create_timeblock()

      timeblock
    end

    test "list_timeblocks/0 returns all timeblocks" do
      timeblock = timeblock_fixture()
      assert Todo.list_timeblocks() == [timeblock]
    end

    test "get_timeblock!/1 returns the timeblock with given id" do
      timeblock = timeblock_fixture()
      assert Todo.get_timeblock!(timeblock.id) == timeblock
    end

    test "create_timeblock/1 with valid data creates a timeblock" do
      assert {:ok, %Timeblock{} = timeblock} = Todo.create_timeblock(@valid_attrs)
      assert timeblock.end == ~T[14:00:00.000000]
      assert timeblock.start == ~T[14:00:00.000000]
    end

    test "create_timeblock/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Todo.create_timeblock(@invalid_attrs)
    end

    test "update_timeblock/2 with valid data updates the timeblock" do
      timeblock = timeblock_fixture()
      assert {:ok, timeblock} = Todo.update_timeblock(timeblock, @update_attrs)
      assert %Timeblock{} = timeblock
      assert timeblock.end == ~T[15:01:01.000000]
      assert timeblock.start == ~T[15:01:01.000000]
    end

    test "update_timeblock/2 with invalid data returns error changeset" do
      timeblock = timeblock_fixture()
      assert {:error, %Ecto.Changeset{}} = Todo.update_timeblock(timeblock, @invalid_attrs)
      assert timeblock == Todo.get_timeblock!(timeblock.id)
    end

    test "delete_timeblock/1 deletes the timeblock" do
      timeblock = timeblock_fixture()
      assert {:ok, %Timeblock{}} = Todo.delete_timeblock(timeblock)
      assert_raise Ecto.NoResultsError, fn -> Todo.get_timeblock!(timeblock.id) end
    end

    test "change_timeblock/1 returns a timeblock changeset" do
      timeblock = timeblock_fixture()
      assert %Ecto.Changeset{} = Todo.change_timeblock(timeblock)
    end
  end

  describe "blocks" do
    alias Tasks.Todo.Block

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def block_fixture(attrs \\ %{}) do
      {:ok, block} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Todo.create_block()

      block
    end

    test "list_blocks/0 returns all blocks" do
      block = block_fixture()
      assert Todo.list_blocks() == [block]
    end

    test "get_block!/1 returns the block with given id" do
      block = block_fixture()
      assert Todo.get_block!(block.id) == block
    end

    test "create_block/1 with valid data creates a block" do
      assert {:ok, %Block{} = block} = Todo.create_block(@valid_attrs)
    end

    test "create_block/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Todo.create_block(@invalid_attrs)
    end

    test "update_block/2 with valid data updates the block" do
      block = block_fixture()
      assert {:ok, block} = Todo.update_block(block, @update_attrs)
      assert %Block{} = block
    end

    test "update_block/2 with invalid data returns error changeset" do
      block = block_fixture()
      assert {:error, %Ecto.Changeset{}} = Todo.update_block(block, @invalid_attrs)
      assert block == Todo.get_block!(block.id)
    end

    test "delete_block/1 deletes the block" do
      block = block_fixture()
      assert {:ok, %Block{}} = Todo.delete_block(block)
      assert_raise Ecto.NoResultsError, fn -> Todo.get_block!(block.id) end
    end

    test "change_block/1 returns a block changeset" do
      block = block_fixture()
      assert %Ecto.Changeset{} = Todo.change_block(block)
    end
  end

  describe "blocks" do
    alias Tasks.Todo.Block

    @valid_attrs %{end: ~T[14:00:00.000000], start: ~T[14:00:00.000000]}
    @update_attrs %{end: ~T[15:01:01.000000], start: ~T[15:01:01.000000]}
    @invalid_attrs %{end: nil, start: nil}

    def block_fixture(attrs \\ %{}) do
      {:ok, block} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Todo.create_block()

      block
    end

    test "list_blocks/0 returns all blocks" do
      block = block_fixture()
      assert Todo.list_blocks() == [block]
    end

    test "get_block!/1 returns the block with given id" do
      block = block_fixture()
      assert Todo.get_block!(block.id) == block
    end

    test "create_block/1 with valid data creates a block" do
      assert {:ok, %Block{} = block} = Todo.create_block(@valid_attrs)
      assert block.end == ~T[14:00:00.000000]
      assert block.start == ~T[14:00:00.000000]
    end

    test "create_block/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Todo.create_block(@invalid_attrs)
    end

    test "update_block/2 with valid data updates the block" do
      block = block_fixture()
      assert {:ok, block} = Todo.update_block(block, @update_attrs)
      assert %Block{} = block
      assert block.end == ~T[15:01:01.000000]
      assert block.start == ~T[15:01:01.000000]
    end

    test "update_block/2 with invalid data returns error changeset" do
      block = block_fixture()
      assert {:error, %Ecto.Changeset{}} = Todo.update_block(block, @invalid_attrs)
      assert block == Todo.get_block!(block.id)
    end

    test "delete_block/1 deletes the block" do
      block = block_fixture()
      assert {:ok, %Block{}} = Todo.delete_block(block)
      assert_raise Ecto.NoResultsError, fn -> Todo.get_block!(block.id) end
    end

    test "change_block/1 returns a block changeset" do
      block = block_fixture()
      assert %Ecto.Changeset{} = Todo.change_block(block)
    end
  end
end
