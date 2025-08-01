# 🔌 插件配置
# ============

# 检查并加载 Homebrew
if [[ -f /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -f /usr/local/bin/brew ]]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi

# Zsh 自动建议
if [[ -f "$(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ]]; then
  source "$(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
  ZSH_AUTOSUGGEST_STRATEGY=(history completion)
  ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#6c7086"
  ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
fi

# Zsh 语法高亮
if [[ -f "$(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]]; then
  source "$(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
  
  # 自定义高亮颜色
  ZSH_HIGHLIGHT_STYLES[default]='none'
  ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=red,bold'
  ZSH_HIGHLIGHT_STYLES[reserved-word]='fg=magenta'
  ZSH_HIGHLIGHT_STYLES[alias]='fg=green'
  ZSH_HIGHLIGHT_STYLES[builtin]='fg=green'
  ZSH_HIGHLIGHT_STYLES[function]='fg=green'
  ZSH_HIGHLIGHT_STYLES[command]='fg=green'
  ZSH_HIGHLIGHT_STYLES[precommand]='fg=green,underline'
  ZSH_HIGHLIGHT_STYLES[commandseparator]='none'
  ZSH_HIGHLIGHT_STYLES[hashed-command]='fg=green'
  ZSH_HIGHLIGHT_STYLES[path]='fg=cyan,underline'
  ZSH_HIGHLIGHT_STYLES[globbing]='fg=blue'
  ZSH_HIGHLIGHT_STYLES[history-expansion]='fg=blue'
  ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='fg=yellow'
  ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='fg=yellow'
  ZSH_HIGHLIGHT_STYLES[back-quoted-argument]='fg=magenta'
  ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='fg=yellow'
  ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='fg=yellow'
  ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]='fg=cyan'
  ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]='fg=cyan'
  ZSH_HIGHLIGHT_STYLES[assign]='none'
fi

# FZF 集成
if command -v fzf &> /dev/null; then
  eval "$(fzf --zsh)"
  
  # FZF 主题配置 (Catppuccin Mocha)
  export FZF_DEFAULT_OPTS="
    --color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8
    --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc
    --color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8
    --border=rounded
    --height=40%
    --layout=reverse
    --info=inline
    --preview-window=right:50%:wrap
  "
  
  # FZF 文件预览
  export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
  export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'
  
  # 预览设置
  show_file_or_dir_preview="if [ -d {} ]; then eza --tree --color=always {} | head -200; else bat -n --color=always --line-range :500 {}; fi"
  export FZF_CTRL_T_OPTS="--preview '$show_file_or_dir_preview'"
  export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"
  
  # FZF Git 集成
  [[ -f "$HOME/scripts/fzf-git.sh" ]] && source "$HOME/scripts/fzf-git.sh"
fi

# Zoxide (智能 cd)
if command -v zoxide &> /dev/null; then
  eval "$(zoxide init zsh)"
fi

# Direnv (环境变量管理)
if command -v direnv &> /dev/null; then
  eval "$(direnv hook zsh)"
fi

# Atuin (历史记录同步)
if command -v atuin &> /dev/null; then
  export ATUIN_NOBIND="true"
  eval "$(atuin init zsh)"
  bindkey '^r' atuin-up-search-viins
fi

# 键位绑定
bindkey '^[[A' history-search-backward  # 上箭头
bindkey '^[[B' history-search-forward   # 下箭头
bindkey '^[[H' beginning-of-line        # Home
bindkey '^[[F' end-of-line              # End
bindkey '^[[3~' delete-char             # Delete
bindkey '^[[1;5C' forward-word          # Ctrl+右箭头
bindkey '^[[1;5D' backward-word         # Ctrl+左箭头

# Emacs 模式（默认）- 已移除 Vi 模式
# 保留有用的键位绑定
bindkey '^E' autosuggest-accept  # Ctrl+E 接受建议
bindkey '^P' up-line-or-history    # Ctrl+P 上一条历史
bindkey '^N' down-line-or-history  # Ctrl+N 下一条历史

# 取消 Ctrl+A 的默认绑定，让它传递给 tmux
bindkey -r '^A'  # 取消 Ctrl+A 的 beginning-of-line 绑定（无论是否在 tmux 中）

# 补全设置
autoload -Uz compinit
compinit -d "$XDG_CACHE_HOME/zsh/zcompdump-$ZSH_VERSION"

# 补全样式
zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' completer _expand _complete _ignored _approximate
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/zcompcache" 