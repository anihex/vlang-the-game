V ?= v

bin/vgame:
	rm -f ./bin/vgame
	mkdir -p ./bin
	$(V) -keep_c -verbose -vpath $(PWD)/src -prod -o ./bin/vgame ./src
	strip -s ./bin/vgame
