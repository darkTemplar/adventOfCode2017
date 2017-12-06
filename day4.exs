defmodule Passphrase do
	

	def valid_passphrases1(filename) do
		filename
		|> parse_input
		|> Enum.filter(&Passphrase.is_passphrase1?/1)
		|> length
	end

	def is_passphrase1?(code) do
		lst = String.split(code, " ")
		length(lst) == MapSet.size(MapSet.new(lst))
	end

	def valid_passphrases2(filename) do
		filename
		|> parse_input
		|> Enum.filter(&Passphrase.is_passphrase2?/1)
		|> length
	end

	def is_passphrase2?(code) do
		lst = code 
			|> String.split(" ")
			|> Enum.map(&Passphrase.sort_string/1) 
		length(lst) == MapSet.size(MapSet.new(lst))
	end

	def sort_string(str) do
		str
		|> String.downcase
		|> String.graphemes
		|> Enum.sort
	end


	def parse_input(filename) do
		filename
		|> File.read!
		|> String.trim
		|> String.split("\n")
	end

end