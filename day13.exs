defmodule Scanner do
	
	def calculate_severity(depths) do
		depths
		|> Enum.with_index
		|> Enum.reduce({0, 0}, fn ({depth, layer}, {severity, time}) -> 
			if depth > 0 && rem(time, 2*depth - 2) == 0 do {severity + depth * layer, time + 1} else {severity, time + 1} end end)
		|> elem(0)
	end

end