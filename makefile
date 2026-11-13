AS    := gcc
FLAGS := -nostdlib -fno-builtin

SRC    := src
BUILD  := build

SRCS   := $(wildcard $(SRC)/*.s)
OBJS   := $(patsubst %.s,$(BUILD)/%.o,$(SRCS))
TARGET := $(BUILD)/echo-args

$(BUILD)/$(SRC)/.%.s: $(SRC)/%.s
	@mkdir -p $(dir $@)
	@echo PC $@
	@sed "s/;/#/g" $< > $@

%.o: .%.s 
	@mkdir -p $(dir $@)
	@echo AS $@
	@$(AS) $(FLAGS) -c $< -o $@

build: $(OBJS)
	@echo AS $(TARGET)
	@$(AS) $(FLAGS) $(OBJS) -o $(TARGET)

run: build
	@$(TARGET) $(ARGS)

clean:
	@rm -r $(BUILD)
	@echo clean builds
