#set -x GOPATH $HOME/go
#set -x GOROOT /usr/local/opt/go/libexec
set PATH $GOROOT/bin $PATH
#set PATH $GOPATH/bin $GOROOT/bin $PATH
#set PATH $HOME/.cargo/env $PATH
status --is-interactive; and rbenv init - fish | source
starship init fish | source


# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH
