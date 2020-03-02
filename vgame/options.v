module main

import anihex.vaser
// Options stores the options of the game. Here the player can customize the
// game to his liking.
// Also, this menu enables the player to activate a 'hidden' cheat.
// By entering "alexmode" the player enters god-mode.
// By entering "glroxxs" the player-input will be reversed.
struct Options {
pub mut:
	game &vaser.Game
}

fn (scene &Options) create() {
	println('options.create')
}

fn (scene mut Options) input(key string) {
	println('options.input; key: ${key}')
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

fn (scene &Options) update() {
	println('options.update')
}

fn (scene &Options) render() {
	scene.game.draw_image('title', 0, 0)
}

fn (scene &Options) exit() {
	println('options.exit')
}

fn (scene &Options) keys() []vaser.KeyMap {
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
