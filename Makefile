V ?= v

bin/vgame:
	rm -f ./bin/vgame
	mkdir -p ./bin
	$(V) -prod -obf -o ./src/vgame build ./src
	mv ./src/vgame ./bin/vgame
	strip -s ./bin/vgame