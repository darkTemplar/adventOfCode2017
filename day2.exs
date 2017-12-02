defmodule Checksum do

	@doc """
	calculate checksum of a 2d array by subtracting max and min from each row and then summing it up
	"""
	def checksum(filename) do
		filename
		|> parseInput
		|> Enum.map(fn(lst) -> Enum.max(lst) - Enum.min(lst) end)
		|> Enum.sum
	end

	defp parseInput(filename) do
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