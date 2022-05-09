defmodule ReportAsyncTest do
  use ExUnit.Case
  doctest ReportAsync


  describe "build_async/1" do
    test "fails when parameter is not a list" do
      expected_response = {:error, "The parameter file_name must be a list!"}
      response = ReportAsync.build_async("should fail")

      assert response == expected_response
    end

    test "build multiple files" do
      expect_response = {:ok, %{"all_hours" => %{"cleiton" => 9, "daniele" => 12, "danilo" => 14, "diego" => 4, "giuliano" => 20, "jakeliny" => 19, "joseph" => 24, "mayk" => 12, "vinicius" => 8}, "hours_per_month" => %{"cleiton" => %{"abril" => 3, "agosto" => 2, "dezembro" => 3, "fevereiro" => 0, "janeiro" => 0, "julho" => 0, "junho" => 1, "maio" => 0, "março" => 0, "novembro" => 0, "outubro" => 0, "setembro" => 0}, "daniele" => %{"abril" => 7, "agosto" => 0, "dezembro" => 5, "fevereiro" => 0, "janeiro" => 0, "julho" => 0, "junho" => 0, "maio" => 0, "março" => 0, "novembro" => 0, "outubro" => 0, "setembro" => 0}, "danilo" => %{"abril" => 0, "agosto" => 8, "dezembro" => 0, "fevereiro" => 6, "janeiro" => 0, "julho" => 0, "junho" => 0, "maio" => 0, "março" => 0, "novembro" => 0, "outubro" => 0, "setembro" => 0}, "diego" => %{"abril" => 0, "agosto" => 0, "dezembro" => 0, "fevereiro" => 0, "janeiro" => 0, "julho" => 0, "junho" => 0, "maio" => 0, "março" => 0, "novembro" => 0, "outubro" => 4, "setembro" => 0}, "giuliano" => %{"abril" => 0, "agosto" => 0, "dezembro" => 0, "fevereiro" => 11, "janeiro" => 0, "julho" => 0, "junho" => 0, "maio" => 0, "março" => 3, "novembro" => 0, "outubro" => 6, "setembro" => 0}, "jakeliny" => %{"abril" => 0, "agosto" => 0, "dezembro" => 5, "fevereiro" => 0, "janeiro" => 0, "julho" => 8, "junho" => 0, "maio" => 0, "março" => 6, "novembro" => 0, "outubro" => 0, "setembro" => 0}, "joseph" => %{"abril" => 7, "agosto" => 0, "dezembro" => 0, "fevereiro" => 0, "janeiro" => 0, "julho" => 0, "junho" => 0, "maio" => 0, "março" => 15, "novembro" => 2, "outubro" => 0, "setembro" => 0}, "mayk" => %{"abril" => 2, "agosto" => 0, "dezembro" => 5, "fevereiro" => 0, "janeiro" => 0, "julho" => 0, "junho" => 0, "maio" => 5, "março" => 0, "novembro" => 0, "outubro" => 0, "setembro" => 0}, "vinicius" => %{"abril" => 0, "agosto" => 0, "dezembro" => 0, "fevereiro" => 0, "janeiro" => 0, "julho" => 0, "junho" => 2, "maio" => 0, "março" => 0, "novembro" => 0, "outubro" => 0, "setembro" => 6}}, "hours_per_year" => %{"cleiton" => %{2016 => 2, 2017 => 0, 2018 => 0, 2019 => 3, 2020 => 4}, "daniele" => %{2016 => 5, 2017 => 0, 2018 => 7, 2019 => 0, 2020 => 0}, "danilo" => %{2016 => 8, 2017 => 0, 2018 => 6, 2019 => 0, 2020 => 0}, "diego" => %{2016 => 0, 2017 => 0, 2018 => 0, 2019 => 0, 2020 => 4}, "giuliano" => %{2016 => 0, 2017 => 12, 2018 => 0, 2019 => 8, 2020 => 0}, "jakeliny" => %{2016 => 0, 2017 => 13, 2018 => 0, 2019 => 6, 2020 => 0}, "joseph" => %{2016 => 0, 2017 => 3, 2018 => 0, 2019 => 9, 2020 => 12}, "mayk" => %{2016 => 7, 2017 => 1, 2018 => 0, 2019 => 4, 2020 => 0}, "vinicius" => %{2016 => 1, 2017 => 0, 2018 => 7, 2019 => 0, 2020 => 0}}}}
      response = ReportAsync.build_async(["part_test1.csv", "part_test2.csv", "part_test3.csv"])

      assert response == expect_response
    end
  end
end
