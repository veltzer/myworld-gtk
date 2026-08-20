#!/usr/bin/env python

""" Build the GTK demo, reproducing the Makefile:
g++ -I. $(pkg-config --cflags gtkmm-3.0 sigc++-2.0) main.cc -o main.elf
      $(pkg-config --libs gtkmm-3.0 sigc++-2.0).
File arguments are ignored; the single source and output are fixed. """

import subprocess
import sys

PACKAGES = ["gtkmm-3.0", "sigc++-2.0"]


def pkg_config(flag):
    """ Return the pkg-config flags for PACKAGES as a list. """
    out = subprocess.check_output(["pkg-config", flag] + PACKAGES, text=True)
    return out.split()


def main():
    """ main entry point """
    cmd = (["g++", "-I."] + pkg_config("--cflags")
           + ["main.cc", "-o", "main.elf"] + pkg_config("--libs"))
    sys.exit(subprocess.call(cmd))


if __name__ == "__main__":
    main()
