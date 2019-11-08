# Add aliases to .bashrc

echo "
alias vl='vtex link --verbose' 
alias vr='vtex workspace reset --verbose'
alias install_dir='yarn global add file:\$PWD'
alias r='reset'
alias cdv='cd ~/Documents/vtex'
alias cdt='cd ~/Documents/tmp'
alias vtex-test='~/Documents/vtex/toolbelt/lib/cli.js --verbose'
alias yarn-local='node ~/Documents/yarn/lib/cli/index.js'
alias vtex='vtex --verbose'

function bhi() {
  CMD=\"vtex install vtex.builder-hub@\$1\" 
  echo \$CMD
  \$CMD
}

alias bhv='vtex deps ls | grep builder-hub'

export GOPATH=\$HOME/Documents/go-workspace
export PATH=\$PATH:\$GOPATH/bin
export PATH=\$PATH:\$HOME/.yarn/bin
" >> ~/.bashrc
