module main

import sdl
#include <SDL_image.h>

const (
    NULL = 0
)

struct SdlMotionEvent {
pub:
    _type u32                          /**< SDL_KEYDOWN or SDL_KEYUP */
    timestamp u32
    windowid u32
    which u32
    state u32
    x int
    y int
    x_rel int
    y_rel int
}

[inline]
fn from_bytes(arr []byte) string {
    return tos(arr.data, arr.len)
}

[inline]
fn in_bounds(x, y, w, h, px, py int) bool {
    return px >= x && px <= (x + w) && py >= y && py <= (y + h)
}

fn (game mut Game) poll_quits() bool {
    ev := sdl.Event{}
    for 0 < sdl.poll_event(&ev) {
        match int(ev._type) {
            C.SDL_QUIT {
                game.quit = true
                return false
            }
            C.SDL_KEYDOWN {
                key := int(ev.key.keysym.sym)
                match key {
                    C.SDLK_ESCAPE {
                        return true
                    }
                    C.SDLK_RETURN {
                        return true
                    }
                    else {

                    }
                }
            }
            else {
                
            }
        }
    }
    return false
}

fn C.vp_get(array voidptr, offset int) byte
fn C.vp_put(array voidptr, offset int, val byte)
fn C.vp_malloc(size int) voidptr
fn C.vp_free(size voidptr)

fn C.SDL_GetMouseState(x, y &int) u32
fn C.SDL_SetRenderDrawBlendMode(renderer voidptr, flags int)
fn C.SDL_SetTextureBlendMode(tex voidptr, flags int)
fn C.SDL_ShowCursor(flags int) int
fn C.SDL_RenderFillRect(renderer voidptr, rect &SDL_Rect)
fn C.SDL_RenderCopyEx(renderer, tex , src, dest voidptr, x, y, flip int)

fn C.Mix_PlayingMusic() int

fn C.IMG_Load(path charptr) voidptr

fn C.fabs(num f64) f64
