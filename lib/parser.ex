defmodule HrReport.Parser do


  def parse_file(filename) do
    "reports/#{filename}"
    |> File.stream!()
    |> Stream.map(fn line -> parse_line(line) end)
    # |> Enum.each(fn line -> IO.inspect(line) end)
  end


  defp parse_line(line) do
    line
    |> String.trim()
    |> String.split(",")
    |> List.update_at(1, &String.to_integer/1) # hours must be numeric
    |> List.update_at(0, &String.downcase/1) # names in lowercase
    |> List.update_at(0, &String.to_atom/1) # names as atoms
    # |> List.update_at(3, fn month -> month_name(month) end)
  end
end
