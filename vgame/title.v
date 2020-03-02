module main

import anihex.vaser
// Title is the title-screen. It shows the title-background and the options the
// player can pick. Depending on what the player selects, the game switches to
// a different scene.
struct Title {
pub mut:
	game &vaser.Game
}

fn (scene &Title) create() {
	println('title.create')
}

fn (scene &Title) input(key string) {
	println('credits.input; key: ${key}')
	// if key == 'LEFT' {
	// 	scene.game.set_scene('options', true, true)
	// }
	// else if key == 'RIGHT' {
	// 	scene.game.set_scene('game', true, true)
	// }
	// else if key == 'UP' {
	// 	scene.game.set_scene('credits', true, true)
	// }
	// else if key == 'DOWN' {
	// 	scene.game.set_scene('title', true, true)
	// }
}

fn (scene &Title) update() {
	println('title.update')
}

fn (scene &Title) render() {
	scene.game.draw_image('title', 10, 0)
}

fn (scene &Title) exit() {
	println('title.exit')
}

fn (scene &Title) keys() []vaser.KeyMap {
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
	}]
}
