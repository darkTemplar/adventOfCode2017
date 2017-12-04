defmodule SpiralMemory do
	
	def num_steps(value) do
		# figure out grid size by seeing sqauare of which number is value closest to
		n = :math.sqrt(value) |> Float.ceil |> trunc
		# now to figure out which cycle is value part of (outermost cycle will be tagged as 0)
		# cycles in square spiral matrices run from n*n to (n-2)*(n-2)+1 value
		marker = find_cycle_number(value, n, 0)

		# now find sum of centroid coordinates i.e. co-ordinates of value 1 (0 indexed)
		centroid_sum = find_sum_of_centroid_coordinates(n)

		# TODO:find if value lies in upper triangle or lower triangle (square matrix can be thought of as a combination of two triangles)
		upper_half_sum = :math.pow(n - 2*marker, 2) + (2 * marker) - value
		lower_half_sum = -(:math.pow(n - 2*marker - 2, 2) - (2 * marker) - value)

		# HACK: till we resolve how to find which half value lies in, we print both possible manhattan distances
		manhattan_distance1 = abs(centroid_sum - upper_half_sum)
		IO.inspect "Distance 1 #{manhattan_distance1}"
		manhattan_distance2 = abs(centroid_sum - lower_half_sum)
		IO.inspect "Distance 2 #{manhattan_distance2}"



	end

	def find_cycle_number(value, n, marker) when value < (n-2)*(n-2) + 1, do: find_cycle_number(value, n-2, marker + 1)
	def find_cycle_number(value, n, marker), do: marker

	def find_sum_of_centroid_coordinates(n) when rem(n, 2) == 0, do: n - 1
	def find_sum_of_centroid_coordinates(n), do: 2*Float.ceil(n/2) - 2

	#def find_corners(n, marker), do: {:math.pow(n - 2*marker, 2), }

end