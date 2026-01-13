#!/bin/bash
set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "=== Dotfiles 설치 시작 ==="

# zsh 설정
echo "[1/6] zsh 설정..."
ln -sf "$DOTFILES_DIR/zsh/.zshrc" "$HOME/.zshrc"
ln -sf "$DOTFILES_DIR/zsh/.zsh_aliases" "$HOME/.zsh_aliases"
ln -sf "$DOTFILES_DIR/zsh/.p10k.zsh" "$HOME/.p10k.zsh"

# oh-my-zsh 설치 (없으면)
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "  oh-my-zsh 설치 중..."
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# powerlevel10k 설치 (없으면)
if [ ! -d "$HOME/powerlevel10k" ]; then
    echo "  powerlevel10k 설치 중..."
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$HOME/powerlevel10k"
fi

# zsh 플러그인 설치
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
    echo "  zsh-autosuggestions 설치 중..."
    git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
fi
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
    echo "  zsh-syntax-highlighting 설치 중..."
    git clone https://github.com/zsh-users/zsh-syntax-highlighting "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
fi

# git 설정
echo "[2/6] git 설정..."
ln -sf "$DOTFILES_DIR/git/.gitconfig" "$HOME/.gitconfig"

# tmux 설정
echo "[3/6] tmux 설정..."
ln -sf "$DOTFILES_DIR/tmux/.tmux.conf" "$HOME/.tmux.conf"

# nvim 설정
echo "[4/6] nvim 설정..."
mkdir -p "$HOME/.config/nvim"
ln -sf "$DOTFILES_DIR/nvim/init.lua" "$HOME/.config/nvim/init.lua"

# claude 설정
echo "[5/6] Claude Code 설정..."
mkdir -p "$HOME/.claude/hooks"
ln -sf "$DOTFILES_DIR/claude/settings.json" "$HOME/.claude/settings.json"
ln -sf "$DOTFILES_DIR/claude/CLAUDE.md" "$HOME/.claude/CLAUDE.md"
ln -sf "$DOTFILES_DIR/claude/hooks/notify.sh" "$HOME/.claude/hooks/notify.sh"
chmod +x "$HOME/.claude/hooks/notify.sh"

# 필수 패키지 설치
echo "[6/6] 필수 패키지 확인..."
if command -v apt-get &> /dev/null; then
    sudo apt-get update -qq
    sudo apt-get install -y -qq zsh tmux neovim curl git
fi

echo ""
echo "=== 설치 완료! ==="
echo "쉘 재시작 또는 'source ~/.zshrc' 실행하세요."
