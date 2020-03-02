module main

import anihex.vaser
// MainGame is the actual game. The player takes control over the captured Alex.
// His goal is to flee the prison in order to continue developing V.
struct MainGame {
pub mut:
	game  &vaser.Game
	level int
}

fn (scene &MainGame) create() {
	println('maingame.create')
}

fn (scene mut MainGame) input(key string) {
	println('maingame.input; key: ${key}')
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

fn (scene &MainGame) update() {
	println('maingame.update')
}

fn (scene &MainGame) render() {
	scene.game.draw_image('title', 0, 0)
}

fn (scene &MainGame) exit() {
	println('maingame.exit')
}

fn (scene &MainGame) keys() []vaser.KeyMap {
	return [{
		key: 65
		name: 'LEFT'
	},
	{
		key: 68
		name: 'RIGHT'
	},
	{
		key: 83
		name: 'DOWN'
	},
	{
		key: 87
		name: 'UP'
	},
	{
		key: 37
		name: 'LEFT'
	},
	{
		key: 39
		name: 'RIGHT'
	},
	{
		key: 40
		name: 'DOWN'
	},
	{
		key: 38
		name: 'UP'
	},
	]
}
