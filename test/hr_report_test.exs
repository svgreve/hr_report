defmodule HrReportTest do
  use ExUnit.Case

  describe "build/1" do
    test "builds the report" do
      file_name = "hr_report_test.csv"

      response = HrReport.build(file_name)

      expected_response = %{
        "hours_by_person" => %{
          "Cleiton" => 19,
          "Daniele" => 21,
          "Danilo" => 7,
          "Diego" => 19,
          "Giuliano" => 14,
          "Jakeliny" => 33,
          "Joseph" => 17,
          "Mayk" => 33,
          "Rafael" => 14
        },
        "hours_by_year" => %{"2016" => 43, "2017" => 47, "2018" => 22, "2019" => 30, "2020" => 35}
      }

      assert response == expected_response
    end
  end

  describe "fetch_higher_value/2" do
    test "when option is 'hours_by_person' returns person who worked the most" do
      file_name = "hr_report_test.csv"
      response =
        file_name
        |> HrReport.build()
        |> HrReport.fetch_higher_value("hours_by_person")

      expected_response = {:ok, {"Jakeliny", 33}}

      assert response == expected_response
    end

    test "when option is 'hours_by_year' returns year with more hours" do
      file_name = "hr_report_test.csv"
      response =
        file_name
        |> HrReport.build()
        |> HrReport.fetch_higher_value("hours_by_year")

      expected_response =  {:ok, {"2017", 47}}

      assert response == expected_response
    end

    test "when invalid option is given returns an error" do
      file_name = "hr_report_test.csv"
      response =
        file_name
        |> HrReport.build()
        |> HrReport.fetch_higher_value("x")

      expected_response = {:error, "Invalid option!"}

      assert response == expected_response
    end

  end
end
