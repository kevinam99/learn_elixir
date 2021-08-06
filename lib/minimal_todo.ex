defmodule MinimalTodo do
  def start do
    # ask user for filename
    # open it, read anf parse the data
    # ask user for comand
    # (read add, delete todos, load and save files)
    filename = IO.gets("Enter csv filename to load: " |> String.trim())

    read(filename)
    |> parse
    |> get_command
  end

  def read(filename) do
    filename = "lib/" <> filename

    case File.read(filename) do
      {:ok, body} ->
        body

      # IO.puts body
      # parse(body)

      # {:error, :enoent} -> IO.puts("Error: File doesn't exist")
      # {:error, :eacces} -> IO.puts("Error: Permissions missing")
      {:error, reason} ->
        IO.puts("Error: #{:file.format_error(reason)} for file #{filename}")
        {:error, reason}

      _ ->
        IO.puts("Enter a valid filename")
        {:error}
    end
  end

  def parse(body) do
    # each row becomes an element in the list
    _ = """
      at this point,
      body = "item,priority,urgency,date added,notes\ntake out trash,4,1,Dec 11,stinking badly\nsee doctor,1,3,Dec 05,routine check"
    """

    [header | tasks] = String.split(body, ~r{(\r\n|\r|\n)})

    _ = """
    then, after the previous split based on new lines chars, body becomes

    ["item,priority,urgency,date added,notes", -> first row/element (titles)
    "take out trash,4,1,Dec 11,stinking badly", -> second row/element (task 1)
    "see doctor,1,3,Dec 05,routine check"] -> third row/element (task 2)

    """

    # titles = ["priority", "urgency", "date added", "notes"] skipping the name
    titles = tl(String.split(header, ","))
    # titles = ["take out trash,4,1,Dec 11,stinking badly",
    # "see doctor,1,3,Dec 05,routine check"]
    parse_lines(tasks, titles)
  end

  def parse_lines(items, titles) do
    Enum.reduce(items, %{}, fn item, built ->
      [name | fields] = String.split(item, ",")

      if Enum.count(fields) == Enum.count(titles) do
        item_data = Enum.zip(titles, fields) |> Enum.into(%{})
        Map.put(built, name, item_data)
        # _map_at_this_point = """
        # %{
        #   "see doctor" => %{
        #     "date added" => "Dec 05",
        #     "notes" => "routine check",
        #     "priority" => "1",
        #     "urgency" => "3"
        #   },
        #   "take out trash" => %{
        #     "date added" => "Dec 11",
        #     "notes" => "stinking badly",
        #     "priority" => "4",
        #     "urgency" => "1"
        #   }
        # """
      else
        built
      end
    end)
  end

  def show_todos(todo_items, next_command? \\ true) do
    items = Map.keys(todo_items)
    IO.puts("You have the following todos:")
    Enum.each(items, fn item -> IO.puts(item) end)

    if next_command? do
      get_command(todo_items)
    end
  end

  def get_command(todo_items) do
    prompt = """
      Type the first letter of the command you want to run:
      R)ead todos   A)dd a todo   D)elete a todo    L)oad a .csv     S)ave a .csv
    """

    command =
      IO.gets(prompt)
      |> String.trim()
      |> String.downcase()

    case command do
      "r" -> show_todos(todo_items)
      "a" -> add_todo(todo_items)
      "d" -> delete_todo(todo_items)
      # "l" -> load_csv()
      "q" -> "Good bye"
      _ -> get_command(todo_items)
    end
  end

  def delete_todo(todo_items) do
    todo = IO.gets("Delete which one? ")
    todo = String.trim(todo)

    if Map.has_key?(todo_items, todo) do
      IO.puts("OK")
      # maps are immutable in Elixir
      new_map = Map.drop(todo_items, [todo])
      IO.puts("Todo deleted!")
      get_command(new_map)
    else
      "#{todo} doesn't exist"
      show_todos(todo_items)
      delete_todo(todo_items)
    end
  end

  def add_todo(todo_items) do
    new_todo = IO.gets("Enter the new todo title: ")
    new_todo = String.trim(new_todo)
    priority = IO.gets("Enter the new todo priority: ")
    priority = String.trim(priority)
    urgency = IO.gets("Enter the new todo urgency: ")
    urgency = String.trim(urgency)
    date_added = IO.gets("Enter the new todo date: ")
    date_added = String.trim(date_added)
    notes = IO.gets("Enter the new todo notes: ")
    notes = String.trim(notes)
    fields = get_fields(todo_items)
    item_data = Enum.zip(fields, [date_added, notes, priority, urgency]) |> Enum.into(%{})
    Map.put(todo_items, new_todo, item_data)
    get_command(todo_items)
  end

  def get_todo_name(todo_items) do
    name = IO.gets("Enter the new todo title: " |> String.trim())

    if Map.has_key?(todo_items, name) do
      IO.puts("Todo already exists!\n")
    else
      name
    end
  end

  def get_fields(todo_items) do
    todo_items[hd(Map.keys(todo_items))] |> Map.keys()
  end
end

MinimalTodo.read("todo.csv")
