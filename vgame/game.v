module main

import anihex.vaser

struct Level{
pub mut:
	game &vaser.Game
	level int
}

fn (scene &Level) create() bool {
	println('level.create')
	return false
}

fn (scene &Level) input(key int, code int, action int, mods int) {
	println('level.input; key: ${key}, code: ${code}, action: ${action}, mods: ${mods}')
}

fn (scene &Level) update() {
	println('level.update')
}

fn (scene &Level) render() {
	scene.game.draw_image('title', 0, 0)
}

fn (scene &Level) exit() {
	println('level.exit')
}
