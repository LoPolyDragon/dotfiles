# ⚙️ Zsh 选项配置
# ================

# 历史选项
setopt EXTENDED_HISTORY          # 记录时间戳
setopt HIST_EXPIRE_DUPS_FIRST   # 删除重复历史
setopt HIST_IGNORE_DUPS         # 忽略重复
setopt HIST_IGNORE_ALL_DUPS     # 删除旧的重复
setopt HIST_IGNORE_SPACE        # 忽略空格开头的命令
setopt HIST_FIND_NO_DUPS        # 查找时忽略重复
setopt HIST_SAVE_NO_DUPS        # 保存时忽略重复
setopt HIST_VERIFY              # 历史扩展前确认
setopt SHARE_HISTORY            # 共享历史

# 目录选项
setopt AUTO_CD                  # 自动 cd
setopt AUTO_PUSHD               # 自动 pushd
setopt PUSHD_IGNORE_DUPS        # pushd 忽略重复
setopt PUSHD_SILENT             # 静默 pushd

# 补全选项
setopt AUTO_MENU                # 自动菜单
setopt ALWAYS_TO_END            # 补全后光标移动到末尾
setopt COMPLETE_IN_WORD         # 在单词中间补全
setopt CORRECT                  # 命令纠错
setopt CORRECT_ALL              # 参数纠错

# Glob 选项
setopt EXTENDED_GLOB            # 扩展 glob
setopt NUMERIC_GLOB_SORT        # 数字 glob 排序

# 其他选项
setopt INTERACTIVE_COMMENTS     # 允许交互式注释
setopt NO_BEEP                  # 不蜂鸣
setopt PROMPT_SUBST             # 提示符替换 