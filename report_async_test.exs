defmodule ReportAsyncTest do
  use ExUnit.Case
  doctest ReportAsync


  describe "build_async/1" do
    test "fails when parameter is not a list" do
      expected_response = {:error, "The parameter file_name must be a list!"}
      response = ReportAsync.build_async("should fail")

      assert response == expected_response
    end
  end
end
