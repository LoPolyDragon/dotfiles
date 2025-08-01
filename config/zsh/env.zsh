# 🌍 环境变量配置
# =================

# 编辑器
export EDITOR="nvim"
export VISUAL="nvim"
export PAGER="less"

# 路径配置
export PATH="/opt/homebrew/opt/coreutils/libexec/gnubin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.rbenv/shims:$PATH"
export PATH="$HOME/.spicetify:$PATH"

# Node.js
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# Homebrew
export HOMEBREW_NO_ANALYTICS=1
export HOMEBREW_NO_AUTO_UPDATE=1

# Less 配置
export LESS='-R -f -X'
export LESSOPEN='|~/.lessfilter %s'

# 语言环境
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# 历史配置
export HISTFILE="$XDG_DATA_HOME/zsh/history"
export HISTSIZE=50000
export SAVEHIST=50000

# 创建必要的目录
[[ ! -d "$XDG_DATA_HOME/zsh" ]] && mkdir -p "$XDG_DATA_HOME/zsh" 