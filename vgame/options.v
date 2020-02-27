module main

import anihex.vaser

struct Options{
pub mut:
	game &vaser.Game
}

fn (scene &Options) create() bool {
	println('options.create')
	return false
}

fn (scene &Options) input(key int, code int, action int, mods int) {
	println('options.input; key: ${key}, code: ${code}, action: ${action}, mods: ${mods}')
}

fn (scene &Options) update() {
	println('options.update')
}

fn (scene &Options) render() {
	scene.game.draw_image('title', 0, 0)
}

fn (scene &Options) exit() {
	println('options.exit')
}
