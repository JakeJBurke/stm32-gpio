TARGET = main
MCU = STM32F411xE

CC = arm-none-eabi-gcc
OBJCOPY = arm-none-eabi-objcopy

CFLAGS = -mcpu=cortex-m4 -mthumb -mfloat-abi=hard -mfpu=fpv4-sp-d16 \
         -O0 -g -Wall -nostdlib

LDFLAGS = -T linker.ld -nostdlib

SRCS = main.c startup.s
OBJS = main.o startup.o

all: $(TARGET).elf $(TARGET).bin

main.o: main.c
	$(CC) $(CFLAGS) -c -o main.o main.c

startup.o: startup.s
	$(CC) $(CFLAGS) -c -o startup.o startup.s

$(TARGET).elf: $(OBJS)
	$(CC) $(CFLAGS) $(LDFLAGS) -o $(TARGET).elf $(OBJS)

$(TARGET).bin: $(TARGET).elf
	$(OBJCOPY) -O binary $(TARGET).elf $(TARGET).bin

flash: $(TARGET).bin
	openocd -f interface/stlink.cfg -f target/stm32f4x.cfg \
	-c "program main.bin 0x08000000 verify reset exit"

clean:
	rm -f $(OBJS) $(TARGET).elf $(TARGET).bin