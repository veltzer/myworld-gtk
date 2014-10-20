#!/usr/bin/python3

'''
this scrip will install all the required packages that you need on
ubuntu to compile and work with this package.
'''

import subprocess # for check_call

packs=[
	'libgtkmm-3.0-dev', # for gtkmm that we use for the gui
]

args=['sudo','apt-get','install','--assume-yes']
args.extend(packs)
subprocess.check_call(args)
