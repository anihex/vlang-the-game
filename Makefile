V ?= v

bin/vgame:
	sudo apt-get -y install libsdl2-dev libsdl2-image-dev libsdl2-mixer-dev libsdl2-ttf-dev
	rm -f ./bin/vgame
	mkdir -p ./bin
	$(V) -keep_c -verbose -vpath $(PWD)/src -prod -o ./bin/vgame ./src
	strip -s ./bin/vgame
