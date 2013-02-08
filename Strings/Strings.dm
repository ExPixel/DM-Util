Strings
	proc
		/**
		Returns an iterator that starts at the beginning of the string.
		*/
		begin(string)
			var/Iterator/StringIterator/si = new(string)
			si.setpos(si.getMin()) // Making sure.
			return si

		/**
		Returns an iterator that starts at the end of the string.
		*/
		end(string)
			var/Iterator/StringIterator/si = new(string)
			si.setpos(si.getMax())
			return si

		/**
		Returns the reverse of a string.
		*/
		reverse(string)
			var/Iterator/StringIterator/si = src.end(string)
			var/s = ""
			while(si.hasPrev())
				s += si.prev()
			return s

		/**
		Returns a list of charaters representing the string.
		*/
		toArray(string)
			var/Iterator/i = src.begin(string)
			var/list/chars = list()
			while(i.hasNext())
				chars.Add(i.next())
			return chars

var/Strings/Strings = new

mob
	verb
		test()
			var/S = input(src, "STRING!") as text
			world << S
			S = Strings.reverse(S)
			world << S
			S = Strings.reverse(S)
			world << S
			world << "-----------------------"