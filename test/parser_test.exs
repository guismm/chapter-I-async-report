defmodule ReportAsync.ParserTest do
  use ExUnit.Case

  alias ReportAsync.Parser

  describe "parse_file/1" do
    test "parses the file" do
      file_name = "part_test1.csv"

      response =
        file_name
        |> Parser.parse_file()
        |> Enum.member?(["daniele", 7, 29, "abril", 2018])

      assert response == true
    end
  end
end
