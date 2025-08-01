# 🌟 提示符配置
# ==============

# 优先使用 Powerlevel10k（如果存在）
if [[ -f /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme ]]; then
  # Enable Powerlevel10k instant prompt
  if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
  fi
  
  # 加载 Powerlevel10k
  source /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme
  
  # 加载 p10k 配置
  [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
  
elif command -v starship &> /dev/null; then
  # 备选：使用 Starship 提示符
  eval "$(starship init zsh)"
else
  # 最后备选：简单的自定义提示符
  autoload -Uz vcs_info
  
  # Git 信息配置
  zstyle ':vcs_info:*' enable git
  zstyle ':vcs_info:git:*' formats ' %F{purple}%b%f'
  zstyle ':vcs_info:git:*' actionformats ' %F{purple}%b%f %F{red}(%a)%f'
  
  # 在每个提示符前更新 vcs_info
  precmd() {
    vcs_info
  }
  
  # 自定义提示符
  setopt PROMPT_SUBST
  
  # 主提示符
  PROMPT='%F{cyan}╭─%f %F{blue}%~%f${vcs_info_msg_0_}
%F{cyan}╰─%f %F{green}❯%f '
  
  # 右侧提示符
  RPROMPT='%F{yellow}%*%f'
fi

# Vi 模式指示器已删除 - 使用标准光标 