defmodule ReportAsync.MonthsTest do
  use ExUnit.Case

  alias ReportAsync.Months

  describe "get" do
    test "get months" do
      expected_response = %{
        "1" => "janeiro",
        "2" => "fevereiro",
        "3" => "março",
        "4" => "abril",
        "5" => "maio",
        "6" => "junho",
        "7" => "julho",
        "8" => "agosto",
        "9" => "setembro",
        "10" => "outubro",
        "11" => "novembro",
        "12" => "dezembro"
      }
      response = Months.get()

      assert response == expected_response
    end
  end
end
