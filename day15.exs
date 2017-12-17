defmodule DuelingGenerators do
	use Bitwise
	

	def gen_value_A(seed), do: rem(seed * 16807, 2147483647)

	def gen_value_B(seed), do: rem(seed * 48271, 2147483647)

	def extract_lowest_n_bits(value, n), do: band(value, create_bit_mask(n-1, 1))

	def create_bit_mask(n, mask) when n > 0, do: create_bit_mask(n-1, bor(mask, 1 <<< n))
	def create_bit_mask(_, mask), do: mask

	def count_matches(seedA, seedB, num_simulations) do
		run_simulation(gen_value_A(seedA), gen_value_B(seedB), 0, num_simulations)
	end

	def run_simulation(_, _, matches, simulations_left) when simulations_left == 0, do: matches

	def run_simulation(valueA, valueB, matches, simulations_left) when rem(valueA, 4) != 0, do: run_simulation(gen_value_A(valueA), valueB, matches, simulations_left)
 
	def run_simulation(valueA, valueB, matches, simulations_left) when rem(valueB, 8) != 0, do: run_simulation(valueA, gen_value_B(valueB), matches, simulations_left)

	def run_simulation(valueA, valueB, matches, simulations_left) do
		matches = if extract_lowest_n_bits(valueA, 16) == extract_lowest_n_bits(valueB, 16) do matches + 1 else matches end
		run_simulation(gen_value_A(valueA), gen_value_B(valueB), matches, simulations_left - 1)
	end

end