if status is-interactive
    # Commands to run in interactive sessions can go here
end

# homebre
set -gx HOMEBREW_PREFIX /opt/homebrew
set -gx HOMEBREW_CELLAR /opt/homebrew/Cellar
set -gx HOMEBREW_REPOSITORY /opt/homebrew
fish_add_path -gP /opt/homebrew/bin /opt/homebrew/sbin
if test -n "$MANPATH[1]"
    set -gx MANPATH '' $MANPATH
end
if not contains /opt/homebrew/share/info $INFOPATH
    set -gx INFOPATH /opt/homebrew/share/info $INFOPATH
end

# nvm
#load_nvm >/dev/stderr

# go
set --export GOPATH "$HOME/go"
fish_add_path $GOPATH


set WORKING_DIRS /Users/alejandro/.config /Users/alejandro/projects

set WEZTERM_CONFIG_FILE "/Users/alejandro/.config/wezterm/wezterm.lua"

#set FZF_DEFAULT_OPTS '--color=fg:-1,fg+:#D3C6AA,bg:-1,bg+:#262626
#  --color=hl:#83C092,hl+:#35A77C,info:#DBBC7F,marker:#8DA101
#  --color=prompt:#F85552,spinner:#DF69BA,pointer:#DF69BA,header:#A7C080
#  --color=border:#262626,label:#AEAEAE,query:#D9D9D9
#  --border="double" --border-label="" --preview-window="border-rounded" --prompt="> "
#  --marker=">" --pointer="◆" --separator="─" --scrollbar="│"'

# starship
set -gx STARSHIP_CONFIG "/Users/alejandro/.config/starship.toml"

starship init fish | source
