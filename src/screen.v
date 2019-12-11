module main

import sdl

/* --- CLEAR SCREEN --- */

[inline]
fn (game &Game) clearscreen(r byte, g byte, b byte) {
    SDL_SetRenderDrawColor(game.sdl.renderer, r, g, b, 255)
    SDL_RenderClear(game.sdl.renderer)
}

/* --- FILL A RECT --- */

fn (game &Game) fillrect(x f32, y f32, w f32, h f32, r byte, g byte, b byte, a byte) {
    mut _x := x
    mut _y := y
    mut _w := w 
    mut _h := h 

    if _w < 0 {
        _x += _w
        _w = -_w
    }

    if _h < 0 {
        _y += _h
        _h = -_h
    }

    rect := SDL_Rect{
        x: int(_x),
        y: int(_y),
        w: int(_w),
        h: int(_h),
    }

    SDL_SetRenderDrawBlendMode(game.sdl.renderer, C.SDL_BLENDMODE_BLEND)
    SDL_SetRenderDrawColor(game.sdl.renderer, r, g, b, a)
    SDL_RenderFillRect(game.sdl.renderer, &rect)
}

[inline]
fn (game &Game) flipscreen() {
    SDL_RenderPresent(game.sdl.renderer)
}

const (
   sdl_version = sdl.version
)