defmodule CharacterProcessing do
	

	def process_group(["!" | xs], score, level, garbage_mode), do: process_group(Enum.drop(xs, 1), score, level, garbage_mode)
	def process_group(["{" | xs], score, level, garbage_mode) when garbage_mode == false, do: process_group(xs, score, level + 1, garbage_mode)
	def process_group(["<" | xs], score, level, garbage_mode), do: process_group(xs, score, level, true)
	def process_group([">" | xs], score, level, garbage_mode), do: process_group(xs, score, level, false)
	def process_group(["}" | xs], score, level, garbage_mode) when garbage_mode == false, do: process_group(xs, score + level*1, level - 1, garbage_mode)
	def process_group([_ | xs], score, level, garbage_mode), do: process_group(xs, score, level, garbage_mode)
	def process_group([], score, _, _), do: score


	def count_garbage(["!" | xs], count, garbage_mode), do: count_garbage(Enum.drop(xs, 1), count, garbage_mode)
	def count_garbage(["<" | xs], count, garbage_mode) when garbage_mode == false, do: count_garbage(xs, count, true)
	def count_garbage([">" | xs], count, garbage_mode), do: count_garbage(xs, count, false)
	def count_garbage([_ | xs], count, garbage_mode) when garbage_mode == true, do: count_garbage(xs, count + 1, garbage_mode)
	def count_garbage([_ | xs], count, garbage_mode), do: count_garbage(xs, count, garbage_mode)
	def count_garbage([], count, _), do: count

end