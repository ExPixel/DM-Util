Lists
	var
		Comparator/DefaultComparator/defaultComparator = new
		const/quicksort_method = "qs"
	proc
		islist(A)
			return A != null ? istype(A, /list) : false
		sort(list/arr, Comparator/comparator, method="qs", left=1, right=-1)
			if(arr == null) return
			if(comparator == null) comparator = defaultComparator
			if(right == -1) right = arr.len
			switch(method)
				if(quicksort_method)
					if(left < right)
						var/pv = round(left + (right-left)/2)
						var/pivotNewIndex = __qs_partition(arr, left, right, pv, comparator)
						sort(arr, comparator, quicksort_method, left, pivotNewIndex - 1)
						sort(arr, comparator, quicksort_method, pivotNewIndex + 1, right)
		toString(list/arr, var/sep=",")
			var/rtn = ""
			var/f = TRUE
			for(var/v in arr)
				if(!f) rtn += sep
				else f = FALSE
				rtn += num2text(v)
			return rtn

		/**
		Quicksort partition method.
		Uses the quick sort in-place version.
		http://en.wikipedia.org/wiki/Quicksort#In-place_version
		*/
		__qs_partition(list/arr, left, right, pivot, Comparator/comparator)
			var/pivot_value = arr[pivot]
			var/store_index = left
			array_swap(arr, pivot, right) // moves the pivot value to the end of the array.
			var/c = 0
			for(var/i = left; i <= right; i++)
				c = comparator.compare(arr[i], pivot_value)
				if(c < 0)
					array_swap(arr, i, store_index)
					store_index++
			array_swap(arr, store_index, right)
			return store_index

		/**
		Basically list[index], but used
		for debug purposes.
		*/
		__arr_get(list/arr, index)
			if(arr == null) CRASH("Array is null!")
			if(index < 1) CRASH("Index less than 1!")
			if(index > arr.len) CRASH("Index of [index] with array size of [arr.len]. Index too high!")
			return arr[index]

		__arr_oob(list/arr, index)
			if(arr == null) return TRUE
			if(index < 1) return TRUE
			if(index > arr.len) return TRUE
			return FALSE

		/**
		Changes the position of an element in a list.
		*/
		array_move(list/arr, oldindex, newindex)
			if(__arr_oob(arr, oldindex)) return
			var/v = arr[oldindex]
			arr.Cut(oldindex, oldindex+1)
			arr.Insert(newindex - 1, v)

		array_swap(list/arr, oldindex, newindex)
			if(__arr_oob(arr, oldindex)) return
			arr.Swap(oldindex, newindex)

		/**
		*/
		begin()


Comparator
	proc
		/**
		Compares its two arguments for order.
		Returns a negative integer, zero, or a positive integer as
		the first argument is less than, equal to,
		or greater than the second.
		*/
		compare(a, b) return 0


Comparator
	DefaultComparator
		compare(a, b)
			var/r = 0
			if(isnum(a) && isnum(b))
				if(a > b) r = 1
				else if(a < b) r = -1
			return r


var/Lists/Lists = new