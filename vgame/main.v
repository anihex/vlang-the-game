module main

import anihex.vaser

fn main() {
	mut game := vaser.new(640, 480, 'Vlang - The Game', true)

	game.add_scene('title', Title{game: game})
	game.add_scene('credits', Credits{game: game})
	game.add_scene('options', Options{game: game})
	game.add_scene('level_1', Level{game: game, level: 1})

	game.load_image('title', 'data/images/title/title.png')

	game.run()
}
