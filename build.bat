if not exist "bin" (
	mkdir bin
	copy sdl-win\lib\x64\*.dll bin\
)

del bin\vgame.exe
v.exe -prod -o src\vgame.exe -cc msvc build src
move src\vgame.exe bin\vgame.exe