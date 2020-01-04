module main

import sdl

struct TitleState {
pub mut:
    initialized bool
    had_intro bool

    angle int
    timer u32
    menu_background &TextureType
    default_subset &TextureType
    valex_head &TextureType
    menu &Menu
}

fn (game &Game) title_init() {
    mut title := &game.title_state
    title.initialized = true
    
    title.menu_background = game.load_texture('images/title/title.png')
    title.default_subset = game.load_texture('images/title/default-subset.png')
    title.valex_head = game.load_texture('images/valex.png')
    title.menu = game.new_menu()
    title.menu.add_action('New Game')
    title.menu.add_action('Options')
    title.menu.add_action('Credits')
    title.menu.add_action('Quit')
}

fn (game &Game) title_bg() {
    mut title := &game.title_state

    title.angle = (title.angle + int(title.timer - C.get_ticks())) % 3600
    title.timer = C.get_ticks()

    game.clearscreen(0, 0, 0)
    game.texture_draw_bg(title.menu_background)
    game.texture_draw_rotated(title.valex_head, int(f32(game.sdl.screen_width) * 0.8), 120, title.angle / 10)
}

fn (game mut Game) title_load_failed(_error string) bool {
    mut done := false
    mut frame := 0
    mut alpha := 0
    ef_x := 500
    mut ef_y := game.sdl.screen_height

    for {
        if done || game.quit {
            break
        }


        ev := SDL_Event{}
        for 0 < sdl.poll_event(&ev) {
            match u32(ev.@type) {
                u32(C.SDL_QUIT) {
                    game.quit = true
                    break
                }
                u32(C.SDL_KEYDOWN) {
                    key := int(ev.key.keysym.sym)
                    if key == C.SDLK_ESCAPE || key == C.SDLK_RETURN {
                        done = true
                    }
                }
                else {}
            }
        }

        game.title_bg()

        game.fillrect((game.sdl.screen_width - ef_x) / 2, (game.sdl.screen_height - ef_y) / 2, ef_x, ef_y, 0, 0, 0, 100)
        if alpha == 255 {
            game.font_red.draw_align('Failed to load level', game.sdl.screen_width / 2, game.sdl.screen_height / 2 - 20, ALIGN_CENTER | ALIGN_MIDDLE, 255)
            game.font_white.draw_align(_error, game.sdl.screen_width / 2, game.sdl.screen_height / 2 + 20, ALIGN_CENTER | ALIGN_MIDDLE, 255)
        }

        if ef_y > 150 { ef_y-- }
        if alpha < 255 { alpha++ }

        C.SDL_Delay(1)
        game.draw_cursor()
        game.flipscreen()
        frame++
    }
    
    return done
}

fn (game mut Game) prepare_game(subset &LevelSubset) bool {
    level := subset.load_level('level1.lisp') or {
        println(err)
        return game.title_load_failed(err)
    }

    println('enter game from level $level.name')
    
    game.level = 1
    game.lives = 3
    game.score = 0
    game.current_level = &level
    game.current_subset = subset
    game.physics.set_gravity(10)
    
    return game.game_loop()
}

fn (game mut Game) title_level_select() bool {
    title := &game.title_state
    mut done := false
    mut current := 0
    mut frame := 0
    mut alpha := f64(0)
    mut ef_x := f64(title.menu.width())
    mut ef_y := f64(title.menu.height())

    game.delta()

    for !(done || game.quit) {
        ev := SDL_Event{}
        for 0 < sdl.poll_event(&ev) {
            match u32(ev.@type) {
                u32(C.SDL_QUIT) {
                    game.quit = true
                    break
                }
                u32(C.SDL_KEYDOWN) {
                    key := int(ev.key.keysym.sym)
                    match key {
                        C.SDLK_ESCAPE {
                            done = true
                        }
                        C.SDLK_LEFT {
                            if current > 0 {
                                current--
                            }
                        }
                        C.SDLK_RIGHT {
                            if current < game.level_subsets.len {
                                current++
                            }
                        }
                        C.SDLK_RETURN {
                            if current != game.level_subsets.len {
                                subset := &game.level_subsets[current]
                                return game.prepare_game(subset)
                            }
                        }
                        else {}
                    }
                }
                u32(C.SDL_MOUSEBUTTONDOWN) {
                    game.menu_sdl_event_mouse(&SdlMotionEvent(&ev))
                }
                u32(C.SDL_MOUSEMOTION) {
                    game.menu_sdl_event_mouse(&SdlMotionEvent(&ev))
                }
                else {}
            }
        }

        game.title_bg()
        game.fillrect((game.sdl.screen_width - int(ef_x)) / 2, (game.sdl.screen_height - int(ef_y)) / 2, int(ef_x), int(ef_y), 0, 0, 0, 100)
        if alpha >= 255 {
            if current == game.level_subsets.len {
                game.font_red.draw_align('Chapter ? - ???', game.sdl.screen_width / 2, game.sdl.screen_height / 2 - 200, ALIGN_CENTER | ALIGN_TOP, 255)
                game.font_white.draw_align('Coming soon!', game.sdl.screen_width / 2, game.sdl.screen_height / 2, ALIGN_CENTER | ALIGN_MIDDLE, 255)
            } else {
                subset := &game.level_subsets[ current ]
                game.font_red.draw_align(subset.name, game.sdl.screen_width / 2, game.sdl.screen_height / 2 - 200, ALIGN_CENTER | ALIGN_TOP, 255)
                game.font_white.draw_align(subset.description, game.sdl.screen_width / 2, game.sdl.screen_height / 2 + 100, ALIGN_CENTER | ALIGN_BOTTOM, 255)
                
                if subset.has_image {
                    game.texture_draw(subset.subset_image, (game.sdl.screen_width - subset.subset_image.w) / 2, (game.sdl.screen_height - subset.subset_image.h) / 2 - 50)
                } else {
                    game.texture_draw(title.default_subset, (game.sdl.screen_width - title.default_subset.w) / 2, (game.sdl.screen_height - subset.subset_image.h) / 2 - 50)
                }
            }
        }

        delta := game.delta() * 500

        if ef_x < 500 { ef_x += delta }
        if ef_y < game.sdl.screen_height { ef_y += delta }
        if alpha < 255 { alpha += delta }

        game.draw_cursor()
        game.flipscreen()
        frame++
    }

    return done
}

fn (game mut Game) title() bool {
    if !game.title_state.initialized {
        game.title_init()
    }

    mut done := false
    mut frame := 0
    mut title := &game.title_state
    title.timer = C.get_ticks()
    
    if game.get_current_music() != .menu_music {
        game.set_current_music(.menu_music)
        game.play_current_music()
    }

    game.current_subset = NULL
    game.current_level = NULL
    //game.clearscreen(0, 0, 0)
    //game.flipscreen()
    game.menu_set_current(title.menu)

    ev := SDL_Event{}
    for 0 < sdl.poll_event(&ev) {
        if u32(ev.@type) == u32(C.SDL_QUIT) {
            game.quit = true
        }
    }

    for {
        if done || game.quit {
            break
        }

        for 0 < sdl.poll_event(&ev) {
            if u32(ev.@type) == u32(C.SDL_QUIT) {
                game.quit = true
            } else if title.had_intro {
                game.menu_sdl_event(ev)
            }
        }

        game.title_bg()

        if title.had_intro && game.show_menu {
            game.menu_process_current()
        }

        if game.current_menu == title.menu {
            match title.menu.check() {
                0 {
                    done = game.title_level_select()
                }
                1 {
                    done = true
                }
                3 {
                    game.quit = true
                }
                else {}
            }
        }

        if !title.had_intro && frame < 255 {
            game.fillrect(0, 0, game.sdl.screen_width, game.sdl.screen_height, 0, 0, 0, 255 - frame)
            C.SDL_Delay(10)
        } else {
            game.show_menu = true
            title.had_intro = true
        }

        C.SDL_Delay(1)
        game.draw_cursor()
        game.flipscreen()
        frame++
    }

    return game.quit
}