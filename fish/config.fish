if status is-interactive
    # Commands to run in interactive sessions can go here
end

# homebre
set -gx HOMEBREW_PREFIX "/opt/homebrew";
set -gx HOMEBREW_CELLAR "/opt/homebrew/Cellar";
set -gx HOMEBREW_REPOSITORY "/opt/homebrew";
fish_add_path -gP "/opt/homebrew/bin" "/opt/homebrew/sbin";
if test -n "$MANPATH[1]"; set -gx MANPATH '' $MANPATH; end;
if not contains "/opt/homebrew/share/info" $INFOPATH; set -gx INFOPATH "/opt/homebrew/share/info" $INFOPATH; end;

# nvm
load_nvm > /dev/stderr

# go
set --export GOPATH "$HOME/go"
fish_add_path $GOPATH

# starship
set -gx STARSHIP_CONFIG "/Users/alejandro/.config/starship.toml"
starship init fish | source

