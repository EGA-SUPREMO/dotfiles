vim.opt.termguicolors = true
vim.opt.background = "dark" -- or "light" this shit to avoid long as shit startup times, shit shit 
vim.opt.ttimeoutlen = 5

-- 1. Set your leader key
vim.g.mapleader = " "

-- Fix the 'DSR' delay by telling Neovim not to wait for a response
-- (Optional: only if the above doesn't work) export COLORTERM=truecolor in zhrc
-- vim.go.t_RB = ""
-- vim.go.t_RF = ""

vim.opt.undofile = true -- Save undo history to a file
vim.opt.clipboard = "unnamedplus" -- i want everything to my clipboard

-- Keep 8 lines above/below the cursor
vim.opt.scrolloff = 8
vim.o.breakindent = true

-- Set completeopt to have a better completion experience
vim.o.completeopt = "menuone,noselect"

-- Only Yanks go to system clipboard
-- vim.keymap.set({'n', 'v'}, 'y', '"+y')
-- vim.keymap.set('n', 'yy', '"+yy')
-- vim.keymap.set('n', 'Y', '"+Y')

-- 2. Map 'p' to paste from the system clipboard (Recommended)
vim.keymap.set({'n', 'v'}, '<leader>p', '"+p', { desc = "Paste from System Clipboard" })
vim.keymap.set({'n', 'v'}, '<leader>P', '"+P', { desc = "Paste from System Clipboard (Above)" })

vim.keymap.set('n', '<leader>w', '<cmd>write<cr>', { desc = 'Save current buffer' })
vim.keymap.set('n', '<leader>wa', '<cmd>wall<cr>', { desc = 'Save all buffers' })
vim.keymap.set('n', '<leader>wq', '<cmd>wqall<cr>', { desc = 'Save all and quit' })

vim.opt.number = true          -- Show absolute line number
vim.opt.relativenumber = true  -- Show relative numbers

vim.opt.ignorecase = true  -- Ignore case in search patterns
vim.opt.smartcase = true   -- Override 'ignorecase' if search pattern contains upper case characters

-- Standard Python-friendly indentation
vim.opt.expandtab = true   -- Convert tabs to spaces
vim.opt.softtabstop = 4   -- Makes the tab key feel like 4 spaces
vim.opt.shiftwidth = 4    -- Size of an indent
vim.opt.tabstop = 4       -- Number of spaces a tab counts for

-- theme
-- vim.cmd.colorscheme "catppuccin"

-- In init.lua
vim.api.nvim_create_autocmd("FileType", {
    pattern = "gitcommit",
    callback = function()
        -- Sets a vertical line at column 50
        vim.opt_local.colorcolumn = "50"
        -- Optional: Enable spell checking for better commit messages
        vim.opt_local.spell = true
    end,
})

-- 2. Bootstrap 'lazy.nvim'
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git", "clone", "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- 3. Install Plugins
require("lazy").setup({
    spec = {
        -- PLUGIN 1: Telescope
        {
            'nvim-telescope/telescope.nvim',
            dependencies = {
                'nvim-lua/plenary.nvim',
                { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' }
            },
            config = function()
                local builtin = require('telescope.builtin')
                vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
                vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
                vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
                vim.keymap.set('n', '<leader>fr', builtin.resume, { desc = 'Resume last search' })
                vim.keymap.set('n', '<leader>fp', builtin.oldfiles, { desc = 'Recent Files' })
            end
        },

        -- PLUGIN 2: Treesitter (Merged into one block, removed old tag)
        {
            'nvim-treesitter/nvim-treesitter',
            build = ':TSUpdate',
            config = function()
                require('nvim-treesitter.configs').setup({
                    ensure_installed = { "lua", "vim", "vimdoc", "query", "javascript", "python", "gdscript", "gdshader" },
                    highlight = { enable = true, additional_vim_regex_highlighting = false},
                    indent = { enable = false },
                    auto_install = true,
                })
            end
        },

        -- PLUGIN 3: Smart Open (FIXED THE BRANCH HERE)
        {
            "danielfalk/smart-open.nvim",
            branch = "0.3.x", -- Changed from 0.2.x to fix your error
            dependencies = {
                "kkharji/sqlite.lua",
                { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
            },
            config = function()
                require("telescope").load_extension("smart_open")
                vim.keymap.set("n", "<leader><leader>", function()
                    require("telescope").extensions.smart_open.smart_open()
                end, { desc = "Smart Open" })
            end,
        },

        -- PLUGIN 4: Gitsigns
        {
            "lewis6991/gitsigns.nvim",
            opts = {}, -- This is a shorthand for calling .setup({})
        },

        -- PLUGIN 5: LSP Config (Corrected for Godot)
        {
            "neovim/nvim-lspconfig",
        },
        {
            "williamboman/mason.nvim",
            opts = {}, -- This installs the Mason manager
        },
        {
            "neovim/nvim-lspconfig",
            dependencies = { "williamboman/mason.nvim" },
        },
        -- {
        --     'windwp/nvim-autopairs',
        --     event = "InsertEnter",
        --     config = true
        --     -- use opts = {} for passing setup options
        --     -- this is equivalent to setup({}) function
        -- },
        {
            'sainnhe/everforest',
            lazy = false,
            priority = 1000,
            config = function()
                -- Optionally configure and load the colorscheme
                -- directly inside the plugin declaration.
                vim.g.everforest_enable_italic = true
                vim.g.everforest_background = 'hard'
                vim.cmd.colorscheme('everforest')
            end
        },
        {
            "hrsh7th/nvim-cmp",
            event = {"InsertEnter", "CmdlineEnter"},
            dependencies = {
                -- Snippet Engine & its associated nvim-cmp source
                "L3MON4D3/LuaSnip",
                "saadparwaiz1/cmp_luasnip",

                -- Adds LSP completion capabilities
                "hrsh7th/cmp-nvim-lsp",

                -- Adds a number of user-friendly snippets
                "rafamadriz/friendly-snippets",

                -- Other useful completion sources
                "hrsh7th/cmp-buffer",
                "hrsh7th/cmp-path",
                'hrsh7th/cmp-cmdline',
                "hrsh7th/cmp-nvim-lsp-signature-help",

                -- NEW: Icons
                "onsails/lspkind.nvim",

                -- NEW: Autopairs
                {
                    "windwp/nvim-autopairs",
                    config = function()
                        require("nvim-autopairs").setup({})
                    end,
                },
            },
            config = function()
                local cmp = require("cmp")
                local luasnip = require("luasnip")
                local lspkind = require("lspkind")
                local cmp_autopairs = require("nvim-autopairs.completion.cmp")
                require("luasnip.loaders.from_vscode").lazy_load()

                cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

                cmp.setup({
                    snippet = {
                        expand = function(args)
                            luasnip.lsp_expand(args.body)
                        end,
                    },
                    formatting = {
                        fields = { 'abbr', 'icon', 'kind', 'menu' },
                        format = lspkind.cmp_format({
                            mode = 'symbol_text', -- show only symbol annotations
                            maxwidth = 60, -- prevent the popup from showing more than provided characters
                            ellipsis_char = '...', -- when popup menu exceeds maxwidth, the truncated part would show ellipsis_char instead
                        })
                    },
                    mapping = cmp.mapping.preset.insert({
                        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                        ['<C-f>'] = cmp.mapping.scroll_docs(4),
                        ['<C-Space>'] = cmp.mapping.complete(),
                        ['<C-e>'] = cmp.mapping.abort(),
                        ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item
                        ['<Tab>'] = cmp.mapping(function(fallback)
                            if cmp.visible() then
                                cmp.select_next_item()
                            elseif luasnip.expand_or_jumpable() then
                                luasnip.expand_or_jump()
                            else
                                fallback()
                            end
                        end, { 'i', 's' }),
                    }),
                    sources = cmp.config.sources({
                        { name = 'nvim_lsp' },
                        { name = 'nvim_lsp_signature_help' },
                        { name = 'luasnip' },
                    }, {
                        { name = 'buffer' },
                        { name = 'path' },
                    })
                })
                -- Set configuration for specific filetype.
                cmp.setup.cmdline('/', {
                    mapping = cmp.mapping.preset.cmdline(),
                    sources = {
                        { name = 'buffer' }
                    }
                })

                -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
                cmp.setup.cmdline(':', {
                    mapping = cmp.mapping.preset.cmdline(),
                    sources = cmp.config.sources({
                        { name = 'path' }
                    }, {
                        { name = 'cmdline' }
                    })
                })
            end,
        }
    },
    rocks = {
        enabled = false,
        hererocks = false,
    },
})

-- 1. Configure Lua Language Server
vim.lsp.config['lua_ls'] = {
    cmd = { 'lua-language-server' },
    filetypes = { 'lua' },
    root_markers = { '.luarc.json', '.git' },
    settings = {
        Lua = {
            runtime = { version = 'LuaJIT' },
            diagnostics = { globals = { 'vim' } }, -- Stop the "undefined global 'vim'" warning
            workspace = {
                checkThirdParty = false,
                library = {
                    vim.env.VIMRUNTIME,
                    -- Add other libraries if needed
                },
            },
        },
    },
}
-- Crea las capacidades para que el LSP sepa hablar con nvim-cmp
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- 2. Configure Godot (GDScript)
-- Note: Ensure Godot is open and "Language Server" is enabled in Editor Settings
vim.lsp.config['gdscript'] = {
    cmd = vim.lsp.rpc.connect('127.0.0.1', 6005),
    filetypes = { 'gdscript' },
    root_markers = { 'project.godot' },
    capabilities = capabilities,
}

-- Configure Bash Language Server
vim.lsp.config['bashls'] = {
    cmd = { 'bash-language-server', 'start' },
    filetypes = { 'sh', 'bash', 'zsh' },
    -- These markers tell the LSP where your "project" begins
    root_markers = { '.git', '.zshrc', 'package.json' },
    capabilities = capabilities,
}

-- Enable it
vim.lsp.enable('bashls')
-- 3. Enable them
vim.lsp.enable('lua_ls')
vim.lsp.enable('gdscript')

vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
        local opts = { buffer = args.buf }

        -- Default LSP actions
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
        vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
        vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
        vim.keymap.set('n', 'gl', vim.diagnostic.open_float, opts)
        vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, opts)

        vim.keymap.set('n', '<leader>gd', function()
            local word = vim.fn.expand("<cword>")
            local url = "https://docs.godotengine.org/en/stable/classes/class_" .. word:lower() .. ".html"
            vim.ui.open(url) -- The "smart" way to open URLs in Neovim
        end, { buffer = args.buf, desc = "Open Godot Docs for CLASSES only in Browser" })

        vim.keymap.set('n', '<leader>GD', function()
            local word = vim.fn.expand("<cword>")
            local url = "https://docs.godotengine.org/en/stable/search.html?q=" .. word
            vim.ui.open(url) -- The "smart" way to open URLs in Neovim
        end, { buffer = args.buf, desc = "Open Godot Docs Search in Browser" })

        -- Enable Inlay Hints if the server supports them
        -- local client = vim.lsp.get_client_by_id(args.data.client_id)
        -- if client and client.supports_method('textDocument/inlayHint') then
            vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
        -- end
    end,
})

-- Function to open Godot docs for the word under cursor
local function open_godot_docs()
    local word = vim.fn.expand("<cword>")
    local url = "https://docs.godotengine.org/en/stable/search.html?q=" .. word

    -- macOS: "open", Linux: "xdg-open", Windows: "start"
    local opener = "xdg-open"
    os.execute(opener .. " " .. url)
end

-- Keymap: <leader>gd for "Godot Documentation"
vim.keymap.set('n', '<leader>gd', open_godot_docs, { desc = "Open Godot Docs in Browser" })
-- vim.keymap.set('n', '<F5>', ':!godot<CR>', { noremap = true, silent = true })
-- vim.keymap.set('n', '<F5>', ':vsplit | term godot<CR>', { silent = true })

vim.keymap.set('n', '<F5>', function()
  -- 1. Open a vertical split
  vim.cmd("vsplit")
  -- 2. Start the terminal with the godot command
  vim.cmd("terminal godot --path .")
  -- 3. Grab the buffer ID of the terminal we just opened
  local buf = vim.api.nvim_get_current_buf()

  -- 4. Create a buffer-local autocommand that fires when the process exits
  vim.api.nvim_create_autocmd("TermClose", {
    buffer = buf,
    callback = function()
      -- Automatically delete the buffer (and close the window)
      vim.api.nvim_buf_delete(buf, { force = true })
    end,
  })

  -- 5. Optional: Enter Insert mode immediately so you can use Godot's UI 
  -- or exit easily, though Godot usually steals focus anyway.
  -- vim.cmd("startinsert") 
end, { silent = true, desc = "Run Godot Project" })


-- 1. Include ':' in filenames so Neovim captures the line number too
vim.opt.isfname:append(":")

vim.keymap.set("n", "gf", function()
  local target = vim.fn.expand("<cfile>")

  -- Check if it's a Godot path
  if target:find("^res://") then
    -- Strip 'res://' and split the path from the line number
    local clean_path = target:gsub("^res://", "")
    local parts = vim.split(clean_path, ":")
    local file = parts[1]
    local line = parts[2]

    -- Open the file if it exists
    if vim.fn.filereadable(file) == 1 then
      vim.cmd("edit " .. file)
      -- Jump to line if specified
      if line then
        vim.api.nvim_win_set_cursor(0, {tonumber(line), 0})
      end
    else
      print("Godot file not found: " .. file)
    end
  else
    -- Fallback to standard 'gf' for normal files
    -- we use pcall to catch "File not found" errors gracefully
    local ok, _ = pcall(vim.cmd, "normal! gF")
    if not ok then print("No file found under cursor") end
  end
end, { desc = "Godot-aware gf (Go to File)" })

-- this shit didnt work, fucking shit
-- 1. Create an autocommand group so we don't accidentally duplicate rules
local indent_group = vim.api.nvim_create_augroup("LanguageIndentation", { clear = true })

-- 2. GDScript (Godot) Override: STRICTLY TABS
vim.api.nvim_create_autocmd("FileType", {
    group = indent_group,
    pattern = "gdscript",
    callback = function()
        -- opt_local ensures this ONLY applies to the current buffer
        vim.opt_local.expandtab = false
        vim.opt_local.shiftwidth = 4
        vim.opt_local.tabstop = 4
        vim.opt_local.softtabstop = 4
    end,
})

-- 
vim.keymap.set('n', '<leader>fh', function()
    local pickers = require("telescope.pickers")
    local finders = require("telescope.finders")
    local make_entry = require("telescope.make_entry")
    local conf = require("telescope.config").values

    pickers.new({}, {
        prompt_title = "Indexed Home Search (plocate)",
        finder = finders.new_job(function(prompt)
            if not prompt or prompt == "" then
                -- Optional: Show nothing or a default set when empty
                return { "plocate", "--limit", "20", vim.fn.expand("~") }
            end

            -- This sends your keystrokes directly to the plocate index
            return { "plocate", "--limit", "50", prompt }
        end, make_entry.gen_from_file()),
        previewer = conf.file_previewer({}),
        sorter = conf.generic_sorter({}),
    }):find()
end, { desc = 'Telescope Index Search' })

vim.keymap.set("n", "<leader><leader>", function()
    require("telescope").extensions.smart_open.smart_open()
end, { desc = "Sublime-style Ctrl-P" })

-- Remember last cursor position
vim.api.nvim_create_autocmd("BufReadPost", {
    callback = function()
        local mark = vim.api.nvim_buf_get_mark(0, '"')
        local lcount = vim.api.nvim_buf_line_count(0)
        if mark[1] > 0 and mark[1] <= lcount then
            pcall(vim.api.nvim_win_set_cursor, 0, mark)
        end
    end,
})

vim.opt.signcolumn = "yes"

vim.opt.listchars = {
  tab = '» ',    -- Shows '»' at the start of a tab
  trail = '·',   -- Shows '·' for trailing spaces at end of line
  nbsp = '␣',    -- Shows '␣' for non-breaking spaces
  extends = '»',
  precedes = '«',
}

-- MUST BE AT THE BOTTON OF THE FILE
-- Use ; for commands
vim.keymap.set('n', ';', ':', { desc = 'Enter Command Mode' })
vim.keymap.set('v', ';', ':', { desc = 'Enter Command Mode' })

-- Use : for the original semicolon behavior (optional)
vim.keymap.set('n', ':', ';', { desc = 'Repeat last f/t jump' })
vim.keymap.set('v', ':', ';', { desc = 'Repeat last f/t jump' })
