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


local opts = { noremap=true, silent=true }

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
    opts = {
      options = {
        -- icons_enabled = false,
        section_separators = '',
        component_separators = '',
      },
      sections = {
        lualine_b = {'diff', 'diagnostics'},
        lualine_c = { { 'filename', path = 1, } },
      },
    },
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
        end, {expr=true})

        map('n', '[c', function()
          if vim.wo.diff then return '[c' end
          vim.schedule(function() gs.prev_hunk() end)
          return '<Ignore>'
        end, {expr=true})

        -- Actions
        map('n', '<leader>hs', gs.stage_hunk)
        map('n', '<leader>hS', gs.stage_buffer)
        map('v', '<leader>hs', function() gs.stage_hunk {vim.fn.line('.'), vim.fn.line('v')} end)
        map('n', '<leader>hu', gs.reset_hunk)
        map('n', '<leader>hU', gs.reset_buffer)
        map('v', '<leader>hu', function() gs.reset_hunk {vim.fn.line('.'), vim.fn.line('v')} end)
        map('n', '<leader>hp', gs.preview_hunk)
        map('n', '<leader>hb', function() gs.blame_line{full=true} end)
        map('n', '<leader>tb', gs.toggle_current_line_blame)
        map('n', '<leader>hd', gs.diffthis)
        map('n', '<leader>hD', function() gs.diffthis('~') end)
        map('n', '<leader>td', gs.toggle_deleted)

        -- Text object
        map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
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
    config = true,
    event = { 'CmdlineEnter' },
    ft = {'go', 'gomod'},
    build = ':lua require("go.install").update_all_sync()',
    init = function()
      local format_sync_grp = vim.api.nvim_create_augroup("GoFormat", {})
      vim.api.nvim_create_autocmd('BufWritePre', {
        pattern = '*.go',
        callback = function()
         require('go.format').goimports()
        end,
        group = format_sync_grp,
      })
    end,
  },
  -- {
  --   'RRethy/vim-illuminate',
  --   dependencies = {'gruvbox.nvim'},
  --   init = function()
  --     local config = require("gruvbox").config
  --     local colors = require("gruvbox.palette").get_base_colors(vim.o.background, config.contrast)
  --     vim.cmd('hi IlluminatedWordText guibg=' .. colors.bg1)
  --   end,
  -- },
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
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-emoji',
      'nvim-snippy',
    },
    config = function()
      local cmp = require('cmp')
      cmp.setup({
        preselect = cmp.PreselectMode.None,
        snippet = {
          expand = function(args)
            require('snippy').expand_snippet(args.body)
          end,
        },
        mapping = {
          ['<C-u>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
          ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
          ['<C-n>'] = cmp.mapping(cmp.mapping.select_next_item(), {'i','c'}),
          ['<C-p>'] = cmp.mapping(cmp.mapping.select_prev_item(), {'i','c'}),
          ['<C-Space>'] = cmp.config.disable,
          ['<C-y>'] = cmp.config.disable,
          ['<C-e>'] = cmp.mapping({
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
          }),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
        },
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'snippy' },
          { name = 'buffer' },
          { name = 'path' },
          { name = 'emoji' },
        }),
      })
    end,
  },
  {
    'williamboman/mason.nvim',
    config = true,
  },
  {
    'williamboman/mason-lspconfig.nvim',
    dependencies = { 'mason.nvim' },
    opts = {
      automatic_installation = true,
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
        'sqlls',
        'taplo',
        'terraformls',
        'ts_ls',
        'volar',
        'yamlls',
      },
    },
    config = function(_, opts)
      require('mason-lspconfig').setup(opts)
      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      local lspconfig = require('lspconfig')
      require('mason-lspconfig').setup_handlers {
        function (server_name)
          lspconfig[server_name].setup {}
        end,

        ['cssls'] = function(server_name)
          local capabilities = vim.lsp.protocol.make_client_capabilities()
          capabilities.textDocument.completion.completionItem.snippetSupport = true
          lspconfig[server_name].setup {
            capabilities = capabilities,
            settings = {
              filetypes = { "css", "scss", "less", "javascript" }
            }
          }
        end,

        -- use ray-x/go.nvim instead
        -- ['gopls'] = function()
        --   lspconfig['gopls'].setup {
        --     capabilities = capabilities,
        --     settings = {
        --       gopls = {
        --         usePlaceholders = true,
        --         analyses = {
        --           composites = false,
        --         },
        --       },
        --     },
        --   }
        -- end,

        ['pyright'] = function(server_name)
          lspconfig[server_name].setup {
            capabilities = capabilities,
            settings = {
              python = {
                analysis = {
                  autoSearchPaths = true,
                  diagnosticMode = 'workspace',
                  typeCheckingMode = 'off',
                }
              }
            },
          }
        end,

      }
    end,
  },
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'mason.nvim',
      'mason-lspconfig.nvim',
      'cmp-nvim-lsp',
    },
    config = function()
      vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
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
          -- vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
          vim.keymap.set({ 'n', 'v' }, '<leader>f', function()
            vim.lsp.buf.format { async = true }
          end, opts)
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
  { 'stevearc/oil.nvim', config = true },
  { 'numToStr/Comment.nvim', config = true },
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
    config = true,
  },
  { 'NvChad/nvim-colorizer.lua', config = true },
  {
    'j-hui/fidget.nvim',
    tag = 'legacy',
    event = 'LspAttach',
    config = true,
  },
  {
    'iamcco/markdown-preview.nvim',
    build = function() vim.fn["mkdp#util#install"]() end,
    config = true,
    keys = {
      { '<Leader>md', ':MarkdownPreviewToggle<CR>' },
    },
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
    'dcampos/nvim-snippy',
    dependencies = { 'dcampos/cmp-snippy' },
    opts = {
      mappings = {
        is = {
          ['<Tab>'] = 'expand_or_advance',
          ['<S-Tab>'] = 'previous',
          ['<c-j>'] = 'expand_or_advance',
          ['<c-k>'] = 'previous',
        },
        nx = {
          ['<leader>c'] = 'cut_text',
        },
      },
    },
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
      background_colour = "#000000",
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
          ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
        },
      },
      -- you can enable a preset for easier configuration
      presets = {
        bottom_search = true, -- use a classic bottom cmdline for search
        command_palette = true, -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = false, -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = false, -- add a border to hover docs and signature help
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
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'javascript,lua,html,css',
  callback = function()
      vim.opt_local.sw = 2
      vim.opt_local.ts = 2
      vim.opt_local.sts = 2
  end,
})

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

vim.keymap.set({'n', 'v'}, '\'', '`', {remap=true})
