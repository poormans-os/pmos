CLANG := clang-9
AS := nasm
FUSE_LD := lld-link

.PHONY: all clean run
default: all

TARGET := ../bin/efi/boot/BOOTX64.EFI

SRCS += $(shell find src/ -name '*.c')
# ASM_SRCS += $(shell find src/ -name '*.asm')

OBJS := $(SRCS:%=build/%.o)
ASM_OBJS :=
# ASM_OBJS := $(ASM_SRCS:%=build/%.o)

INCLUDE_DIRS += include
INCLUDE_DIRS += edk2/MdePkg/Include
INCLUDE_DIRS += edk2/MdePkg/Include/X64
INCLUDE_DIRS += edk2/MdePkg/Include/Protocol
INCLUDE_DIRS += edk2/basetools/source/c/genfw

INCLUDE_DIRS += edk2/MdePkg/Include/Pi
INCLUDE_DIRS += edk2/MdePkg/Include/Library
INCLUDE_DIRS += edk2/MdeModulePkg/Include/Guid

ASFLAGS = -fwin64

CFLAGS := \
	-target x86_64-unknown-windows \
	-ffreestanding \
	-fshort-wchar \
	-nostdlib \
	-std=c11 \
	-Wall \
	-Werror \
	-fasm-blocks \
	-flto \
	-g

CFLAGS += $(INCLUDE_DIRS:%=-I%)

LDFLAGS := \
	-target x86_64-unknown-windows \
	-nostdlib \
	-Wl,-entry:EfiMain \
	-Wl,-subsystem:efi_application \
	-fuse-ld=$(FUSE_LD)

clean:
	@rm -rf build

all: $(TARGET)

$(TARGET): $(ASM_OBJS) $(OBJS)
	@mkdir -p $(@D)
	@$(CLANG) $(LDFLAGS) -o $@ $(OBJS) $(ASM_OBJS)

remake: clean all

build/%.c.o: %.c
	@mkdir -p $(@D)
	@echo "\033[35m[Compiling]\033[0m $@"
	@$(CLANG) $(CFLAGS) -c -o $@ $<

build/%.asm.o: %.asm
	@mkdir -p $(@D)
	@echo "\033[36m[Assembling]\033[0m $@"
	@$(AS) $(ASFLAGS) -o $@ $<
