# Add aliases to .bashrc

set -euo pipefail

echo "
alias install_dir='yarn global add file:\$PWD'
alias r='reset'
alias cdv='cd ~/Documents/vtex'
alias cdt='cd ~/Documents/tmp'

## Builder-Hub utilities
alias bhv='vtex deps ls | grep builder-hub'
function bhi() {
  CMD=\"vtex install vtex.builder-hub@\$1\" 
  echo \$CMD
  \$CMD
}
################

## vtex aliases
alias vtex='vtex --verbose'
alias vl='vtex link --verbose' 
alias vr='vtex workspace reset --verbose'
################


## PATH setup
export PATH=\$PATH:\$GOPATH/bin
export PATH=\$PATH:\$HOME/.yarn/bin
################

export GOPATH=\$HOME/Documents/go-workspace
" >> ~/.bashrc
