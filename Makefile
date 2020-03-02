V ?= v
BIN=vlang-the-game
SRC=vgame/*

ifeq ($(OS),Windows_NT)
	TARGET=windows
else
	TARGET=linux
endif

default: $(TARGET)

run: run-$(TARGET)

all: windows linux

clean:
	@-rm $(BIN)
	@-rm $(BIN).exe

clean-run: clean run
	@-

windows: $(BIN).exe

run-windows: $(BIN).exe
	@./$(BIN).exe

linux: $(BIN)

run-linux: $(BIN)
	@./$(BIN)

$(BIN): $(SRC)
	$(V) -keep_c -o $(BIN) -os linux ./vgame

$(BIN).exe: $(SRC)
	$(V) -prod -o $(BIN).exe -os windows ./vgame

download:
	$(V) install anihex.vaser

.PHONY: default all clean linux windows run-linux run-windows
