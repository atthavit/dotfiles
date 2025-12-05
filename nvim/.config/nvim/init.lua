vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.showcmd = true
vim.opt.incsearch = true
vim.opt.hlsearch = true
vim.opt.hidden = true
vim.opt.splitright = true
vim.opt.splitbelow = true
-- vim.opt.backspace = 2
vim.opt.encoding = 'utf-8'
vim.opt.smartcase = true
vim.opt.ignorecase = true
vim.opt.timeoutlen = 500
vim.opt.mouse = 'c'

vim.wo.wrap = false
vim.wo.foldenable = false


local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  {
    'ellisonleao/gruvbox.nvim',
    lazy = false,
    priority = 1000,
    opts = {
      contrast = 'dark',
      transparent_mode = true,
    },
    init = function()
      vim.cmd([[colorscheme gruvbox]])
    end,
  },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('lualine').setup({
        options = {
          -- icons_enabled = false,
          section_separators = '',
          component_separators = '',
        },
        sections = {
          lualine_b = { 'diff', 'diagnostics' },
          lualine_c = { { 'filename', path = 1, } },
          lualine_a = {
            {
              require("noice").api.statusline.mode.get,
              cond = require("noice").api.statusline.mode.has,
            },
            'mode',
          },
        },
      })
    end,
  },
  {
    'lewis6991/gitsigns.nvim',
    opts = {
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map('n', ']c', function()
          if vim.wo.diff then return ']c' end
          vim.schedule(function() gs.next_hunk() end)
          return '<Ignore>'
        end, { expr = true })

        map('n', '[c', function()
          if vim.wo.diff then return '[c' end
          vim.schedule(function() gs.prev_hunk() end)
          return '<Ignore>'
        end, { expr = true })

        -- Actions
        map('n', '<leader>hs', gs.stage_hunk)
        map('n', '<leader>hS', gs.stage_buffer)
        map('v', '<leader>hs', function() gs.stage_hunk { vim.fn.line('.'), vim.fn.line('v') } end)
        map('n', '<leader>hu', gs.reset_hunk)
        map('n', '<leader>hU', gs.reset_buffer)
        map('v', '<leader>hu', function() gs.reset_hunk { vim.fn.line('.'), vim.fn.line('v') } end)
        map('n', '<leader>hp', gs.preview_hunk)
        map('n', '<leader>hb', function() gs.blame_line { full = true } end)
        map('n', '<leader>tb', gs.toggle_current_line_blame)
        map('n', '<leader>hd', gs.diffthis)
        map('n', '<leader>hD', function() gs.diffthis('~') end)
        map('n', '<leader>td', gs.toggle_deleted)

        -- Text object
        map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
      end
    },
  },
  { 'tpope/vim-fugitive' },
  { 'tpope/vim-sleuth' },
  {
    'ray-x/go.nvim',
    dependencies = {
      'ray-x/guihua.lua',
      'neovim/nvim-lspconfig',
      'nvim-treesitter/nvim-treesitter',
    },
    opts = {
      tag_options = '',
    },
    config = true,
    event = { 'CmdlineEnter' },
    ft = { 'go', 'gomod' },
    build = ':lua require("go.install").update_all_sync()',
  },

  {
    'thiagoalessio/rainbow_levels.vim',
    cmd = 'RainbowLevelsToggle',
    keys = {
      { '<leader>r', '<cmd>RainbowLevelsToggle<cr>' },
    },
  },
  {
    'tyru/open-browser-github.vim',
    dependencies = { 'tyru/open-browser.vim' },
    keys = {
      { '<Leader>gh', ':OpenGithubFile<CR>' },
    },
    init = function()
      vim.g.openbrowser_github_select_current_line = 1
    end,
  },

  {
    'saghen/blink.cmp',
    version = '*',
    opts = {
      keymap = {
        preset = 'default',
        ['<C-k>'] = { 'select_prev', 'fallback_to_mappings' },
        ['<C-j>'] = { 'select_next', 'fallback_to_mappings' },
        ['<C-e>'] = { 'hide' },
        ['<C-u>'] = { 'scroll_documentation_up', 'fallback' },
        ['<C-d>'] = { 'scroll_documentation_down', 'fallback' },
        ['<tab>'] = { 'select_and_accept', 'fallback' },
      },
      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = 'mono'
      },
      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
      },
      fuzzy = {
        implementation = "prefer_rust_with_warning",
        sorts = {
          function(a, b)
            if a.client_name == nil or b.client_name == nil then return end
            return b.client_name == 'emmet_ls'
          end,
          -- default sorts
          'score',
          'sort_text',
        },
      },
      completion = {
        accept = { auto_brackets = { enabled = false }, },
        documentation = { auto_show = true, auto_show_delay_ms = 300 },
      },
      cmdline = {
        keymap = {
          ['<C-k>'] = { 'select_prev', 'fallback_to_mappings' },
          ['<C-j>'] = { 'select_next', 'fallback_to_mappings' },
        },
        completion = {
          menu = { auto_show = true },
          ghost_text = { enabled = false }
        },
      }
    },
    opts_extend = { "sources.default" }
  },

  {
    'williamboman/mason.nvim',
    config = true,
  },
  {
    'williamboman/mason-lspconfig.nvim',
    dependencies = {
        { "mason-org/mason.nvim", opts = {} },
        "neovim/nvim-lspconfig",
    },
    opts = {
      ensure_installed = {
        'bashls',
        'buf_ls',
        'docker_compose_language_service',
        'dockerls',
        'emmet_language_server',
        'eslint',
        'golangci_lint_ls',
        'graphql',
        'html',
        'jsonls',
        'lua_ls',
        'marksman',
        'ruby_lsp',
        'sqlls',
        'taplo',
        'terraformls',
        'vtsls',
        'yamlls',
      },
    },
  },
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'mason.nvim',
      'mason-lspconfig.nvim',
      'saghen/blink.cmp',
    },
    config = function()
      vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
      vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
      vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
      vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('UserLspConfig', {}),
        callback = function(ev)
          -- Enable completion triggered by <c-x><c-o>
          vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

          -- Buffer local mappings.
          -- See `:help vim.lsp.*` for documentation on any of the below functions
          local opts = { buffer = ev.buf }
          vim.keymap.set('n', '<c-]>', vim.lsp.buf.definition, opts)
          vim.keymap.set('n', '<c-w><c-]>', ':vs<CR><cmd>lua vim.lsp.buf.definition()<CR>', opts)
          vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
          vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
          vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
          -- vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
          -- vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
          -- vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
          -- vim.keymap.set('n', '<space>wl', function()
          --   print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
          -- end, opts)
          vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts)
          vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
          vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)
          vim.keymap.set('n', '<Leader>i', function()
            vim.lsp.buf.code_action({ apply = true, context = { only = { "source.addMissingImports.ts" }, diagnostics = {} } })
            vim.lsp.buf.code_action({ apply = true, context = { only = { "source.removeUnused.ts" }, diagnostics = {} } })
          end)
          -- vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
        end,
      })
    end,
  },
  { 'ray-x/lsp_signature.nvim', config = true },
  {
    'nvim-treesitter/nvim-treesitter',
    version = false,
    opts = {
      ensure_installed = {
        "css",
        "go",
        "hcl",
        "json",
        "lua",
        "python",
        "regex",
        "styled",
        "yaml",
      },
      auto_install = true,
      sync_install = false,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      matchup = {
        enable = true,
      },
      indent = {
        enable = false,
      },
      yati = {
        enable = true,
      }
    },
    config = function(_, opts)
      require('nvim-treesitter.configs').setup(opts)
    end,
    init = function()
      vim.opt.foldmethod = 'expr'
      vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
    end,
  },
  {
    'folke/flash.nvim',
    event = 'VeryLazy',
    opts = {
      label = {
        style = 'eol',
        min_pattern_length = 3,
      },
      modes = {
        char = {
          enabled = false,
        },
      },
    },
    init = function()
      vim.keymap.set('n', '<Leader>/', require('flash').toggle, opts)
    end,
  },
  {
    'folke/trouble.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    init = function()
      vim.keymap.set('n', '<Leader>t', function() require('trouble').open() end, opts)
      vim.keymap.set('n', '<Leader>tq', function() require('trouble').open() end, opts)
      vim.keymap.set('n', 'gi', function() require('trouble').open('lsp_implementations') end, opts)
      vim.keymap.set('n', 'gr', function() require('trouble').open('lsp_references') end, opts)
    end,
  },
  {
    'folke/todo-comments.nvim',
    dependencies = { "nvim-lua/plenary.nvim" },
    config = true,
  },
  'AndrewRadev/splitjoin.vim',
  {
    'ntpeters/vim-better-whitespace',
    init = function()
      vim.g.better_whitespace_operator = ''
    end
  },
  { 'stevearc/oil.nvim',        config = true },
  {
    'numToStr/Comment.nvim',
    dependencies = "JoosepAlviste/nvim-ts-context-commentstring",
    config = function()
      require("Comment").setup {
        pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
      }
    end
  },
  {
    'MisanthropicBit/decipher.nvim',
    commit = '2533e35',
    config = true,
    init = function()
      local decipher = require('decipher')
      vim.keymap.set('v', '<leader>e64', function() decipher.encode_selection('base64') end)
      vim.keymap.set('v', '<leader>d64', function() decipher.decode_selection('base64') end)
    end,
  },
  {
    'kylechui/nvim-surround',
    config = function()
      require("nvim-surround").setup({
        surrounds = {
          ["i"] = {
            add = function()
              return {
                { "{t('" }, { "')}" },
              }
            end,
          },
        },
      })
    end,
  },
  { 'NvChad/nvim-colorizer.lua', config = true },
  {
    'j-hui/fidget.nvim',
    tag = 'legacy',
    event = 'LspAttach',
    config = true,
  },
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && npm install && git restore .",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    keys = {
      { '<Leader>md', ':MarkdownPreviewToggle<CR>' },
    },
    ft = { "markdown" },
  },
  {
    'lukas-reineke/indent-blankline.nvim',
    main = "ibl",
    opts = {
      scope = { enabled = false },
    },
  },
  {
    'nvim-pack/nvim-spectre',
    dependencies = { 'nvim-lua/plenary.nvim' },
    init = function()
      vim.api.nvim_create_user_command('Replace', ':Spectre', {})
    end,
  },
  {
    'nvimdev/lspsaga.nvim',
    commit = 'b1b43c1',
    config = true,
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'nvim-tree/nvim-web-devicons',
    },
    opts = {
      symbol_in_winbar = {
        enable = false,
      },
      definition = {
        keys = {
          tabe = 't',
          split = 'x',
          vsplit = 'v',
          close = '<esc>',
        }
      },
      lightbulb = {
        enable = false,
      },
    },
    init = function()
      vim.keymap.set('n', ']]', ':Lspsaga peek_definition<cr>')
      vim.api.nvim_create_user_command('CodeAction', ':Lspsaga code_action', {})
      vim.api.nvim_create_user_command('Rename', ':Lspsaga rename', {})
      vim.api.nvim_create_user_command('Outline', ':Lspsaga outline', {})
    end,
  },
  {
    'ibhagwan/fzf-lua',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = true,
    opts = {
      winopts = {
        height = 0.9,
        width = 0.9,
        preview = {
          layout = 'vertical',
          vertical = 'up:60%',
        },
      },
      keymap = {
        builtin = {
          ['<c-u>'] = 'preview-page-up',
          ['<c-d>'] = 'preview-page-down',
        },
      },
    },
    init = function()
      local fzf = require('fzf-lua')
      vim.keymap.set('n', '<c-p>', fzf.files)
      vim.keymap.set('n', '<c-o>', fzf.lsp_live_workspace_symbols)
      vim.keymap.set('n', "<c-s-f>", fzf.live_grep)
      vim.keymap.set('n', '<leader>b', fzf.buffers)
      vim.keymap.set('n', '<leader>p', fzf.live_grep)
      vim.keymap.set('n', '<leader>gs', fzf.git_status)
      vim.keymap.set('v', '<leader>p', fzf.grep_visual)
      vim.keymap.set('n', '<leader>`', fzf.marks)
      vim.keymap.set('n', "<leader>'", fzf.marks)
      vim.api.nvim_create_user_command('Ag', fzf.live_grep, {})
      vim.api.nvim_create_user_command('Maps', fzf.keymaps, {})
      vim.api.nvim_create_user_command('Glog', fzf.git_bcommits, {})
    end,
  },
  {
    "scalameta/nvim-metals",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    ft = { "scala", "sbt", "java" },
    opts = function()
      local metals_config = require("metals").bare_config()
      metals_config.on_attach = function(client, bufnr)
        -- your on_attach function
      end

      return metals_config
    end,
    config = function(self, metals_config)
      local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
      vim.api.nvim_create_autocmd("FileType", {
        pattern = self.ft,
        callback = function()
          require("metals").initialize_or_attach(metals_config)
        end,
        group = nvim_metals_group,
      })
    end
  },
  {
    "rcarriga/nvim-notify",
    opts = {
      stages = 'static',
      background_colour = "#000000",
      top_down = false,
    },
    keys = {
      { '<Leader><esc>', function() require('notify').dismiss() end }
    },
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      lsp = {
        -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
        },
      },
      -- you can enable a preset for easier configuration
      presets = {
        bottom_search = true,         -- use a classic bottom cmdline for search
        command_palette = true,       -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = false,           -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = false,       -- add a border to hover docs and signature help
      },
    },
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    }
  },
  {
    "windwp/nvim-ts-autotag",
    config = true,
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = true,
  },
  {
    "yioneko/nvim-yati",
  },
  {
    "ThePrimeagen/refactoring.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    lazy = false,
    config = function()
      require("refactoring").setup()
    end,
  },
  {
    "stevearc/conform.nvim",
    lazy = false,
    opts = {
      default_format_opts = {
        lsp_format = "fallback",
      },
      format_after_save = function(bufnr)
        local enabled_filetypes = { "go", "gomod" }
        if vim.tbl_contains(enabled_filetypes, vim.bo[bufnr].filetype) then
          return { lsp_format = "fallback" }
        end
      end,
      formatters_by_ft = {
        go = { "goimports", "gofmt" },
        typescriptreact = { "prettierd", "prettier", stop_after_first = true },
        javascript = { "prettierd", "prettier", stop_after_first = true },
        javascriptreact = { "prettierd", "prettier", stop_after_first = true },
        typescript = { "prettierd", "prettier", stop_after_first = true },
        python = { "black" },
        vue = { "prettierd", "prettier", stop_after_first = true },
        css = { "prettierd", "prettier", stop_after_first = true },
        scss = { "prettierd", "prettier", stop_after_first = true },
        less = { "prettierd", "prettier", stop_after_first = true },
        html = { "prettierd", "prettier", stop_after_first = true },
        yaml = { "prettierd", "prettier", stop_after_first = true },
        markdown = { "prettierd", "prettier", stop_after_first = true },
        graphql = { "prettierd", "prettier", stop_after_first = true },
      },
    },
    keys = {
      {
        "<leader>f",
        function()
          require("conform").format()
        end,
        mode = { "n", "v" },
      },
    },
  },
  { "junegunn/vim-peekaboo" },
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'javascript,lua,html,css,typescript,typescriptreact',
  callback = function()
    vim.opt_local.sw = 2
    vim.opt_local.ts = 2
    vim.opt_local.sts = 2
  end,
})

local opts = { noremap = true, silent = true }
vim.keymap.set('c', 'w!!<cr>', ':w ! sudo tee % > /dev/null', opts)
vim.keymap.set('c', '<Leader>d', '<C-R>=expand("%:p:h")."/"<CR>', opts)

vim.keymap.set('n', '<Leader>w', ':update<CR>', opts)
vim.keymap.set('n', '<Leader>q', ':q<CR>', opts)
vim.keymap.set('n', '<Leader>Q', ':q!<CR>', opts)
vim.keymap.set('n', '<Leader>l', ':Lazy<CR>', opts)
vim.keymap.set('n', '<space>', 'za', opts)
vim.keymap.set('n', '<c-k>', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
vim.keymap.set('n', '<c-j>', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
vim.keymap.set('n', '<c-h>', ':LspRestart<CR>', opts)
vim.keymap.set('n', 'Q', '<nop>', opts)
vim.keymap.set('n', 'q:', '<nop>', opts)

vim.keymap.set('i', '<c-space>', '<c-x><c-o>', opts)

vim.g.omni_sql_no_default_maps = 1

vim.keymap.set({ 'n', 'v' }, '\'', '`', { remap = true })
