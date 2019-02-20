if [[ -f "$HOME/.bashrc.local" ]]; then
  source "$HOME/.bashrc.local"
  return
fi

[[ -f "$HOME/.bashrc" ]] && source "$HOME/.bashrc"
