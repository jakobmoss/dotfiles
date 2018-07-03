# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Path settings (moved from .zshrc) to please Spacemacs
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# Basic path
export PATH=/usr/local/bin:${PATH}
export PATH=${HOME}/bin:${PATH}

#------------------------------
# Research-stuff
#------------------------------
# BASTA
export PYTHONPATH=${PYTHONPATH}:${HOME}/BASTA
export PATH=${PATH}:${HOME}/BASTA

# StarPy
export PYTHONPATH=${PYTHONPATH}:${HOME}/starpy
export PATH=${PATH}:${HOME}/starpy/bin

# Adipls
export PATH=${PATH}:${HOME}/adipack/bin

# Garstec
export STARHOME=${HOME}/garstec
export PATH=${PATH}:${STARHOME}/BIN/common
export PATH=${PATH}:${STARHOME}/BIN/x86_64_darwin176
