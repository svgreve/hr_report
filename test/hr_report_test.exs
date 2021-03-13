defmodule HrReportTest do
  use ExUnit.Case

  describe "build/1" do
    test "builds the report" do
      file_name = "hr_report_test.csv"

      response = HrReport.build(file_name)

      expected_response = %{
        all_hours: %{
          cleiton: 19,
          daniele: 21,
          danilo: 7,
          diego: 19,
          giuliano: 14,
          jakeliny: 33,
          joseph: 17,
          mayk: 33,
          rafael: 14
        },
        all_hours_per_year: %{
          "2016" => 43,
          "2017" => 47,
          "2018" => 22,
          "2019" => 30,
          "2020" => 35
        },
        hours_per_month: %{
          cleiton: %{
            abril: 0,
            agosto: 0,
            dezembro: 0,
            fevereiro: 0,
            janeiro: 0,
            julho: 7,
            junho: 4,
            maio: 0,
            março: 0,
            novembro: 0,
            outubro: 8,
            setembro: 0
          },
          daniele: %{
            abril: 7,
            agosto: 0,
            dezembro: 5,
            fevereiro: 0,
            janeiro: 0,
            julho: 0,
            junho: 1,
            maio: 8,
            março: 0,
            novembro: 0,
            outubro: 0,
            setembro: 0
          },
          danilo: %{
            abril: 1,
            agosto: 0,
            dezembro: 0,
            fevereiro: 6,
            janeiro: 0,
            julho: 0,
            junho: 0,
            maio: 0,
            março: 0,
            novembro: 0,
            outubro: 0,
            setembro: 0
          },
          diego: %{
            abril: 4,
            agosto: 4,
            dezembro: 1,
            fevereiro: 0,
            janeiro: 0,
            julho: 0,
            junho: 0,
            maio: 1,
            março: 6,
            novembro: 0,
            outubro: 0,
            setembro: 3
          },
          giuliano: %{
            abril: 1,
            agosto: 0,
            dezembro: 0,
            fevereiro: 9,
            janeiro: 0,
            julho: 0,
            junho: 0,
            maio: 4,
            março: 0,
            novembro: 0,
            outubro: 0,
            setembro: 0
          },
          jakeliny: %{
            abril: 0,
            agosto: 0,
            dezembro: 9,
            fevereiro: 0,
            janeiro: 0,
            julho: 8,
            junho: 0,
            maio: 0,
            março: 14,
            novembro: 0,
            outubro: 2,
            setembro: 0
          },
          joseph: %{
            abril: 4,
            agosto: 0,
            dezembro: 2,
            fevereiro: 0,
            janeiro: 0,
            julho: 0,
            junho: 0,
            maio: 0,
            março: 3,
            novembro: 5,
            outubro: 0,
            setembro: 3
          },
          mayk: %{
            abril: 4,
            agosto: 0,
            dezembro: 5,
            fevereiro: 0,
            janeiro: 0,
            julho: 7,
            junho: 3,
            maio: 0,
            março: 3,
            novembro: 4,
            outubro: 0,
            setembro: 7
          },
          rafael: %{
            abril: 0,
            agosto: 7,
            dezembro: 0,
            fevereiro: 0,
            janeiro: 0,
            julho: 7,
            junho: 0,
            maio: 0,
            março: 0,
            novembro: 0,
            outubro: 0,
            setembro: 0
          }
        },
        hours_per_year: %{
          cleiton: %{"2016" => 3, "2017" => 0, "2018" => 7, "2019" => 0, "2020" => 9},
          daniele: %{"2016" => 10, "2017" => 3, "2018" => 7, "2019" => 0, "2020" => 1},
          danilo: %{"2016" => 0, "2017" => 0, "2018" => 1, "2019" => 6, "2020" => 0},
          diego: %{"2016" => 3, "2017" => 8, "2018" => 7, "2019" => 1, "2020" => 0},
          giuliano: %{"2016" => 0, "2017" => 3, "2018" => 0, "2019" => 6, "2020" => 5},
          jakeliny: %{"2016" => 16, "2017" => 8, "2018" => 0, "2019" => 7, "2020" => 2},
          joseph: %{"2016" => 0, "2017" => 3, "2018" => 0, "2019" => 3, "2020" => 11},
          mayk: %{"2016" => 11, "2017" => 8, "2018" => 0, "2019" => 7, "2020" => 7},
          rafael: %{"2016" => 0, "2017" => 14, "2018" => 0, "2019" => 0, "2020" => 0}
        }
      }

      assert response == expected_response
    end
  end

  describe "fetch_higher_value/2" do
    test "when option is ':all_hours' returns person who worked the most" do
      file_name = "hr_report_test.csv"

      response =
        file_name
        |> HrReport.build()
        |> HrReport.fetch_higher_value(:all_hours)

      expected_response = {:ok, {:jakeliny, 33}}

      assert response == expected_response
    end

    test "when option is ':all_hours_per_year' returns year with most hours" do
      file_name = "hr_report_test.csv"

      response =
        file_name
        |> HrReport.build()
        |> HrReport.fetch_higher_value(:all_hours_per_year)

      expected_response = {:ok, {"2017", 47}}

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
