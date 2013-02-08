proc
	toFrac( var/N )
		if(istext(N) || isnum(N))
			return new/Fraction(N)
		else
			return null

Fraction
	New(var/numer=0, var/deno=1)
		..()
		if(istext(numer))
			decode(numer)
		else if(isnum(numer) && isnum(deno))
			src.numerator = numer
			src.denominator = deno
	var
		numerator
		denominator
	proc
		decode(var/string)
			var/find = findtext(string, "/")
			if(find)
				var/n = copytext(string, 1, find)
				var/d = copytext(string, find+1)
				src.numerator = text2num(n)
				src.denominator = text2num(d)
		add(var/val)
			if(isnum(val) || istext(val))
				val = toFrac(val)
			if(val != null && istype(val, /Fraction))
				addFracUnit(val)
		multiply(var/val)
			if(isnum(val) || istext(val))
				val = toFrac(val)
			if(val != null && istype(val, /Fraction))
				multiplyFracUnit(val)
		divide(var/val)
			if(isnum(val) || istext(val))
				val = toFrac(val)
			if(val != null && istype(val, /Fraction))
				divideFracUnit(val)
		divideFracUnit(var/Fraction/unit)
			src.numerator *= unit.denominator
			src.denominator *= unit.numerator
		multiplyFracUnit(var/Fraction/unit)
			src.numerator *= unit.numerator
			src.denominator *= unit.denominator
		addFracUnit(var/Fraction/unit)
			src.numerator += matchDenominators( unit )
		matchDenominators( var/Fraction/unit )
			var/newDeno = src.denominator * unit.denominator
			src.numerator = newDeno / src.denominator
			src.denominator = newDeno
			return newDeno / unit.numerator
		canSimplify()
			var/min = min(numerator, denominator)
			for(var/i = 2; i <= min; i++)
				if( numerator % i == 0 && denominator % i == 0)
					return i
			return 0
		simplify(var/simp=0)
			if(simp == 0) simp = canSimplify()
			if(simp != 0)
				numerator /= simp
				denominator /= simp
				return 1
			else
				return 0
		fullSimplify()
			while(src.simplify())
				continue
		toString()
			return "[numerator]/[denominator]"
		getNum()
			return numerator / denominator