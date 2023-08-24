require 'minitest/autorun'
require 'timeout'

class List
	TYPE_ORDER = {
		insertion_sort: 1,
		bubble_sort: 2,
		quick_sort: 3
	}

	def initialize(array_list, type_order)
		@array_list = array_list
		@type_order = type_order
	end

	#Return sorted list
	def execute
		case @type_order
		when TYPE_ORDER[:insertion_sort]
			sort_by_insertion_sort
		when TYPE_ORDER[:bubble_sort]
			sort_by_bubble_sort
		when TYPE_ORDER[:quick_sort]
			sort_by_quick_sort
		else
			raise "Invalid sorting algorithm specified"
		end
	end

	def sort_by_insertion_sort
		list_size = @array_list.length

		for i in 1..list_size-1
			number = @array_list[i]
			j = i - 1

			while j >= 0 && @array_list[j] > number
				@array_list[j + 1] = @array_list[j]
				j -= 1
			end

			@array_list[j + 1] = number
		end

		@array_list
	end

	def sort_by_bubble_sort
		list_size = @array_list.length

		for i in 0..list_size-1
			for j in 0..list_size-i-1
				if @array_list[j] && @array_list[j+1] && @array_list[j] > @array_list[j+1]
					@array_list[j], @array_list[j+1] = @array_list[j+1], @array_list[j]
				end
			end
		end

		@array_list
	end

	def sort_by_quick_sort
		quick_sort_recursive(@array_list, 0, @array_list.length - 1)
		@array_list
	end

	private

	def quick_sort_recursive(arr, low, high)
		if low < high
			pivot_index = partition(arr, low, high)

			quick_sort_recursive(arr, low, pivot_index - 1)
			quick_sort_recursive(arr, pivot_index + 1, high)
		end
	end

	def partition(arr, low, high)
		pivot = arr[high]
		i = low - 1

		for j in low..high-1
			if arr[j] < pivot
				i += 1
				arr[i], arr[j] = arr[j], arr[i]
			end
		end

		arr[i + 1], arr[high] = arr[high], arr[i + 1]
		return i + 1
	end
end

class ListTest < Minitest::Test
	def test_one
		list = List.new(
			[2,5,4,1,3],
			1
		)
		assert_equal [1,2,3,4,5], list.execute
	end

	def test_two
		list = List.new(
			[2,5,4,1,3],
			2
		)
		assert_equal [1,2,3,4,5], list.execute
	end

	def test_three
		list = List.new(
			[2,5,4,1,3],
			3
		)
		assert_equal [1,2,3,4,5], list.execute
	end

	def test_four
		list = List.new(
			[100.5, 1.2, 11.45, 50.55, 10],
			1
		)
		assert_equal [1.2,10, 11.45, 50.55, 100.5], list.execute
	end

	def test_five
		list = List.new(
			[100.5, 1.2, 11.45, 50.55, 10],
			2
		)
		assert_equal [1.2,10, 11.45, 50.55, 100.5], list.execute
	end

	def test_six
		list = List.new(
			[100.5, 1.2, 11.45, 50.55, 10],
			3
		)
		assert_equal [1.2,10, 11.45, 50.55, 100.5], list.execute
	end

	def test_seven
		list = List.new(
			[20, -20, -10, 10, 0],
			1
		)
		assert_equal [-20, -10, 0, 10, 20], list.execute
	end

	def test_eight
		list = List.new(
			[20, -20, -10, 10, 0],
			2
		)
		assert_equal [-20, -10, 0, 10, 20], list.execute
	end

	def test_nine
		list = List.new(
			[20, -20, -10, 10, 0],
			3
		)
		assert_equal [-20, -10, 0, 10, 20], list.execute
	end

	def test_ten
		list = List.new(
			[1111, 1000, 900, 500, 10, 1],
			1
		)
		assert_equal [1, 10, 500, 900, 1000, 1111], list.execute
	end

	def test_eleven
		list = List.new(
			[1111, 1000, 900, 500, 10, 1],
			2
		)
		assert_equal [1, 10, 500, 900, 1000, 1111], list.execute
	end

	def test_twelve
		list = List.new(
			[1111, 1000, 900, 500, 10, 1],
			3
		)
		assert_equal [1, 10, 500, 900, 1000, 1111], list.execute
	end

end
