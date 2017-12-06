defmodule TwistyMaze do
	
	
	def escape_maze(filename) do
		seq = parse_input(filename)
		jump(seq, 0, 0)
	end

	def jump(seq, index, num_ops) when index >= tuple_size(seq), do: num_ops

	def jump(seq, index, num_ops) do
		val = elem(seq, index)
		new_val = if val >= 3 do val - 1 else val + 1 end
		modified_seq = put_elem(seq, index, new_val)
		jump(modified_seq, index + val, num_ops + 1)
	end

	def parse_input(filename) do
		filename
		|> File.read!
		|> String.trim
		|> String.split("\n")
		|> Enum.map(fn x -> String.to_integer(x) end)
		|> List.to_tuple
	end
end