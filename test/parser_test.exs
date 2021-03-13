defmodule HrReport.ParserTest do
  use ExUnit.Case

  alias HrReport.Parser

  describe "parse_file/1" do
    test "parses the file" do
      file_name = "hr_report_test.csv"

      response = file_name |> Parser.parse_file() |> Enum.map(& &1)

      expected_response = [
        [:daniele, 7, "29", "4", "2018"],
        [:mayk, 4, "9", "12", "2019"],
        [:daniele, 5, "27", "12", "2016"],
        [:mayk, 1, "2", "12", "2017"],
        [:giuliano, 3, "13", "2", "2017"],
        [:cleiton, 1, "22", "6", "2020"],
        [:giuliano, 6, "18", "2", "2019"],
        [:jakeliny, 8, "18", "7", "2017"],
        [:joseph, 3, "17", "3", "2017"],
        [:jakeliny, 6, "23", "3", "2019"],
        [:cleiton, 3, "20", "6", "2016"],
        [:daniele, 5, "1", "5", "2016"],
        [:giuliano, 1, "2", "4", "2020"],
        [:daniele, 3, "5", "5", "2017"],
        [:daniele, 1, "26", "6", "2020"],
        [:diego, 3, "11", "9", "2016"],
        [:mayk, 7, "28", "7", "2017"],
        [:mayk, 7, "3", "9", "2016"],
        [:danilo, 6, "28", "2", "2019"],
        [:diego, 4, "15", "8", "2017"],
        [:cleiton, 8, "3", "10", "2020"],
        [:giuliano, 4, "24", "5", "2020"],
        [:rafael, 7, "1", "7", "2017"],
        [:danilo, 1, "7", "4", "2018"],
        [:diego, 1, "10", "12", "2019"],
        [:joseph, 5, "3", "11", "2020"],
        [:diego, 4, "2", "4", "2017"],
        [:joseph, 3, "10", "9", "2019"],
        [:jakeliny, 8, "15", "3", "2016"],
        [:joseph, 2, "27", "12", "2020"],
        [:rafael, 7, "9", "8", "2017"],
        [:diego, 1, "6", "5", "2018"],
        [:mayk, 3, "14", "6", "2019"],
        [:joseph, 4, "16", "4", "2020"],
        [:cleiton, 7, "2", "7", "2018"],
        [:mayk, 4, "27", "4", "2020"],
        [:mayk, 3, "18", "3", "2020"],
        [:jakeliny, 2, "5", "10", "2020"],
        [:mayk, 4, "9", "11", "2016"],
        [:jakeliny, 1, "29", "12", "2019"],
        [:diego, 6, "30", "3", "2018"],
        [:jakeliny, 8, "24", "12", "2016"]
      ]
      assert response == expected_response
    end
  end
end
