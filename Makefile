ALL:=main.elf
#GTKMM_VERSION:=2.4
GTKMM_VERSION:=3.0
EXTRA_COMPILE_CMDS:=$(shell pkg-config --cflags gtkmm-$(GTKMM_VERSION) sigc++-2.0 libgnomeuimm-2.6)
EXTRA_LINK_CMDS:=$(shell pkg-config --libs gtkmm-$(GTKMM_VERSION) sigc++-2.0 libgnomeuimm-2.6)
#EXTRA_COMPILE_CMDS:=$(shell pkg-config --cflags libgnomeuimm-2.6)
#EXTRA_LINK_CMDS:=$(shell pkg-config --libs libgnomeuimm-2.6)

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
