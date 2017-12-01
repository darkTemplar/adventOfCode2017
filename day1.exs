defmodule SolveCaptcha do

	@doc """
	Solve given captcha by summing up digits that match 
	the next digit in the given number
	"""
	def solveCaptcha(captcha) do
		digits = Integer.digits(captcha)
		digits
		|> Enum.zip(tl(digits) ++ [hd(digits)])
		|> Enum.reduce([], fn({a,b}, acc) -> if a == b do [a|acc] else acc end end)
		|> Enum.sum
	end
end