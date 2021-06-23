struct Complex {
	r f64
	i f64
}

fn (a Complex) * (b Complex) Complex {
	return Complex{a.r * b.r - a.i * b.i, a.r * b.i + b.r * a.i}
}

fn (a Complex) + (b Complex) Complex {
	return Complex{a.r + b.r, a.i + b.i}
}

fn (c Complex) mag2() f64 {
	return c.r * c.r + c.i * c.i
}

fn (c Complex) str() string {
	return '($c.r + ${c.i}i)'
}

struct Point {
	pos Complex [required]
mut:
	val      Complex
	i        int
	complete bool
}

fn (mut p Point) iterate(n int) {
	for _ in 0 .. n {
		p.val = p.val * p.val + p.pos
		p.i++

		if p.val.r * p.val.r + p.val.i * p.val.i >= 4 {
			p.complete = true
			return
		}
	}
}

struct Grid {
mut:
	points [][]Point
}

fn (mut g Grid) iterate(n int) {
	for mut row in g.points {
		for mut p in row {
			if !p.complete {
				p.iterate(n)
			}
		}
	}
}

fn (g Grid) get_iters() [][]int {
	return g.points.map(it.map(it.i))
}

fn (g Grid) get_points() [][]Complex {
	return g.points.map(it.map(it.pos))
}

fn (mut g Grid) init(centre_x f64, centre_y f64, num_x int, num_y int, width f64, height f64) {
	g.points = [][]Point{cap: num_x}
	for x in 0 .. num_x {
		mut row := []Point{cap: num_y}
		for y in 0 .. num_y {
			r := (f64(x) / (num_x - 1) - 0.5) * width + centre_x
			i := (f64(y) / (num_y - 1) - 0.5) * height + centre_y
			row << Point{
				pos: Complex{r, i}
			}
		}
		g.points << row
	}
}

fn test_bare() {
	c := Complex{0.123, 0.321}
	mut z := Complex{}
	for _ in 0 .. 1000000 {
		z = z * z + c
	}
}

fn test_point() {
	mut p := Point{
		pos: Complex{0.123, 0.321}
	}
	p.iterate(1000000)
}

fn test_grid() {
	mut g := Grid{}
	g.points << [Point{
		pos: Complex{0.123, 0.321}
	}]

	g.iterate(1000000)
}

fn test_grid2() {
	mut g := Grid{}

	// Init points
	g.init(0, 0, 10, 10, 2, 2)
	print(g.get_points())
	g.iterate(10000)
}

// fn main(){
// test_bare()
// test_point()
// test_grid()
// test_grid2()
// }
