##############
# parameters #
##############
# do you want to show the commands executed ?
DO_MKDBG:=0
# version of gtkmm used
GTKMM_VERSION:=3.0
# version of sigcpp used
SIGCPP_VERSION=2.0
# do tools?
DO_TOOLS:=1

###############
# definitions #
###############
EXTRA_COMPILE_CMDS:=$(shell pkg-config --cflags gtkmm-$(GTKMM_VERSION) sigc++-$(SIGCPP_VERSION))
EXTRA_LINK_CMDS:=$(shell pkg-config --libs gtkmm-$(GTKMM_VERSION) sigc++-$(SIGCPP_VERSION))
ALL:=main.elf
# silent stuff
ifeq ($(DO_MKDBG),1)
Q:=
# we are not silent in this branch
else # DO_MKDBG
Q:=@
#.SILENT:
endif # DO_MKDBG

ALL_DEPS:=
ifeq ($(DO_TOOLS),1)
ALL_DEPS+=tools.stamp
endif # DO_TOOLS

#########
# rules #
#########
.PHONY: all
all: $(ALL)
	$(info doing [$@])

tools.stamp:
	$(info doing [$@])
	$(Q)templar_cmd install_deps
	$(Q)make_helper touch-mkdir $@

main.elf: main.cc $(ALL_DEPS)
	$(info doing [$@])
	$(Q)g++ -I. $(EXTRA_COMPILE_CMDS) $< -o $@ $(EXTRA_LINK_CMDS)

.PHONY: debug
debug:
	$(info doing [$@])
	$(info EXTRA_COMPILE_CMDS is $(EXTRA_COMPILE_CMDS))
	$(info EXTRA_LINK_CMDS is $(EXTRA_LINK_CMDS))
	$(info ALL is $(ALL))
	$(info ALL_DEPS is $(ALL_DEPS))

.PHONY: clean
clean:
	$(info doing [$@])
	$(Q)-rm -f main.elf
