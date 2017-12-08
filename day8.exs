defmodule Register do
	
	
	def find_max_register_end(filename) do
		filename
		|> parse_input
		|> Enum.reduce({%{}, 0}, &parse_instruction/2)
		|> elem(0)
		|> Map.values()
		|> Enum.max
	end

	def find_max_register_any(filename) do
		filename
		|> parse_input
		|> Enum.reduce({%{}, 0}, &parse_instruction/2)
		|> elem(1)
	end


	def parse_instruction(instruction, {registers, max_register_value}) do
		{op_register, op, op_val, _, register, predicate, expected_val} = instruction
		register_val = Map.get(registers, register, 0)

		case predicate do
			">" -> if register_val > expected_val do apply_op(registers, op_register, op, op_val, max_register_value) else {registers, max_register_value} end
			">=" -> if register_val >= expected_val do apply_op(registers, op_register, op, op_val, max_register_value) else {registers, max_register_value} end
			"<" -> if register_val < expected_val do apply_op(registers, op_register, op, op_val, max_register_value) else {registers, max_register_value} end
			"<=" -> if register_val <= expected_val do apply_op(registers, op_register, op, op_val, max_register_value) else {registers, max_register_value} end
			"==" -> if register_val == expected_val do apply_op(registers, op_register, op, op_val, max_register_value) else {registers, max_register_value} end
			"!=" -> if register_val != expected_val do apply_op(registers, op_register, op, op_val, max_register_value) else {registers, max_register_value} end
			_ -> {registers, max_register_value}

		end

	end

	def apply_op(registers, register, op, val, max_val) do
		{_, registers} = case op do
			"inc" -> Map.get_and_update(registers, register, fn x -> {x, (x || 0) + val} end)
			"dec" -> Map.get_and_update(registers, register, fn x -> {x, (x || 0) - val} end)
			_ -> {nil, registers}
		end
		{registers, max(registers |> Map.values |> Enum.max, max_val)}
	end

	def parse_input(filename) do
		filename
		|> File.read!
		|> String.trim
		|> String.split("\n")
		|> Enum.map(fn x -> String.split(x, " ") |> List.to_tuple end)
		|> Enum.map(fn {register1, op, val1, control, register2, predicate, val2} -> 
			{register1, op, String.to_integer(val1), control, register2, predicate, String.to_integer(val2)} end)
	end


end