if status is-interactive
  # Commands to run in interactive sessions can go here
end
set -x LC_ALL en_US.UTF-8
set -x LC_CTYPE en_US.UTF-8
set -x LANG en_US.UTF-8
load_nvm > /dev/stderr
starship init fish | source


# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH

# go
set --export GOPATH "$HOME/go"
set --export PATH $GOPATH/bin $PATH

