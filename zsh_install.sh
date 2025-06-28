#!/bin/bash

# 脚本说明
echo "========================================================="
echo "  自动配置 Zsh 环境脚本"
echo "  此脚本将自动安装 Zsh、Oh-My-Zsh 以及常用插件。"
echo "  请确保以 root 用户身份运行此脚本。"
echo "========================================================="

# 1. 安装 Zsh
echo "1. 安装 Zsh..."
apt update  # 加上 -y 避免交互
if [ $? -eq 0 ]; then
  echo "apt update 成功。"
else
  echo "apt update 失败，请检查网络连接或手动更新。"
  exit 1
fi

apt install zsh
if [ $? -eq 0 ]; then
  echo "Zsh 安装完成。"
else
  echo "Zsh 安装失败，请检查网络连接或手动安装。"
  exit 1
fi

# 2. 安装 Oh-My-Zsh
echo "2. 安装 Oh-My-Zsh..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
if [ $? -eq 0 ]; then
  echo "Oh-My-Zsh 安装完成。"
  echo "Oh-My-Zsh 安装过程中会询问是否将 Zsh 设置为默认 Shell，请根据您的需求选择。"
else
  echo "Oh-My-Zsh 安装失败，请检查网络连接或手动安装。"
  exit 1
fi

# 3. 安装 Oh-My-Zsh 常用插件并配置
echo "3. 安装 Oh-My-Zsh 常用插件..."
apt install autojump zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions

if [ $? -eq 0 ]; then
  echo "插件安装完成。"
else
  echo "插件安装失败，请检查网络连接或手动安装。"
  exit 1
fi

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

if [ $? -eq 0 ]; then
  echo ".zshrc 文件配置完成。"
else
  echo ".zshrc 文件配置失败，请手动配置。"
  exit 1
fi

# 5. 应用插件
echo "5. 应用插件..."
source ~/.zshrc
if [ $? -eq 0 ]; then
  echo "插件应用完成。"
else
  echo "插件应用失败，请检查 .zshrc 文件配置。"
  exit 1
fi

echo "========================================================="
echo "  Zsh 环境配置完成！"
echo "  请注销并重新登录以使所有更改生效。"
echo "========================================================="
