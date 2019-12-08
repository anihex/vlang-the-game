V ?= v

bin/vgame:
	rm -f ./bin/vgame
	mkdir -p ./bin
	$(V) -keep_c -verbose -vpath $(PWD)/src -prod -o ./src/vgame build ./src
	mv ./src/vgame ./bin/vgame
	strip -s ./bin/vgame
