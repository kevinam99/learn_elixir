defmodule MiniMarkdown do
  @moduledoc"""
  A module to parse markdown and convert it to HTML
  """
  def start() do
    markdown = """
    # Diary note
      I *so* enjoyed eating the pot roast. **Thank you** for it

      What did you think of it?
      asdf
    """
    |> String.trim
    |> bold
    |> italics
    |> paragraph
    |> h1
    |> h2
    |> h3

  end

  defp bold(markdown) do
    Regex.replace(~r/\*\*(.*)\*\*/, markdown, "<strong>\\1</strong>")
  end

  defp italics(markdown) do
    Regex.replace(~r/\*(.*)\*/, markdown, "<em>\\1</em>")
  end

  defp paragraph(markdown) do
    Regex.replace(~r/(\r\n|\n|\r|^)+([^\r\n]+)$/, markdown, "<p>\\2</p>")
  end

  # h1 and h2 headings

  defp h1(markdown) do
    Regex.replace(~r/^#(.*)([\r\n]+)/, markdown, "<h1>\\1<h1>")
  end

  defp h2(markdown) do
    Regex.replace(~r/^##(.*)([\r\n]+)/, markdown, "<h2>\\1<h2>")
  end

  defp h3(markdown) do
    Regex.replace(~r/^###(.*)([\r\n]+)/, markdown, "<h3>\\1<h3>")
  end

end
