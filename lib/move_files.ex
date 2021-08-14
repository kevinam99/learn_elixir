defmodule MoveFiles do
  def start do
    get_files()
    |> filter_images
    |> move_to_folder
  end

  defp get_files do
    case File.ls("./lib/files/") do
      {:ok, files} -> files
      {:error, reason} -> :file.format_error(reason)
    end
  end

  defp filter_images(files) do
    matcher = ~r/\.(jpg|bmp|gif|png)$/

    Enum.filter(files, fn filename ->
      Regex.match?(matcher, filename)
    end)
  end

  defp move_to_folder(files) do
    IO.inspect(files)
    # possible_msgs = [:ok, {:error, :eexist}]
    case File.mkdir("./lib/files/images/") do
      :ok ->
        Enum.each(files, fn file ->
          File.rename("lib/files/" <> file, "lib/files/images/" <> file)
        end)

      {:error, :eexist} ->
        Enum.each(files, fn file ->
          File.rename("lib/files/" <> file, "lib/files/images/" <> file)
        end)

      {:error, reason} ->
        :file.format_error(reason)
    end
  end
end
