defmodule HrReport do

  alias HrReport.Parser

  @options [ "hours_by_person", "hours_by_year"]

  def build(filename) do
    list_of_names = get_list_of_names(filename)
    # IO.inspect(list_of_names)
    list_of_years = get_list_of_years(filename)
    # IO.inspect(list_of_years)
    accumulator = report_acc(list_of_names, list_of_years)
    # IO.inspect(accumulator)
    filename
    |> Parser.parse_file()
    |> Enum.reduce(accumulator, fn line, report -> sum_values(line, report) end)

  end

  defp get_list_of_names(filename) do
    filename
    |> Parser.parse_file()
    |> Enum.uniq_by( fn [name, _hours, _day, _month,  _year] -> name  end )
    |> Enum.map(fn [name, _hours, _day, _month, _year] -> name end)
  end

  defp get_list_of_years(filename) do
    filename
    |> Parser.parse_file()
    |> Enum.uniq_by( fn [_name, _hours, _day, _month,  year] -> year  end )
    |> Enum.map(fn [_name, _hours, _day, _month, year] -> year end)
  end

  def fetch_higher_value(report, option) when option in @options do
    {:ok, Enum.max_by(report[option], fn {_key, value } -> value end)}
  end

  def fetch_higher_value(_report, _option), do: {:error, "Invalid option!"}

  defp sum_values([name, hours, _day, _month, year], %{"hours_by_person" => hours_by_person, "hours_by_year" => hours_by_year} = report) do
    hours_by_person = Map.put(hours_by_person, name, hours_by_person[name] + hours)
    hours_by_year = Map.put(hours_by_year, year, hours_by_year[year] + hours)

    # report
    # |> Map.put("hours_by_person", hours_by_person)
    # |> Map.put("hours_by_year", hours_by_year)

    %{report | "hours_by_person" => hours_by_person, "hours_by_year" => hours_by_year}

  end

  # defp report_acc do
  #   Enum.into(2016..2020, %{}, fn year -> {Integer.to_string(year), 0} end)
  # end

  defp report_acc(list_of_names, list_of_years) do
    hours_by_person = Enum.into(list_of_names, %{}, fn person -> {person, 0} end)
    hours_by_year = Enum.into(list_of_years, %{}, fn year -> {year, 0} end)
    %{"hours_by_person" => hours_by_person, "hours_by_year" => hours_by_year}
  end



end
