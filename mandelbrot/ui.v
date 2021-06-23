// import os
import stbi
import gg
import gx
import sokol.sgl

const (
	win_width  = 256 // Breaks when W * H > 256^2
	win_height = 256
)

struct App {
mut:
	gg   &gg.Context
	grid Grid
}

fn main() {
	print("test")

	mut app := &App{
		gg: 0
	}
	app.gg = gg.new_context(
		bg_color: gx.black
		width: win_width
		height: win_height
		use_ortho: true
		// This is needed for 2D drawing
		create_window: true
		window_title: 'Mandelbrot Set'
		frame_fn: frame
		user_data: app
	)

	app.grid.init(-0.5, 0, win_width, win_height, 2, 2)
	app.grid.iterate(1000)

	buff := unsafe {malloc(3)}
	println(buff)


	x := stbi.load_from_memory(buff, 3) or {stbi.Image{}}
	println(x)

	// app.gg.run()
}

fn frame(app &App) {
	app.gg.begin()
	app.draw()
	app.gg.end()
}

fn get_rect_bounds(i int, j int, num_x int, num_y int) (int, int, int, int) {
	x0 := i * win_width / num_x
	x1 := (i + 1) * win_width / num_x
	y0 := j * win_height / num_y
	y1 := (j + 1) * win_height / num_y

	return int(x0), int(x1), int(y0), int(y1)
}

fn set_pixel(ctx gg.Context, x f32, y f32, c gx.Color) {
	sgl.c4b(c.r, c.g, c.b, c.a)
	sgl.begin_points()
	sgl.v2f(x * ctx.scale, y * ctx.scale)
	sgl.end()
}

fn set_pixels(ctx gg.Context, c gx.Color, points []Coord) {
	sgl.c4b(c.r, c.g, c.b, c.a)
	sgl.begin_points()
	for p in points {
		sgl.v2f(p.x * ctx.scale, p.y * ctx.scale)
	}
	sgl.end()
}

struct Coord {
	x int
	y int
}

fn (app &App) draw() {

	
	println("test")
	x := 5

	// mut point := app.grid.points[0][0]

	// sgl.begin_points()
	// for i in 0..256 {
	// 	sgl.c3b(i, i, i)

	// 	for y in 0..app.grid.points.len {
	// 		for x in 0..app.grid.points[y].len {
	// 			point = app.grid.points[y][x]
	// 			if point.i % 255 == i {
	// 				sgl.v2f(y * app.gg.scale, x * app.gg.scale)
	// 			}
	// 		}
	// 	}

	// }

	// sgl.end()


}
