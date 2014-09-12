module haar;

import std.stdio;

unittest {
	import specd.specd;

	describe("A two-element array")
		.should("transform [1,1]", transform([1.0,1.0]).must == [1.0, 0.0])
		.should("transform [8,5]", transform([8.0,5.0]).must == [6.5, 1.5])
		;

	describe("A four-element array")
		.should("transform", transform([8, 5, 7, 3]).must == [5.75, 0.75, 1.5, 2.0])
		;

	describe("An eight-element array")
		.should("transform", transform([9, 7, 3, 5, 6, 10, 2, 6]).must == [6.0, 0.0, 2.0, 2.0, 1.0, -1.0, -2.0, -2.0])
		;
	
}

double[] transform(double[] input) {
	auto result = new double[input.length];

	innerTransform(input, result);

	return result;
}

void innerTransform(double[] input, double[] result) {
	size_t n = input.length/2;

	auto inputCopy = new double[n*2];
	inputCopy[0..$] = input[0..$];

	for (size_t i = 0; i < n; i++) {
		double i0 = inputCopy[i*2];
		double i1 = inputCopy[i*2+1];
		result[i] = (i0 + i1) / 2.0;
		result[i+n] = i0 - result[i];
	}

	if (n > 1) {
		innerTransform(result[0..n], result[0..n]);
	}
}

