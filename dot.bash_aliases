# -*- mode: sh -*-
alias g='git'
alias gd='git diff'
alias ga='git add'
alias t='tig'

function git() {
  if [[ $# -eq 0 ]]; then
    command git status
  else
    command git "$@"
  fi
}

# k1LoW/git-wt のシェル統合 (git wt <branch> で cd する)。
# --init が定義する git() が上の git() を潰すので、_git_wt_wrapper に退避してから定義し直す。
if command -v git-wt >/dev/null 2>&1; then
  eval "$(command git-wt --init bash)"
  eval "$(declare -f git | sed '1s/^git /_git_wt_wrapper /')"
  function git() {
    if [[ $# -eq 0 ]]; then
      command git status
    else
      _git_wt_wrapper "$@"
    fi
  }
fi
