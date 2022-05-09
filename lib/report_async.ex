defmodule ReportAsync do
  alias ReportAsync.{Months, Parser}

  def build_async(file_name) when not is_list(file_name), do: {:error, "The parameter file_name must be a list!"}

  def build_async(file_names) do
    file_names
    |> Task.async_stream(&fetch_report_data/1)
    |> merge_reports()
  end

  defp fetch_report_data(file_name) do
    file_name
    |> Parser.parse_file()
    |> format_report()
  end

  defp format_report(report_data) do
    names =
      report_data
      |> Enum.uniq_by(fn [name | _] -> name end)
      |> Enum.map(fn [name | _] -> name end)

    years =
      report_data
      |> Enum.uniq_by(fn [_, _, _, _, year] -> year end)
      |> Enum.map(fn [_, _, _, _, year] -> year end)

    report_data
    |> Enum.reduce(report_accumulator(names, years), fn line, report ->
      sum_values(line, report)
    end)
  end

  defp report_accumulator(names, years) do
    months = Months.get()

    all_hours =
      names
      |> Enum.reduce(%{}, fn name, result -> Map.put(result, name, 0) end)

    hours_per_month =
      names
      |> Enum.reduce(%{}, fn name, result ->
        name_months =
          months
          |> Enum.reduce(%{}, fn {_key, value}, months_result ->
            Map.put(months_result, value, 0)
          end)

        Map.put(result, name, name_months)
      end)

    hours_per_year =
      names
      |> Enum.reduce(%{}, fn name, result ->
        name_years =
          years
          |> Enum.reduce(%{}, fn year, years_acc -> Map.put(years_acc, year, 0) end)

        Map.put(result, name, name_years)
      end)

    %{
      "all_hours" => all_hours,
      "hours_per_month" => hours_per_month,
      "hours_per_year" => hours_per_year
    }
  end

  defp sum_values([name, hours, _day, month, year], %{
         "all_hours" => all_hours,
         "hours_per_month" => hours_per_month,
         "hours_per_year" => hours_per_year
       }) do
    all_hours = Map.put(all_hours, name, all_hours[name] + hours)

    month_name_values = get_in(hours_per_month, [name])
    month_name_values = Map.put(month_name_values, month, month_name_values[month] + hours)
    hours_per_month = Map.put(hours_per_month, name, month_name_values)

    year_name_values = get_in(hours_per_year, [name])
    year_name_values = Map.put(year_name_values, year, year_name_values[year] + hours)
    hours_per_year = Map.put(hours_per_year, name, year_name_values)

    %{
      "all_hours" => all_hours,
      "hours_per_month" => hours_per_month,
      "hours_per_year" => hours_per_year
    }
  end

  defp merge_reports(reports) do
    result =
      reports
      |> Enum.reduce(
        %{
          "all_hours" => %{},
          "hours_per_month" => %{},
          "hours_per_year" => %{}
        },
        fn {:ok, %{
             "all_hours" => all_hours_1,
             "hours_per_month" => hours_per_month_1,
             "hours_per_year" => hours_per_year_1
           } },
           %{
             "all_hours" => all_hours_2,
             "hours_per_month" => hours_per_month_2,
             "hours_per_year" => hours_per_year_2
           } ->
          # TODO: daqui pra baixo
          all_hours =
            Map.merge(all_hours_1, all_hours_2, fn _key, value_1, value_2 -> value_1 + value_2 end)

          hours_per_month = Map.merge(hours_per_month_1, hours_per_month_2, fn _key, name_1, name_2 ->
            Map.merge(name_1, name_2, fn _inner_key, value_1, value_2 -> value_1 + value_2 end)
          end)

          hours_per_year = Map.merge(hours_per_year_1, hours_per_year_2, fn _key, name_1, name_2 ->
            Map.merge(name_1, name_2, fn _inner_key, value_1, value_2 -> value_1 + value_2 end)
          end)

          %{
            "all_hours" => all_hours,
            "hours_per_month" => hours_per_month,
            "hours_per_year" => hours_per_year
          }
        end
      )

    {:ok, result}
  end
end
