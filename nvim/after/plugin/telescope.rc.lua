local status, telescope = pcall(require, "telescope")
if (not status) then return end
local actions = require('telescope.actions')
local builtin = require("telescope.builtin")

local function telescope_buffer_dir()
  return vim.fn.expand('%:p:h')
end

local fb_actions = require "telescope".extensions.file_browser.actions

telescope.setup {
  defaults = {
    file_ignore_patterns = {
      "node_modules"
    },
    mappings = {
      n = {
        ["q"] = actions.close
      },
    },
  },
  extensions = {
    file_browser = {
      theme = "dropdown",
      -- disables netrw and use telescope-file-browser in its place
      hijack_netrw = true,
      mappings = {
        -- your custom insert mode mappings
        ["i"] = {
          ["<C-w>"] = function() vim.cmd('normal vbd') end,
        },
        ["n"] = {
          -- your custom normal mode mappings
          ["N"] = fb_actions.create,
          ["h"] = fb_actions.goto_parent_dir,
          ["/"] = function()
            vim.cmd('startinsert')
          end
        },
      },
    },
  },
}

telescope.load_extension("file_browser")

vim.keymap.set('n', '<leader>sf',
  function()
    builtin.find_files({
      desc = '[S]earch [F]iles',
      no_ignore = true,
      hidden = true,
    })
  end)
vim.keymap.set('n', '<leader>sg', function()
  builtin.live_grep({
    desc = '[S]earch current [W]ord',
    no_ignore = true,
    hidden = true,
  })
end)
vim.keymap.set('n', '\\\\', function()
  builtin.buffers()
end)
vim.keymap.set('n', '<leader>sh', function()
  builtin.help_tags({ desc = '[S]earch [H]elp' })
end)
vim.keymap.set('n', '<leader>sr', function()
  builtin.resume()
end)
vim.keymap.set('n', '<leader>sd', function()
  builtin.diagnostics({ desc = '[S]earch [D]iagnostics' })
end)
vim.keymap.set('n', '<leader>gf', function()
  builtin.git_files({ desc = 'Search [G]it [F]iles' })
end)
vim.keymap.set('n', '<leader>sw', function()
  builtin.grep_string({
    desc = '[S]earch current [W]ord',
    no_ignore = true,
    hidden = true,
  })
end)
vim.keymap.set("n", "sf", function()
  telescope.extensions.file_browser.file_browser({
    path = "%:p:h",
    cwd = telescope_buffer_dir(),
    respect_gitignore = false,
    hidden = true,
    grouped = true,
    previewer = true,
    initial_mode = "normal",
    layout_config = { height = 40 }
  })
end)
