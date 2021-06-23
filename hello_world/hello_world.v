fn add(a int, b int) int {
	return a + b
}

fn iterate() {
	mut i := 0
	
	for _ in 0 .. 10 {
		print("$i ")
		i += 1
	}
	println("")
}

fn unused(){
	x := 5
}

fn string_test(){
	s := "Hello, World!"
	println(s)
	println(s.len)
	println(rune(s[0]))
	println(rune(s[s.len - 1]))
	
	println("42".int())
	println("String: $s")
	println("Length: $s.len")
	println("Bigger than 10? ${s.len > 10}")
}

fn num_test() {
	x := 42.2
	println(x)
	println("Number: $x")
	println("Number: " + x.str())
	println("Integer: ${int(x)}")
}

fn array_test(){
	mut arr := [1, 2, 3]
	println(arr)
	arr[0] = 5
	println(arr)
	println(arr.len)
	println(arr.cap)
	
	mut arr2 := []int{len: 5, cap: 10, init: 0}
	println(arr2)
	
	arr2 << 5
	println(arr2)
}

struct Point {
	x f32
	y f32
}

struct Line {
	p0 Point
	p1 Point
}

type Geo = Point | Line

fn struct_test() {
	point := Point{0, 1}
	line := Line{point, Point{3, 4}}
	
	mut objects := []Geo{}
	objects << point
	objects << line
	
	// println(objects)
	dump(objects) // Print to stderr
	
}

fn mutliarr_test() {
	mut arr := [][]int{len: 2, init: []int{len: 3, init: 0}}
	dump(arr)
	
	arr << [1,2] // Jagged arrays are allowed
	dump(arr)
	
	println([1, 2] in arr)
	
	arr[0][0] = 5
	dump(arr)
	
	println(arr.map(it.map(it + 1))) // it is scoped to its own map/filter
	
	arr.insert(0, [1,2,3])
	println(arr)
}

fn arr_operations_test(){
	mut arr := [1,5,3,2,5]
	dump(arr)
	
	println(arr.filter(it % 2 == 0)) // "it" refers to elements in array
	println(arr.map(it + 1)) // it is scoped to its own map/filter
	
	arr.sort()
	println(arr)
	arr.sort(a > b)
	println(arr)
	
	println(arr[1..3])
	
	mut fixed := [5]int{init: 5} // Fixed size array, more efficient
	println(fixed)
	println(fixed[0..fixed.len]) // Slicing converts to normal array
	
}

fn map_test() {
	// Dictionaries
	
	mut m := map[string]int{} // str -> int mapping
	
	m["hello"] = 0
	m["world"] = 1
	dump(m)
	
	m = map{
		"hello": 1,
		"world": 2
	}
	
	mut x := m["test"]
	println(x)
	x = m["test"] or {123} // or {} syntax to provide default
	println(x)
	// x := m["test"] or {panic("Key not found: test")} // panic raises error with stacktrace
	
}

fn type_test(){
	x := Geo(Point{1,2})
	if x is Point {
		println("point")
	}
}


fn main() {
	println("Hello World!")
	
	print_nums()
	
	println(add(1,2))
	
	x := 5
	y := 10
	println(add(x, y))
	
	iterate()
	
	unused()
	
	string_test()
	
	num_test()
	
	array_test()
	
	struct_test()
	
	mutliarr_test()
	
	arr_operations_test()
	
	map_test()
	
	type_test()
}