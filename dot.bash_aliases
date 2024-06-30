# -*- mode: sh -*-
alias g='git'
alias gd='git diff'

function git() {
  if [[ $# -eq 0 ]]; then
    command git status
  else
    command git "$@"
  fi
}
