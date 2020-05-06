defmodule CreateExcelDemo do
  alias Elixlsx.{Workbook, Sheet, Image}
  @moduledoc """
  Documentation for `CreateExcelDemo`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> CreateExcelDemo.hello()
      :world

  """
  def hello do
    sheet =
    Sheet.with_name("Sheet 1")
    |> Sheet.set_cell("A1", "Hello")
    |> Sheet.insert_image(0, 1, Path.expand("190901.jpg",__DIR__))
    |> Sheet.set_row_height(1, 200)
    |> Sheet.set_col_width("B", 22)

    Workbook.append_sheet(%Workbook{}, sheet)
    |> Elixlsx.write_to("hello.xlsx")
  end

  def gen do
    sheet = %Sheet{
      name: "Sheet1",
      rows: [["条形码", "标签", "图片"],["123", "123"],["123", "123"]],
      col_widths: %{3 => 22}, #1开始
      row_heights: %{2 => 200, 3 => 200}, #1开始
      images: [
        Image.new(Path.expand("../190901.jpg",__DIR__), 1, 2), #0开始
        Image.new(Path.expand("../190901.jpg",__DIR__), 2, 2)
      ]
    }

    %Workbook{sheets: [sheet]}
    |> Elixlsx.write_to("gen.xlsx")
  end
end
