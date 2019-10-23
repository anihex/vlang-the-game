;; Vlang the game tilemap
;;
;; Tile definition:
;;   <> - required field
;;   [] - optional field(s)
;; (<tile id> <file-id> <xpos> <ypos> <type> [data])
;;
;; Tile types:
;; - 0: background
;; - 1: solid
;; - 2: bonus, data fields: <replacement block id>
;; - 3: box, data fields: <replacement block id>
(tilemap
    (file 0 "tiles.png")

    (tile 64 0 4 0 1)
    (tile 65 0 0 0 1)
    (tile 66 0 1 0 1)
    (tile 68 0 2 0 1)
    (tile 69 0 3 0 1)
    
    (tile 77 0 6 0 3 0) ; normal box
    (tile 78 0 7 0 3 0) ; mossy box
)