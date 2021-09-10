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

ALL_DEP:=
ifeq ($(DO_TOOLS),1)
ALL_DEP+=tools.stamp
endif # DO_TOOLS

#########
# rules #
#########
.PHONY: all
all: $(ALL)
	@true

tools.stamp: config/deps.py
	$(info doing [$@])
	$(Q)pymakehelper touch_mkdir $@

main.elf: main.cc $(ALL_DEP)
	$(info doing [$@])
	$(Q)g++ -I. $(EXTRA_COMPILE_CMDS) $< -o $@ $(EXTRA_LINK_CMDS)

.PHONY: debug
debug:
	$(info doing [$@])
	$(info EXTRA_COMPILE_CMDS is $(EXTRA_COMPILE_CMDS))
	$(info EXTRA_LINK_CMDS is $(EXTRA_LINK_CMDS))
	$(info ALL is $(ALL))
	$(info ALL_DEP is $(ALL_DEP))

.PHONY: clean
clean:
	$(info doing [$@])
	$(Q)-rm -f main.elf
