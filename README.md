# jh-dotfiles

개인 개발 환경 설정 파일 모음

## 포함 항목

- **zsh**: oh-my-zsh + powerlevel10k + 플러그인
- **nvim**: lazy.nvim + telescope + treesitter
- **tmux**: 마우스 지원, pane 단축키
- **git**: 기본 설정
- **claude**: Claude Code 설정 및 훅

## 설치

```bash
git clone https://github.com/jeonghun/jh-dotfiles.git ~/dotfiles
cd ~/dotfiles
chmod +x install.sh
./install.sh
```

## DevContainer에서 사용

```json
{
  "postCreateCommand": "git clone https://github.com/jeonghun/jh-dotfiles.git ~/dotfiles && ~/dotfiles/install.sh"
}
```

## 구조

```
jh-dotfiles/
├── install.sh
├── zsh/
│   ├── .zshrc
│   ├── .zsh_aliases
│   └── .p10k.zsh
├── git/
│   └── .gitconfig
├── tmux/
│   └── .tmux.conf
├── nvim/
│   └── init.lua
└── claude/
    ├── settings.json
    ├── CLAUDE.md
    └── hooks/
        └── notify.sh
```
