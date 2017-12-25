defmodule MemoryReallocation do
	

	def count_reallocations(banks) do
		banks
		|> fetch_states
		|> (fn {_, seen, _} -> MapSet.size(seen) end).()

	end


	def count_cycles(banks) do
		banks
		|> fetch_states
		|> (fn {x, _, states} -> [x |Enum.take_while(states, fn a -> a != x end)] end).()
		|> length
	end

	def fetch_states(banks, seen \\ MapSet.new(), states \\ []) do 
		case MapSet.member?(seen, banks) do
			true -> {banks, seen, states}
			_ -> reallocate(banks, seen, states)
		end
	end

	def reallocate(banks, seen, states) do
		seen = MapSet.put(seen, banks)
		states = [banks| states]
		{max_memory, index} = banks |> Enum.with_index |> Enum.max_by(fn {a, _} -> a end) 
		num_banks = length(banks)
		reallocate_all = div(max_memory, num_banks)
		num_increments = rem(max_memory, num_banks)
		banks = 
		banks
		|> Enum.map(fn x -> x + reallocate_all end)
		|> Enum.split(index)
		|> (fn {a, b} -> b ++ a end).()
		|> Enum.split(num_increments + 1)
		|> (fn {a, b} -> [reallocate_all | Enum.map(tl(a), fn x -> x + 1 end)] ++ b end).()
		|> Enum.split(num_banks - index)
		|> (fn {a, b} -> b ++ a end).()
		fetch_states(banks, seen, states)
	end

end