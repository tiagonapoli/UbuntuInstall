# Add aliases to .bashrc

read -p "Enter your GITHUB_API_TOKEN (https://help.github.com/en/articles/creating-a-personal-access-token-for-the-command-line): " gitToken

echo "
alias vl='vtex link --verbose' 
alias vr='vtex workspace reset --verbose'
alias install_dir='yarn global add file:$PWD'
alias r='reset'
alias cdv='cd ~/Documents/vtex'
alias cdt='cd ~/Documents/tmp'
alias vtex-test='~/Documents/vtex/toolbelt/lib/cli.js'
alias yarn-local='node ~/Documents/yarn/lib/cli/index.js'

export GOPATH=\$HOME/Documents/go-workspace
export PATH=\$PATH:\$GOPATH/bin
export PATH=\$PATH:\$HOME/.yarn/bin
export GITHUB_API_TOKEN=$gitToken
" >> ~/.bashrc
