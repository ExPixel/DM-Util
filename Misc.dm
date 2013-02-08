/*
Used to iterate through lists,
can be extended to iterate through anything.

To Extend:
	- Make setobject(o) assign o to the variable reffered to by this iterator.
	- Give get(loc) some functionality.
	- Define a min and max somehow.
	- Give functionality to setbounds()
	/Iterator/StringIterator can serve as an example.
*/
Iterator
	var
		position = 1
		min = -1
		max = -1
	New(o = null, newmin = null, newmax = null)
		..()
		if(o != null) setobject(o)
		if(newmin != null) min = newmin
		if(newmax != null) max = newmax
		setbounds()
	proc
		setobject(o)
		getMax() return src.max
		getMin() return src.min
		hasNext()
			return (position <= max)
		hasPrevious()
			return (position >= min)
		/**
			Shortened hasPrevious()
		*/
		hasPrev()
			return hasPrevious()
		get(var/loc)
		next()
			if(position < getMin()) position = getMin()
			.=get(position)
			if(position <= getMax()) position++
		prev()
			if(position > getMax()) position = getMax()
			.=get(position)
			if(position >= getMin()) position--
		setpos(p)
			position = p

		setbounds()


/**
Used to iterate through strings.
*/
Iterator/StringIterator
	var/string = ""
	setobject(o)
		string = o
	get(var/loc)
		return ascii2text(text2ascii(string, loc))	// This is said to be faster than copytext.
													// [Subject to change]
	setbounds()
		if(string != null && istext(string))
			min = 1
			max = length(string)

/**
Used to iterate through lists.
*/
Iterator/ListIterator
	var/list/_list
	setobject(o)
		if(Lists.islist(o)) _list = o
	get(var/loc)
		return loc != null ? _list[loc] : null
	setbounds()
		if(_list != null)
			max = _list.len
			min = 1