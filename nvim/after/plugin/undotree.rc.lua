local status, undotree = pcall(require, "undotree")
if (not status) then return end

undotree.setup {}

vim.keymap.set('n', '<leader><F5>', vim.cmd.UndoTreeToggle)
