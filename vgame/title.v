module main

import anihex.vaser

struct Title{
pub mut:
	game &vaser.Game
}

fn (scene &Title) create() {
	println('title.create')
}

fn (scene &Title) input(key int, code int, action int, mods int) {
	println('title.input; key: ${key}, code: ${code}, action: ${action}, mods: ${mods}')
}

fn (scene &Title) update() {
	println('title.update')
}

fn (scene &Title) render() {
	scene.game.draw_image('title', 0, 0)
}

fn (scene &Title) exit() {
	println('title.exit')
}
