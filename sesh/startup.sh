

# If parent directory is projects, ie, /Users/name/projects/foo,  run nvim
if [[ $PWD == *projects/* ]]; then
  # If .git directory exits, run git pull
  if [ -d ".git" ]; then
    tmux new-window -d -n "lazygit" "lazygit"
  fi
  tmux new-window -d
  
  # rename current window to project name
  tmux rename-window "editor"
  nvim .
fi


