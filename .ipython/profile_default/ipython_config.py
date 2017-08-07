# Configuration file for ipython.

#------------------------------------------------------------------------------
# InteractiveShellApp(Configurable) configuration
#------------------------------------------------------------------------------

# Get root object
c = get_config()

## lines of code to run at IPython startup.
c.InteractiveShellApp.exec_lines = [
    'import numpy as np',
    'import matplotlib.pyplot as plt'
]

## Enable GUI event loop integration with any of ('glut', 'gtk', 'gtk2', 'gtk3',
#  'osx', 'pyglet', 'qt', 'qt4', 'qt5', 'tk', 'wx', 'gtk2', 'qt4').
c.InteractiveShellApp.gui = 'qt5'

## Configure matplotlib for interactive use with the default matplotlib backend.
c.InteractiveShellApp.matplotlib = 'qt5'

## If true, IPython will populate the user namespace with numpy, pylab, etc. and
#  an ``import *`` is done from numpy and pylab, when using pylab mode.
#
#  When False, pylab mode should not import any names into the user namespace.
c.InteractiveShellApp.pylab_import_all = False


#------------------------------------------------------------------------------
# TerminalIPythonApp(BaseIPythonApplication,InteractiveShellApp) configuration
#------------------------------------------------------------------------------

## Whether to display a banner upon starting IPython.
c.TerminalIPythonApp.display_banner = False
