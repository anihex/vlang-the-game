V ?= v
BIN=vlang-the-game

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

windows: $(BIN).exe

run-windows: $(BIN).exe
	@./$(BIN).exe

linux: $(BIN)

run-linux: $(BIN)
	@./$(BIN)

$(BIN): vgame/*
	$(V) -prod -o $(BIN) -os linux ./vgame

$(BIN).exe: vgame/*
	$(V) -prod -o $(BIN).exe -os windows ./vgame

.PHONY: default all clean linux windows run-linux run-windows
