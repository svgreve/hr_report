defmodule HrReport do
  alias HrReport.Parser

  @options ["all_hours", "all_hours_per_year"]

  def build(filename) do
    list_of_names = get_list_of_names(filename)
    # IO.inspect(list_of_names)
    list_of_years = get_list_of_years(filename)
    # IO.inspect(list_of_years)
    accumulator = report_acc(list_of_names, list_of_years)
    IO.inspect(accumulator)
    filename
    |> Parser.parse_file()
    |> Enum.reduce(accumulator, fn line, report -> sum_values(line, report) end)
  end

  def get_list_of_names(filename) do
    filename
    |> Parser.parse_file()
    |> Enum.uniq_by(fn [name, _hours, _day, _month, _year] -> name end)
    |> Enum.map(fn [name, _hours, _day, _month, _year] -> name end)
  end

  def get_list_of_years(filename) do
    filename
    |> Parser.parse_file()
    |> Enum.uniq_by(fn [_name, _hours, _day, _month, year] -> year end)
    |> Enum.map(fn [_name, _hours, _day, _month, year] -> year end)
  end

  def fetch_higher_value(report, option) when option in @options do
    {:ok, Enum.max_by(report[option], fn {_key, value} -> value end)}
  end

  def fetch_higher_value(_report, _option), do: {:error, "Invalid option!"}

  defp sum_values(
         [name, hours, _day, month, year],
         %{
           "all_hours" => all_hours,
           "all_hours_per_year" => all_hours_per_year,
           "hours_per_year" => hours_per_year,
           "hours_per_month" => hours_per_month
         } = report
       ) do

    all_hours = Map.put(all_hours, name, all_hours[name] + hours)

    all_hours_per_year = Map.put(all_hours_per_year, year, all_hours_per_year[year] + hours)

    hours_per_person = hours_per_year[name] #only one individual - all years
    hours_per_person = Map.put(hours_per_person, year, hours_per_person[year] + hours)
    hours_per_year = Map.put(hours_per_year, name, hours_per_person)

    hours_per_person = hours_per_month[name] #only one individual - all month
    hours_per_person = Map.put(hours_per_person, month, hours_per_person[month] + hours)
    hours_per_month = Map.put(hours_per_month, name, hours_per_person)


    report
    |> Map.put("all_hours", all_hours)
    |> Map.put("all_hours_per_year", all_hours_per_year)
    |> Map.put("hours_per_year", hours_per_year)
    |> Map.put("hours_per_month", hours_per_month)

    # %{report | "all_hours" => all_hours, "all_hours_per_year" => all_hours_per_year}
  end

  def report_acc(list_of_names, list_of_years) do
    all_hours = Enum.into(list_of_names, %{}, fn person -> {person, 0} end)
    all_hours_per_year = Enum.into(list_of_years, %{}, fn year -> {year, 0} end)

    hours_per_year =
      Enum.into(list_of_names, %{}, fn name ->
        {name, Enum.into(list_of_years, %{}, fn year -> {year, 0} end)}
      end)

      hours_per_month =
        Enum.into(list_of_names, %{}, fn month ->
          {month, Enum.into(1..12, %{}, fn month -> {Integer.to_string(month), 0} end)}
        end)

    %{
      "all_hours" => all_hours,
      "all_hours_per_year" => all_hours_per_year,
      "hours_per_year" => hours_per_year,
      "hours_per_month" => hours_per_month
    }
  end
end
