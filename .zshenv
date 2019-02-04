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
export BASTADIR=${HOME}/BASTA
export PYTHONPATH=${PYTHONPATH}:${BASTADIR}
export PATH=${PATH}:${BASTADIR}

# StarPy
export PYTHONPATH=${PYTHONPATH}:${HOME}/starpy
export PATH=${PATH}:${HOME}/starpy/bin

# Adipls
export PATH=${PATH}:${HOME}/adipack/bin

# Garstec
export STARHOME=${HOME}/garstec
export PATH=${PATH}:${STARHOME}/BIN/common
export PATH=${PATH}:${STARHOME}/BIN/x86_64_darwin177

#------------------------------
# Pyenv
#------------------------------
if command -v pyenv 1>/dev/null 2>&1; then
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"
fi
