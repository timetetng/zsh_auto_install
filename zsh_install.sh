#!/bin/bash

# 脚本说明
echo "========================================================="
echo "  自动配置 Zsh 环境脚本"
echo "  此脚本将自动安装 Zsh、Oh-My-Zsh 以及常用插件。"
echo "  请确保以 root 用户身份运行此脚本。"
echo "========================================================="

# 0. 安装 curl 和 git
echo "0. 安装 curl 和 git..."
apt update
apt install curl git

# 1. 安装 Zsh
echo "1. 安装 Zsh..."
apt update
apt install zsh

# 2. 安装 Oh-My-Zsh
echo "2. 安装 Oh-My-Zsh..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# 3. 安装 Oh-My-Zsh 常用插件并配置
echo "3. 安装 Oh-My-Zsh 常用插件..."
apt install autojump zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions

# 4. 配置 .zshrc 文件
echo "4. 配置 .zshrc 文件..."
ZSHRC="$HOME/.zshrc"

# 备份原有的 .zshrc 文件
if [ -f "$ZSHRC" ]; then
  cp "$ZSHRC" "$ZSHRC.bak"
  echo "已备份原有的 .zshrc 文件为 .zshrc.bak"
fi

echo "
# 语法高亮、自动补全、快捷跳转
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source \$HOME/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/autojump/autojump.sh
" >> "$ZSHRC"

# 5. 应用插件
echo "5. 应用插件..."
source ~/.zshrc

echo "========================================================="
echo "  Zsh 环境配置完成！"
echo "  请注销并重新登录以使所有更改生效。"
echo "========================================================="
