module main

import anihex.vaser

struct Credits{
pub mut:
	game &vaser.Game
}

fn (scene &Credits) create() bool {
	println('credits.create')
	return false
}

fn (scene &Credits) input(key int, code int, action int, mods int) {
	println('credits.input; key: ${key}, code: ${code}, action: ${action}, mods: ${mods}')
}

fn (scene &Credits) update() {
	println('credits.update')
}

fn (scene &Credits) render() {
	scene.game.draw_image('title', 0, 0)
}

fn (scene &Credits) exit() {
	println('credits.exit')
}
