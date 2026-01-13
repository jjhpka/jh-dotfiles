-- ~/.config/nvim/init.lua
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", lazypath })
end
vim.opt.rtp:prepend(lazypath)

vim.cmd('filetype plugin indent on')  

vim.bo.filetype = "on"

-- 신택스 하이라이트
vim.cmd('syntax on')

-- 기타 설정
vim.opt.wildmenu = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.autoindent = true
vim.opt.number = true

-- 들여쓰기 설정
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smarttab = true

local set_keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- 일반 모드(Normal)
set_keymap('n', '<Tab>',   '>>', opts)      -- 들여쓰기 증가
set_keymap('n', '<S-Tab>', '<<', opts)      -- 들여쓰기 감소

-- 비주얼 모드(Visual)
set_keymap('v', '<Tab>',   '>gv', opts)     -- 선택 영역 들여쓰기 증가 후 선택 유지
set_keymap('v', '<S-Tab>', '<gv', opts)     -- 선택 영역 들여쓰기 감소 후 선택 유지

-- 삽입 모드(Insert)
set_keymap('i', '<Tab>',   '<C-t>', opts)   -- 들여쓰기 증가
set_keymap('i', '<S-Tab>', '<C-d>', opts)   -- 들여쓰기 감소

vim.opt.clipboard = 'unnamed'     

-- ~/.config/nvim/init.lua
vim.g.mapleader = " "  -- 스페이스바를 리더키로

-- lazy.nvim 부트스트랩
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- 플러그인 선언
require("lazy").setup({
  { "folke/tokyonight.nvim" },  -- 예시 플러그인
  { 
    "nvim-telescope/telescope.nvim", 
    tag = "0.1.6", 
    dependencies = { 
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-fzf-native.nvim"
    }
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "vimdoc", "lua", "vim" },
        highlight = { enable = true },
      })
    end,
  }
})

-- telescope 키맵
vim.keymap.set('n', '<leader>ff', '<cmd>Telescope find_files<cr>', { desc = 'Find files' })
vim.keymap.set('n', '<leader>fg', '<cmd>Telescope live_grep<cr>', { desc = 'Live grep' })

-- 기본 설정
vim.cmd.colorscheme("tokyonight")  -- 예시 테마 적용

-- 폴딩 자동 저장 및 복원
vim.cmd([[
  augroup AutoSaveFolds
    autocmd!
    autocmd BufWinLeave *.* mkview
    autocmd BufWinEnter *.* silent! loadview
  augroup END
]])
