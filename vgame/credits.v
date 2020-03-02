module main

import anihex.vaser
// Credits shows a list of every contributor and the authors of the libs used for
// this game.
struct Credits {
pub mut:
	game &vaser.Game
}

fn (scene &Credits) create() {
	println('credits.create')
}

fn (scene mut Credits) input(key string) {
	println('credits.input; key: ${key}')
	if key == 'LEFT' {
		scene.game.set_scene('options', true, true)
	}
	else if key == 'RIGHT' {
		scene.game.set_scene('game', true, true)
	}
	else if key == 'UP' {
		scene.game.set_scene('credits', true, true)
	}
	else if key == 'DOWN' {
		scene.game.set_scene('title', true, true)
	}
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

fn (scene &Credits) keys() []vaser.KeyMap {
	return [{
		key: vaser.KEY_LEFT
		name: 'LEFT'
	},
	{
		key: vaser.KEY_RIGHT
		name: 'RIGHT'
	},
	{
		key: vaser.KEY_DOWN
		name: 'DOWN'
	},
	{
		key: vaser.KEY_UP
		name: 'UP'
	},
	{
		key: vaser.KEY_A
		name: 'LEFT'
	},
	{
		key: vaser.KEY_D
		name: 'RIGHT'
	},
	{
		key: vaser.KEY_S
		name: 'DOWN'
	},
	{
		key: vaser.KEY_W
		name: 'UP'
	},
	]
}
