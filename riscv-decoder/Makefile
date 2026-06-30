CC = gcc
CFLAGS = -Wall -Wextra -std=c11 -g -Iinclude
LDFLAGS = 

SRC_DIR = src
OBJ_DIR = build
BIN_DIR = bin
TEST_DIR = test

SRC = $(wildcard $(SRC_DIR)/*.c)
OBJ = $(SRC:$(SRC_DIR)/%.c=$(OBJ_DIR)/%.o)
TARGET = $(BIN_DIR)/riscv-decoder

.PHONY: all clean test debug release help

all: dirs $(TARGET)

dirs:
	@mkdir -p $(OBJ_DIR) $(BIN_DIR)

$(TARGET): $(OBJ)
	$(CC) $(LDFLAGS) -o $@ $^
	@echo "Build complete: $@"

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c
	$(CC) $(CFLAGS) -c $< -o $@

# Automatic dependency generation
$(OBJ_DIR)/%.d: $(SRC_DIR)/%.c | dirs
	$(CC) $(CFLAGS) -MM -MT $(OBJ_DIR)/$*.o $< > $@

-include $(OBJ:.o=.d)

debug: CFLAGS += -DDEBUG -O0
debug: all

release: CFLAGS += -O2 -DNDEBUG
release: all

test: all
	./$(TARGET) test/test_programs/add.hex

valgrind: all
	valgrind --leak-check=full ./$(TARGET) test/test_programs/add.hex

clean:
	rm -rf $(OBJ_DIR) $(BIN_DIR)

help:
	@echo "Targets: all, debug, release, test, valgrind, clean, help"