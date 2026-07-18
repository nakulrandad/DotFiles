-- ~/.config/nvim/init.lua
-- Works both inside VSCode (vscode-neovim) and in a plain terminal nvim.

vim.g.mapleader = ' '      -- Space as the leader key
vim.g.maplocalleader = ' '

-- Options
vim.opt.clipboard = 'unnamedplus' -- y/p use the system clipboard
vim.opt.ignorecase = true         -- case-insensitive search...
vim.opt.smartcase = true          -- ...unless you type a capital letter

-- Flash the text you just yanked - great feedback while learning.
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function() vim.highlight.on_yank({ timeout = 150 }) end,
})

-- Keep the cursor centred on big jumps and search hits.
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')

-- Esc in normal mode clears leftover search highlighting.
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Plugins (nvim 0.12 built-in package manager)
-- nvim-surround: ysiw" to surround, cs"' to change, ds( to delete
vim.pack.add({ 'https://github.com/kylechui/nvim-surround' })
require('nvim-surround').setup()

if vim.g.vscode then
  local vscode = require('vscode')
  local function action(name)
    return function() vscode.action(name) end
  end

  -- Files and search via VSCode's own UI.
  vim.keymap.set('n', '<leader>ff', action('workbench.action.quickOpen'))
  vim.keymap.set('n', '<leader>fg', action('workbench.action.findInFiles'))
  vim.keymap.set('n', '<leader>e', action('workbench.view.explorer'))

  -- Rename symbol.
  vim.keymap.set('n', '<leader>rn', action('editor.action.rename'))

  -- Toggle comments with gcc / gc in visual mode.
  vim.keymap.set({ 'n', 'v' }, 'gc', action('editor.action.commentLine'))

  -- Move between editor splits with Ctrl-h/j/k/l.
  vim.keymap.set('n', '<C-h>', action('workbench.action.navigateLeft'))
  vim.keymap.set('n', '<C-j>', action('workbench.action.navigateDown'))
  vim.keymap.set('n', '<C-k>', action('workbench.action.navigateUp'))
  vim.keymap.set('n', '<C-l>', action('workbench.action.navigateRight'))
else
  -- Terminal-only: VSCode draws its own line numbers, etc.
  vim.opt.number = true
  vim.opt.relativenumber = true
end
