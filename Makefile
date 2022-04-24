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
# do you want dependency on the Makefile itself ?
DO_ALLDEP:=1

###############
# definitions #
###############
ALL:=
TOOLS=tools.stamp
EXTRA_COMPILE_CMDS:=$(shell pkg-config --cflags gtkmm-$(GTKMM_VERSION) sigc++-$(SIGCPP_VERSION))
EXTRA_LINK_CMDS:=$(shell pkg-config --libs gtkmm-$(GTKMM_VERSION) sigc++-$(SIGCPP_VERSION))
# silent stuff
ifeq ($(DO_MKDBG),1)
Q:=
# we are not silent in this branch
else # DO_MKDBG
Q:=@
#.SILENT:
endif # DO_MKDBG

# dependency on the makefile itself
ifeq ($(DO_ALLDEP),1)
.EXTRA_PREREQS+=$(foreach mk, ${MAKEFILE_LIST},$(abspath ${mk}))
endif

ifeq ($(DO_TOOLS),1)
.EXTRA_PREREQS+=$(TOOLS)
ALL+=$(TOOLS)
endif # DO_TOOLS

ALL+=main.elf

#########
# rules #
#########
.PHONY: all
all: $(ALL)
	@true

$(TOOLS): config/deps.py packages.txt
	$(info doing [$@])
	$(Q)xargs -a packages.txt sudo apt-get install
	$(Q)pymakehelper touch_mkdir $@

main.elf: main.cc
	$(info doing [$@])
	$(Q)g++ -I. $(shell pkg-config --cflags gtkmm-$(GTKMM_VERSION) sigc++-$(SIGCPP_VERSION)) $< -o $@ $(shell pkg-config --libs gtkmm-$(GTKMM_VERSION) sigc++-$(SIGCPP_VERSION)) 
# to find all included header files...
# $(Q)g++ -H -I. $(EXTRA_COMPILE_CMDS) $< -o $@ $(EXTRA_LINK_CMDS)

.PHONY: debug
debug:
	$(info doing [$@])
	$(info EXTRA_COMPILE_CMDS is $(EXTRA_COMPILE_CMDS))
	$(info EXTRA_LINK_CMDS is $(EXTRA_LINK_CMDS))
	$(info ALL is $(ALL))

.PHONY: clean
clean:
	$(info doing [$@])
	$(Q)-rm -f main.elf

.PHONY: clean_hard
clean_hard:
	$(info doing [$@])
	$(Q)git clean -qffxd
