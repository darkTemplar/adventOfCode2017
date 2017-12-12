defmodule HexGrid do
	@directions %{"n" => {0, 1, -1}, "ne" => {-1, 0 , -1}, "se" => {-1, -1, 0},
	 "s" => {0, -1, 1}, "sw" => {1, 0, 1}, "nw" => {1, 1, 0}}

	def number_of_steps(filename) do
		filename
		|> parse_input
		|> Enum.map(&HexGrid.parse_direction/1)
		|> Enum.reduce({0, 0, 0}, fn ({x, y, z}, {a,b,c}) -> {x+a, y+b, z+c} end)
		|> hex_distance({0, 0, 0})
	end

	def max_number_of_steps(filename) do
		filename
		|> parse_input
		|> Enum.map(&HexGrid.parse_direction/1)
		|> Enum.scan({0, 0, 0}, fn ({x, y, z}, {a,b,c}) -> {x+a, y+b, z+c} end)
		|> Enum.map(&HexGrid.hex_distance(&1, {0, 0, 0}))
		|> Enum.max
	end

	def parse_direction(direction) do
		Map.get(@directions, direction)
	end

	def parse_input(filename) do
		filename
		|> File.read!
		|> String.trim
		|> String.split(",")
	end

	def hex_distance({x1, y1, z1}, {x2, y2, z2}), do: {abs(x1-x2), abs(y1-y2), abs(z1-z2)} |> Tuple.to_list |> Enum.max

end