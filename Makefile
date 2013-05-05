ALL:=main.elf
EXTRA_COMPILE_CMDS:=$(shell pkg-config --cflags gtkmm-2.4 sigc++-2.0 libgnomeui-2.0)
EXTRA_LINK_CMDS:=$(shell pkg-config --libs gtkmm-2.4 sigc++-2.0 libgnomeui-2.0)

.PHONY: all
all: $(ALL)

main.elf: main.cc
	g++ -I. $(EXTRA_COMPILE_CMDS) $< -o $@ $(EXTRA_LINK_CMDS)

.PHONY: debug
debug:
	$(info EXTRA_COMPILE_CMDS is $(EXTRA_COMPILE_CMDS))
	$(info EXTRA_LINK_CMDS is $(EXTRA_LINK_CMDS))

.PHONY: clean
clean:
	rm -f main.elf
