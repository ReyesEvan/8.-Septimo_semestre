// fun distance(x1: Double, y1: Double, x2: Double, y2: Double): Double {
fun distance(x: Pair<Double, Double>, y: Pair<Double, Double>): Double {
	println("x = ${x} | y = ${y}")
	val z1 = Math.pow(x.first - y.first, 2.0)
	println("z1 = ${z1}")
	val z2 = Math.pow(x.second - y.second, 2.0)
	println("z2 = ${z2}")
	
	println("sqrt = ${Math.sqrt(z1 + z2)}")
	return Math.sqrt(z1 + z2);
}

fun main() {
	val speed = listOf<Double>(2.5, 3.75, 2.25, 3.25, 2.75, 4.5, 3.5, 3.0, 4.0, 4.25, 2.0, 5.0, 8.25, 5.75, 4.75, 5.5, 5.25, 7.0, 7.5, 7.25)
	val agility = listOf<Double>(6.0, 8.0, 5.5, 8.25, 7.5, 5.0, 5.25, 3.25, 4.0, 3.75, 2.0, 2.5, 8.5, 8.75, 6.25, 6.75, 9.5, 4.25, 8.0, 5.75)

	val A = speed.zip(agility).take(13).map { Pair(it.first, it.second) }
	val B = speed.zip(agility).subList(13, speed.size - 1).map { Pair(it.first, it.second) }

	val k = 3
	val newPoint = Pair(6.75, 3.0)

	val neighbors: List<Pair<Pair<Double, Double>, Double>> = (A + B).map {
		Pair(it, distance(it, newPoint))
	}

	val knn = neighbors.sortedBy { it.second }.take(k).map { it.first }

	var a = 0
	var b = 0

	knn.forEach {
		if (A.contains(it))
			a++
		else if (B.contains(it))
			b++
	}

	println(knn)
	print("The point belongs to class ${if (a > b) "A" else "B"}")

	println(distance(newPoint, Pair(4.25, 3.75)))
	println(distance(newPoint, Pair(7.25, 5.75)))
}
