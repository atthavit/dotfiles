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
    },
  },
  {
    'mattn/emmet-vim',
    init = function()
      vim.g.user_emmet_leader_key = '<leader><leader>'
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
  {
    'ray-x/go.nvim',
    enabled = false,
    dependencies = {  -- optional packages
      'ray-x/guihua.lua',
      'neovim/nvim-lspconfig',
      'nvim-treesitter/nvim-treesitter',
    },
    config = true,
    event = { 'CmdlineEnter' },
    ft = {'go', 'gomod'},
    build = ':lua require("go.install").update_all_sync()',
    init = function()
      vim.api.nvim_create_autocmd('BufWritePre', {
        pattern = '*.go',
        callback = function()
         require('go.format').goimport()
        end,
        group = vim.api.nvim_create_augroup('GoFormat', {}),
      })
    end,
  },
  {
    'fatih/vim-go',
    build = ':GoUpdateBinaries',
    init = function()
      vim.keymap.set('n', '<Leader>cov', ':GoCoverageToggle<cr>', opts)
      vim.g.go_addtags_transform = 'snakecase'
      vim.g.go_def_mapping_enabled = 0
      vim.g.go_fmt_autosave= 0
      vim.g.go_gopls_enabled= 0
      vim.g.go_highlight_types = 0
    end,
  },
  { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope-fzf-native.nvim',
    },
    config = function()
      local actions = require('telescope.actions')
      require('telescope').setup({
        extensions = {
          fzf = {
            fuzzy = true,                    -- false will only do exact matching
            override_generic_sorter = true,  -- override the generic sorter
            override_file_sorter = true,     -- override the file sorter
            case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
          },
        },
        defaults = {
          layout_strategy = 'vertical',
          layout_config = {
            horizontal = { width = 0.90 },
            vertical = { width = 0.90 },
          },
          mappings = {
            i = {
              ['<c-k>'] = actions.move_selection_previous,
              ['<c-j>'] = actions.move_selection_next,
            },
          },
        },
        pickers = {
          grep_string = {
            only_sort_text = true,
          },
        },
      })
      require('telescope').load_extension('fzf')
      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<c-p>', builtin.find_files)
      vim.keymap.set('n', '<leader>b', builtin.buffers)
      vim.keymap.set('n', '<c-o>', builtin.treesitter)
      vim.keymap.set('n', '<leader>p', builtin.grep_string)
      vim.api.nvim_create_user_command('Ag', builtin.grep_string, {})
    end,
  },
  {
    'RRethy/vim-illuminate',
    dependencies = {'gruvbox.nvim'},
    init = function()
      local config = require("gruvbox").config
      local colors = require("gruvbox.palette").get_base_colors(vim.o.background, config.contrast)
      vim.cmd('hi IlluminatedWordText guibg=' .. colors.bg1 .. ' gui=bold')
    end,
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
    init = function()
      vim.g.openbrowser_github_select_current_line = 1
      vim.keymap.set('n', '<Leader>gh', ':OpenGithubFile<CR>', opts)
    end,
  },
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/vim-vsnip',
    },
    config = function()
      local cmp = require('cmp')
      cmp.setup({
        snippet = {
          expand = function(args)
          vim.fn["vsnip#anonymous"](args.body)
          end,
        },
        mapping = {
          ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
          ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
          ['<C-n>'] = cmp.mapping(cmp.mapping.select_next_item(), {'i','c'}),
          ['<C-p>'] = cmp.mapping(cmp.mapping.select_prev_item(), {'i','c'}),
          ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
          ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
          ['<C-e>'] = cmp.mapping({
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
          }),
          ['<CR>'] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        },
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'vsnip' },
        }, {
          { name = 'buffer' },
        })
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
    },
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
          vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
          vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
          -- vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
          -- vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
          -- vim.keymap.set('n', '<space>wl', function()
          --   print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
          -- end, opts)
          vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
          vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
          vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
          vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
          vim.keymap.set('n', '<space>f', function()
            vim.lsp.buf.format { async = true }
          end, opts)
        end,
      })
      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      local lspconfig = require('lspconfig')
      local servers = {
        'bashls',
        'bufls',
        'docker_compose_language_service',
        'dockerls',
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
        'tsserver',
        'tsserver',
        'vuels',
        'yamlls',
      }
      for _, lsp in ipairs(servers) do
        lspconfig[lsp].setup {
          capabilities = capabilities,
        }
      end

      lspconfig.gopls.setup {
        capabilities = capabilities,
        settings = {
          gopls = {
            analyses = {
              composites = false,
            },
          },
        },
      }

      lspconfig.pyright.setup {
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
  },
  { 'ray-x/lsp_signature.nvim', config = true },
  {
    'nvim-treesitter/nvim-treesitter',
    opts = {
      ensure_installed = { "go", "hcl", "yaml", "python", "json", "lua" },
      sync_install = false,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      matchup = {
        enable = true,
      },
    },
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
    end,
  },
  {
    'folke/todo-comments.nvim',
    dependencies = { "nvim-lua/plenary.nvim" },
    config = true,
    init = function()
      vim.keymap.set('n', '<Leader>todo', ':TodoQuickFix<cr>', opts)
    end,
  },
  'AndrewRadev/splitjoin.vim',
  'junegunn/vim-peekaboo',
  'ntpeters/vim-better-whitespace',
  'andymass/vim-matchup',
  'previm/previm',
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
  -- 'lpinilla/vim-codepainter',
  -- 'tpope/vim-unimpaired',
  -- 'dhruvasagar/vim-table-mode',
  -- { 'sjl/gundo.vim', cmd = 'GundoToggle' },
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'lua',
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
vim.keymap.set('n', '<Leader>f', ':Neoformat<CR>', opts)
vim.keymap.set('n', '<Leader>md', ':PrevimOpen<CR>', opts)
vim.keymap.set('n', '<space>', 'za', opts)
vim.keymap.set('n', '<c-k>', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
vim.keymap.set('n', '<c-j>', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
vim.keymap.set('n', '<c-h>', ':LspRestart<CR>', opts)
vim.keymap.set('n', 'Q', '<nop>', opts)
vim.keymap.set('n', 'q:', '<nop>', opts)

vim.keymap.set('i', '<c-space>', '<c-x><c-o>', opts)

vim.g.omni_sql_no_default_maps = 1