#!/bin/bash

# FZF Git 集成脚本
# 参考: https://github.com/junegunn/fzf-git.sh

# Git 分支选择
fzf_git_branch() {
  git branch -a --color=always | grep -v '/HEAD\s' | sort |
  fzf --ansi --multi --tac --preview-window right:70% \
      --preview 'git log --oneline --graph --date=short --color=always --pretty="format:%C(auto)%cd %h%d %s" $(sed s/^..// <<< {} | cut -d" " -f1)' |
  sed 's/^..//' | cut -d' ' -f1 |
  sed 's#^remotes/##'
}

# Git 提交选择
fzf_git_log() {
  git log --graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
  fzf --ansi --no-sort --reverse --tiebreak=index --bind=ctrl-s:toggle-sort \
      --preview 'grep -o "[a-f0-9]\{7,\}" <<< {} | head -1 | xargs git show --color=always' \
      --bind "ctrl-m:execute:
                (grep -o '[a-f0-9]\{7,\}' | head -1 |
                xargs -I % sh -c 'git show --color=always % | less -R') << 'FZF-EOF'
                {}
FZF-EOF"
}

# Zsh 键位绑定
if [[ -n ${ZSH_VERSION-} ]]; then
  fzf-git-branch-widget() {
    local result=$(fzf_git_branch)
    LBUFFER="$LBUFFER$result"
    zle reset-prompt
  }
  
  fzf-git-log-widget() {
    fzf_git_log
    zle reset-prompt
  }
  
  zle -N fzf-git-branch-widget
  zle -N fzf-git-log-widget
  
  bindkey '^gb' fzf-git-branch-widget
  bindkey '^gl' fzf-git-log-widget
fi 