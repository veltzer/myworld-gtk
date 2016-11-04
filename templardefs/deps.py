'''
dependencies for this project
'''

def populate(d):
    d.packs=[
        # for gtkmm that we use for the gui
        'libgtkmm-3.0-dev',
    ]

def getdeps():
    return [
        __file__, # myself
    ]
