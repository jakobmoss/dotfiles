# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Path settings (moved from .zshrc) to please Spacemacs
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# Homebrew and basic path
export PATH=/usr/local/sbin:/usr/local/bin:${PATH}
export PATH=${HOME}/bin:${PATH}

#------------------------------
# Research-stuff
#------------------------------
# Validation of BASTA
export PYTHONPATH=${PYTHONPATH}:${HOME}/validation
export PATH=${PATH}:${HOME}/validation/bin

# BASTA
export BASTADIR=${HOME}/BASTA
export PYTHONPATH=${PYTHONPATH}:${BASTADIR}
export PATH=${PATH}:${BASTADIR}/bin

# StarPy
export PYTHONPATH=${PYTHONPATH}:${HOME}/starpy
export PATH=${PATH}:${HOME}/starpy/bin

# Adipls
export PATH=${PATH}:${HOME}/adipack/bin

# Garstec
export STARHOME=${HOME}/garstec
export PATH=${PATH}:${STARHOME}/BIN/common
export PATH=${PATH}:${STARHOME}/BIN/x86_64_darwin205

#------------------------------
# Pyenv
#------------------------------
# export PYENV_ROOT="$HOME/.pyenv"
# export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv 1>/dev/null 2>&1; then
    eval "$(pyenv init --path)"
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"
fi
