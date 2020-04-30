defmodule CreateExcelDemo do
  alias Elixlsx.{Workbook,Sheet}
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
end
