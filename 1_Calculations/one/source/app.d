import std.stdio, std.conv, std.string, std.algorithm, std.complex;

void main(string[] args)
{
	auto numArgs = args.length;
	if (numArgs > 1) {
		// First argument is name of program - we don't care about that
		handleInput(args[1], args[2..numArgs]);
	}
}

void handleInput(string operation, string[] arguments)
in {
	assert(
		operation == "sum" || operation == "product" || operation == "mean" || operation == "sqrt",
		"Operation must be one of sum, product, mean or sqrt."
	);
	assert(arguments.length > 0, "At least one number must be submitted");
	foreach(string value; arguments) {
		assert(isNumeric(value), value ~ " is not a valid number");
	}
}
body {
	double[] series = new double[arguments.length];
	for (int i = 0; i < arguments.length; i++) {
		series[i] = parse!double(arguments[i]);
	}

	if (operation == "sqrt") {
		writeln(map!(a => sqrt(complex(a)))(series));
	} else {
		writeln(applyOperation(operation, series));		
	}
}

double applyOperation(string operation, double[] series) {
	final switch (operation) {
		case "sum":
			return sum(series);
		case "product":
			return reduce!"a * b"(1.0, series);
		case "mean":
			return sum(series) / to!double(series.length);
	}
}

