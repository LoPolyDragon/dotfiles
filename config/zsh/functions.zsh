# ⚡ 实用函数配置
# ================

# 🗂️ 智能 cd + ls
function cd() {
  builtin cd "$@" && eza --icons --group-directories-first
}

# 📁 创建目录并进入
function mkcd() {
  mkdir -p "$1" && cd "$1"
}

# 🔍 查找并删除
function findkill() {
  ps aux | grep "$1" | grep -v grep | awk '{print $2}' | xargs kill -9
}

# 📝 创建并编辑文件
function touchedit() {
  touch "$1" && $EDITOR "$1"
}

# 🌐 测试网站响应时间
function urltime() {
  curl -o /dev/null -s -w "Connect: %{time_connect} TTFB: %{time_starttransfer} Total: %{time_total}\n" "$1"
}

# 🔐 生成随机密码
function genpass() {
  local length=${1:-16}
  openssl rand -base64 $length | tr -d "=+/" | cut -c1-$length
}

# 📊 显示文件夹大小
function dirsize() {
  du -sh "${1:-.}" | sort -h
}

# 🗜️ 智能解压
function extract() {
  if [ -f "$1" ]; then
    case "$1" in
      *.tar.bz2)   tar xjf "$1"     ;;
      *.tar.gz)    tar xzf "$1"     ;;
      *.bz2)       bunzip2 "$1"     ;;
      *.rar)       unrar x "$1"     ;;
      *.gz)        gunzip "$1"      ;;
      *.tar)       tar xf "$1"      ;;
      *.tbz2)      tar xjf "$1"     ;;
      *.tgz)       tar xzf "$1"     ;;
      *.zip)       unzip "$1"       ;;
      *.Z)         uncompress "$1"  ;;
      *.7z)        7z x "$1"        ;;
      *)           echo "不支持的格式: '$1'" ;;
    esac
  else
    echo "文件不存在: '$1'"
  fi
}

# 📸 截图转文字 (macOS)
function ocr() {
  screencapture -i /tmp/screenshot.png && 
  osascript -e 'tell application "TextEdit" to make new document' &&
  /usr/bin/python3 -c "
import subprocess
import sys
try:
    import pytesseract
    from PIL import Image
    text = pytesseract.image_to_string(Image.open('/tmp/screenshot.png'))
    subprocess.run(['pbcopy'], input=text, text=True)
    print('文字已复制到剪贴板')
except ImportError:
    print('需要安装: pip install pytesseract Pillow')
"
}

# 🌟 Yazi 文件管理器集成
function y() {
  local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
  yazi "$@" --cwd-file="$tmp"
  if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
    builtin cd -- "$cwd"
  fi
  rm -f -- "$tmp"
}

# 🔄 批量重命名
function bulkrename() {
  if [ $# -eq 0 ]; then
    echo "用法: bulkrename 'pattern' 'replacement'"
    return 1
  fi
  
  for file in *"$1"*; do
    if [ -f "$file" ]; then
      mv "$file" "${file/$1/$2}"
      echo "重命名: $file -> ${file/$1/$2}"
    fi
  done
}

# 🎨 显示颜色
function colors() {
  for i in {0..255}; do
    printf "\x1b[48;5;%sm%3d\e[0m " "$i" "$i"
    if (( i == 15 )) || (( i > 15 )) && (( (i-15) % 6 == 0 )); then
      printf "\n"
    fi
  done
}

# 📡 端口扫描
function portscan() {
  local host=${1:-localhost}
  local start_port=${2:-1}
  local end_port=${3:-1000}
  
  echo "扫描 $host 端口 $start_port-$end_port..."
  for port in $(seq $start_port $end_port); do
    (echo >/dev/tcp/$host/$port) &>/dev/null && echo "端口 $port 开放"
  done
}

# 🎯 快速笔记
function note() {
  local note_file="$HOME/notes/$(date +%Y-%m-%d).md"
  mkdir -p "$(dirname "$note_file")"
  
  if [ $# -eq 0 ]; then
    $EDITOR "$note_file"
  else
    echo "$(date '+%H:%M') - $*" >> "$note_file"
    echo "笔记已添加到 $note_file"
  fi
} 