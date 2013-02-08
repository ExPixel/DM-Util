proc/arctan(x) return (arcsin(x / (sqrt(x^2 + 1)))) // To match DM convention.

Math
	var/_PI = 3.141592653589793238462643383279502884
	proc
		arctan(x) return arctan(x) // For backwards compatibility.

var/Math/Math = new