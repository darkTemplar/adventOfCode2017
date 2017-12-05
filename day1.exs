defmodule SolveCaptcha do

	@doc """
	Solve given captcha by summing up digits that match 
	the next digit in the given number
	"""
	def solve_captcha1(captcha) do
		digits = Integer.digits(captcha)
		rotated_list = rotate_list(digits, 1)
		digits
		|> Enum.zip(rotated_list)
		|> Enum.reduce([], fn({a,b}, acc) -> if a == b do [a|acc] else acc end end)
		|> Enum.sum
	end

	@doc """
	Same as above though this time a digit is only included in sum if the digit at distance 
	length(captcha)/2 also matches it
	"""
	def solve_captcha2(captcha) do
		digits = Integer.digits(captcha)
		offset = div(length(digits), 2)
		rotated_list = rotate_list(digits, offset)
		digits
		|> Enum.zip(rotated_list)
		|> Enum.reduce([], fn({a,b}, acc) -> if a == b do [a|acc] else acc end end)
		|> Enum.sum
	end

	def rotate_list(lst, offset), do: Enum.drop(lst, offset) ++ Enum.take(lst, offset)

end