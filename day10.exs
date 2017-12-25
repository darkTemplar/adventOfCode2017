defmodule KnotHash do

	def calculate_hash(xs, lengths) do
		lengths
		|> Enum.reduce({xs, 0, 0}, &KnotHash.knot/2)
		|> (fn {[x1|[x2|_]], _, _} -> x1 * x2 end).() 
	end

	
	# to optimize further we could pass length of the list
	def knot(n, {xs, index, skip}) do
		xs =
		xs
		|> Enum.split(index)
		|> (fn {a,b} -> b ++ a end).()
		|> Enum.split(n)
		|> (fn {a, b} -> Enum.reverse(a) ++ b end).()
		|> Enum.split(length(xs) - index)
		|> (fn {a,b} -> b ++ a end).()
		{xs, rem(index + skip + n, length(xs)), skip + 1}
 	end
	
end