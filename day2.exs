defmodule Checksum do

	@doc """
	calculate checksum of a 2d array by subtracting max and min from each row and then summing it up
	"""
	def checksum1(filename) do
		filename
		|> parse_input
		|> Enum.map(fn(lst) -> Enum.max(lst) - Enum.min(lst) end)
		|> Enum.sum
	end

	def checksum2(filename) do
		filename
		|> parse_input
		|> Enum.map(&Checksum.coefficient_evenly_divisible_pair/1)
		|> Enum.sum
	end

	def coefficient_evenly_divisible_pair(lst) do
		hd(for i <- lst, j <- lst, i > j && rem(i, j) == 0, do: div(i, j))
	end

	def parse_input(filename) do
		File.read!(filename)
		|> String.trim
		|> String.split("\n")
		|> Enum.map(
			fn row -> row 
				|> String.split("\t") 
				|> Enum.map(fn x -> String.to_integer x end) 
			end)
	end
end