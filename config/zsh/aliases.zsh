# 🎯 现代化别名配置
# ==================

# 系统别名
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias ~='cd ~'
alias -- -='cd -'
alias cd='z'  # 使用 zoxide 替代 cd

# 现代化工具替换
alias ls='eza --icons --group-directories-first'  # 简洁显示：只有图标和文件名
alias ll='eza -la --icons --group-directories-first --git'  # 详细显示：包含权限、大小、时间等
alias la='eza -a --icons --group-directories-first'
alias lt='eza --tree --icons --group-directories-first'
alias l='eza -1 --icons --group-directories-first'

alias cat='bat --style=auto'
alias less='bat --style=auto --paging=always'
alias grep='rg'
alias find='fd'
alias du='dust'
alias top='btop'
alias htop='btop'

# Git 别名
alias g='git'
alias ga='git add'
alias gaa='git add --all'
alias gc='git commit -v'
alias gcm='git commit -m'
alias gco='git checkout'
alias gd='git diff'
alias gl='git pull'
alias gp='git push'
alias gs='git status'
alias gst='git stash'
alias glog='git log --oneline --decorate --graph'
alias lg='lazygit'

# 快速编辑配置
alias zshrc='$EDITOR $ZDOTDIR/.zshrc'
alias zshreload='source $ZDOTDIR/.zshrc'
alias nvimrc='$EDITOR ~/.config/nvim/init.lua'
alias tmuxrc='$EDITOR ~/.config/tmux/tmux.conf'
alias weztermrc='$EDITOR ~/.config/wezterm/wezterm.lua'

# 系统相关
alias reload='exec zsh'
alias path='echo -e ${PATH//:/\\n}'
alias now='date +"%T"'
alias nowtime=now
alias nowdate='date +"%d-%m-%Y"'

# 网络
alias myip='curl -s ifconfig.me'
alias localip='ipconfig getifaddr en0'
alias ping='ping -c 5'
alias ports='netstat -tulanp'

# 文件操作
alias cp='cp -iv'
alias mv='mv -iv'
alias rm='rm -i'
alias mkdir='mkdir -pv'

# 开发相关
alias serve='python3 -m http.server'
alias jsonpretty='python3 -m json.tool'
alias urldecode='python3 -c "import sys, urllib.parse as ul; print(ul.unquote_plus(sys.argv[1]))"'
alias urlencode='python3 -c "import sys, urllib.parse as ul; print(ul.quote_plus(sys.argv[1]))"'

# 系统清理（macOS）
alias cleanup='sudo rm -rf /tmp/* ~/.Trash/* ~/Library/Caches/* 2>/dev/null'
alias flushdns='sudo dscacheutil -flushcache && sudo killall -HUP mDNSResponder'

# 快速目录跳转
alias dev='cd ~/Dev'
alias downloads='cd ~/Downloads'
alias desktop='cd ~/Desktop'
alias documents='cd ~/Documents'

# Docker (如果使用)
alias dps='docker ps'
alias dpsa='docker ps -a'
alias di='docker images'
alias dstop='docker stop $(docker ps -q)'
alias drm='docker rm $(docker ps -aq)'

# 有用的函数别名
alias weather='curl wttr.in'
alias cheat='curl cheat.sh/'
alias qr='qrencode -t utf8' 