vim.loader.enable()

vim.opt.encoding = 'utf8'
vim.scriptencoding = 'utf8'

local s_obj = vim.system({'sh', '-c', 'uname -r | grep -q microsoft'})
local res = s_obj:wait(1000)
if res.code == 0 then
    IsWSL = true
else
    IsWSL = false
end

-----------------------------------------------------------
-- common options
-----------------------------------------------------------
vim.opt.termguicolors = true
-- sign column を常に1行表示する
vim.opt.signcolumn = 'yes:1'
-- fold を無効にする
vim.opt.foldenable = false
-- 常にステータスラインを表示する
vim.opt.laststatus = 3
-- swapファイルのディレクトリを変更
vim.opt.directory = vim.fn.stdpath('data') .. '/swp'
-- 保存せずにバッファを切り替えられる
vim.opt.hidden = true
-- 括弧の対応関係を一瞬表示する
vim.opt.showmatch = true
-- yank でクリップボードに入る
vim.opt.clipboard = 'unnamedplus'
-- UTF-8 で保存する
vim.opt.fileencoding = 'utf-8'
-- 読込み時に文字コードを自動で判別する(左優先)
vim.opt.fileencodings = 'ucs-boms,utf-8,euc-jp,cp932'
-- 改行コードの自動判別(左優先)
vim.opt.fileformats = 'unix,dos,mac'
-- 文字幅不明の文字に適応する文字幅
vim.opt.ambiwidth = 'single'
-- 保存するコマンド履歴の数
vim.opt.history = 5000
-- タブ入力を複数の空白入力に置き換える
vim.opt.expandtab = true
-- 改行時に前の行のインデントを継続する
vim.opt.autoindent = true
-- 改行時に前の行の構文をチェックし次の行のインデントを増減する
vim.opt.smartindent = true
-- tabを可視化
vim.opt.list = true
vim.opt.listchars = { tab = '<->' }
-- １文字入力毎に検索を行う
vim.opt.incsearch = true
-- 検索パターンに大文字小文字を区別しない
vim.opt.ignorecase = true
-- 検索パターンに大文字を含んでいたら大文字小文字を区別する
vim.opt.smartcase = true
-- 検索結果をハイライト
vim.opt.hlsearch = true
-- 行番号を表示
vim.opt.number = true
vim.opt.relativenumber = true
-- カーソルラインをハイライト
vim.opt.cursorline = true
-- バックスペースキーの有効化
vim.opt.backspace = 'indent,eol,start'
-- popup を透過する
vim.opt.pumblend = 10
-- マウスでカーソル移動とスクロール
vim.opt.mouse = 'a'
-- 画面上でタブ文字が占める幅
vim.opt.tabstop = 4
-- smartindentで増減する幅
vim.opt.shiftwidth = 4
-- 連続した空白に対してタブキーやバックスペースキーでカーソルが動く幅
vim.opt.softtabstop = 4
-- 新規ウィンドウを右/下に開く
vim.opt.splitbelow = true
vim.opt.splitright = true
-- CursorHold の時間
vim.opt.updatetime = 300
-- 矩形選択で行末以上に移動できる
vim.opt.virtualedit:append("block")
-- 画面の上下に常にxx行の余裕を持たせてスクロールする
vim.g.scrolloff_default = 10
vim.opt.scrolloff = vim.g.scrolloff_default

-- Tex の filetype を設定
vim.g.tex_flavor = 'latex'

-----------------------------------------------------------
-- non plugin keybindings
-----------------------------------------------------------
-- leader を space に割当
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

local function set_keymap(...)
    vim.api.nvim_set_keymap(...)
end
local opts = { noremap = true, silent = true }
-- jk でインサートモードを抜ける
set_keymap('i', 'jk', '<ESC>', opts)
-- ESC 2回でサーチのハイライトを消す
set_keymap('n', '<ESC><ESC>', '<CMD>nohlsearch<CR>', opts)
-- 行が折り返し表示されていた場合、行単位ではなく表示行単位でカーソルを移動する
set_keymap('n', 'j', 'gj', opts)
set_keymap('n', 'k', 'gk', opts)
-- 検索結果が画面中央に来るようにする
set_keymap('n', 'n', 'nzz', opts)
set_keymap('n', 'N', 'Nzz', opts)
-- カーソルが常に画面中央に来るようにする
set_keymap('n', 'zx', '<CMD>CenterCursorToggle<CR>zz', opts)
-- visual mode で paste しても register を更新しない
set_keymap("x", "p", [["_dP]], opts)
set_keymap('v', 'P', 'p', opts)
-- insert, command mode 中にカーソル移動する
set_keymap('i', '<C-h>', '<Left>', opts)
set_keymap('i', '<C-l>', '<Right>', opts)
set_keymap('c', '<C-h>', '<Left>', opts)
set_keymap('c', '<C-l>', '<Right>', opts)
-- BS, Del の remap
set_keymap('i', '<C-j>', '<BS>', opts)
set_keymap('i', '<C-k>', '<Del>', opts)
-- buffer の切替
set_keymap('n', '<C-h>', ':bn<CR>', opts)
set_keymap('n', '<C-l>', ':bp<CR>', opts)
-- window の切替
set_keymap('n', '<C-j>', '<C-w>W', opts)
set_keymap('n', '<C-k>', '<C-w>w', opts)
-- Windows を開く
set_keymap('n', '<leader>s', ':split<CR>', opts)
set_keymap('n', '<leader>v', ':vsplit<CR>', opts)
-- Windows を閉じる
set_keymap('n', '<leader>q', '<C-w>q', opts)

-- LSP 用の Keybindings
local lsp_keybindings = function(client, bufnr)
    local opts_lsp = { noremap = true, silent = true }
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = bufnr, silent = true, desc = 'LSP: go to definition' })
    vim.keymap.set('n', 'grr', vim.lsp.buf.references, { buffer = bufnr, silent = true, desc = 'LSP: references' })
    vim.keymap.set('n', 'grn', vim.lsp.buf.rename, { buffer = bufnr, silent = true, desc = 'LSP: rename' })
    vim.keymap.set({ 'n', 'v' }, 'gra', vim.lsp.buf.code_action, { buffer = bufnr, silent = true, desc = 'LSP: code action' })
    vim.keymap.set('n', 'gs', vim.lsp.buf.hover, { buffer = bufnr, silent = true, desc = 'LSP: hover' })
    vim.keymap.set('n', 'g]', function()
      vim.diagnostic.jump({ count = 1, float = true })
    end, { buffer = bufnr, silent = true, desc = 'Diagnostic: next' })
    vim.keymap.set('n', 'g[', function()
      vim.diagnostic.jump({ count = -1, float = true })
    end, { buffer = bufnr, silent = true, desc = 'Diagnostic: previous' })
end


-----------------------------------------------------------
-- my command
-----------------------------------------------------------
-- カーソルが常に画面の中心になるようにする
vim.api.nvim_create_user_command('CenterCursorToggle', function()
    if vim.o.scrolloff == 999 then
        vim.opt.scrolloff = vim.g.scrolloff_default
    else
        vim.opt.scrolloff = 999
    end
end, {})

-- ファイルを開いたときに最後に編集していたときの位置に戻す
vim.api.nvim_create_autocmd('BufRead', {
    callback = function(opts)
        vim.api.nvim_create_autocmd('BufWinEnter', {
            once = true,
            buffer = opts.buf,
            callback = function()
                local ft = vim.bo[opts.buf].filetype
                local last_known_line = vim.api.nvim_buf_get_mark(opts.buf, '"')[1]
                if
                    not (ft:match('commit') and ft:match('rebase'))
                    and last_known_line > 1
                    and last_known_line <= vim.api.nvim_buf_line_count(opts.buf)
                then
                    vim.api.nvim_feedkeys([[g`"]], 'nx', false)
                end
            end,
        })
    end,
})


-----------------------------------------------------------
-- plugin settings
-----------------------------------------------------------
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        'git',
        'clone',
        '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git',
        '--branch=stable',
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)


-----------------------------------------------------------
-- lazy setting
-----------------------------------------------------------
local lazy_opt = {
    ui = { border = 'single' },
    checker = {
        enabled = true,
        notify = false,
    },
}

require('lazy').setup({
    -----------------------------------------------------------
    -- colorscheme
    -----------------------------------------------------------
    {
        -- colorscheme
        'olimorris/onedarkpro.nvim',
        lazy = false,
        priority = 1000,
        config = function()
            require('onedarkpro').setup({
                colors = {
                    fg = '#f0f0f0',
                    bg = '#101010',
                },
            })
            vim.cmd("colorscheme onedark_dark")
            vim.api.nvim_set_hl(0, "@punctuation.special.latex", { link = 'Special' })

            -- Darkmode と Lightmode を入れ替える
            local is_dark = true
            vim.api.nvim_create_user_command(
                'ColorSchemeToggle',
                function()
                    if is_dark then
                        vim.cmd('colorscheme tokyonight-day')
                        is_dark = false
                    else
                        vim.cmd('colorscheme onedark_dark')
                        is_dark = true
                    end
                end,
                {}
            )
        end
    }, {
        -- light mode 用 colorscheme
        "folke/tokyonight.nvim",
        event = 'BufEnter',
        priority = 1000,
        cmd = { 'ColorSchemeToggle' },
        opts = {},
    },
    -----------------------------------------------------------
    -- status line
    -----------------------------------------------------------
    {
        -- lua 製 status line
        'nvim-lualine/lualine.nvim',
        lazy = false,
        dependencies = {
            'nvim-tree/nvim-web-devicons'
        },
        config = function()
            local my_sections = {
                lualine_a = { 'filename' },
                lualine_b = { 'branch', 'diff', 'diagnostics' },
                lualine_c = {
                    {
                        'filename',
                        file_status = false,
                        path = 3,
                    },
                    'selectioncount',
                },
                lualine_x = { {
                    require('lazy.status').updates,
                    cond = require('lazy.status').has_updates,
                } },
                lualine_y = { 'encoding', 'fileformat', 'filetype' },
                lualine_z = { '%l/%L:%c (%p%%)' }
            }
            require('lualine').setup({
                sections = my_sections,
            })
        end
    },
    -----------------------------------------------------------
    -- non lua plugins
    -----------------------------------------------------------
    {
        -- 囲い文字をテキストオブジェクトとして扱う
        'machakann/vim-sandwich',
        event = 'VeryLazy',
    }, {
        -- 自動でインデント幅を設定する
        'timakro/vim-yadi',
        event = 'VeryLazy',
        config = function()
            vim.cmd('DetectIndent')
        end
    }, {
        -- Whitespace を強調
        'ntpeters/vim-better-whitespace',
        event = 'VeryLazy',
        config = function()
            vim.g.better_whitespace_filetypes_blacklist = {
                'toggleterm', 'diff', 'qf', 'help', 'snacks_dashboard'
            }
            vim.api.nvim_set_hl(0, 'ExtraWhitespace', { bg = '#CF572D' })
        end
    }, {
        -- latex 用エコシステム
        'lervag/vimtex',
        ft = 'tex',
        event = 'VeryLazy',
        config = function()
            -- tex ファイルコンパイル時に pdf を開くビューワー
            if IsWSL then
                -- vim.g.vimtex_view_general_viewer = 'sumatrapdf'
                -- vim.g.vimtex_view_general_options = '-reuse-instance -forward-search @tex @line @pdf'
                vim.g.vimtex_view_general_viewer = 'wsl-open'
            else
                vim.g.vimtex_view_method = 'zathura'
            end
            -- tex ファイルをコンパイルするコマンド
            vim.g.vimtex_compiler_method = 'generic'
            vim.g.vimtex_compiler_generic = { command = 'make all' }
            -- VimTex のハイライトを無効にする
            vim.g.vimtex_syntax_enabled = 0
        end
    }, {
        -- スニペット
        'hrsh7th/vim-vsnip',
        event = 'InsertEnter',
        dependencies = {
            'hrsh7th/vim-vsnip-integ',
            'rafamadriz/friendly-snippets'
        },
        config = function()
            -- スニペットの保存先
            vim.g.vsnip_snippet_dir = vim.fn.stdpath('data') .. '/snip'
        end
    },
    -----------------------------------------------------------
    -- lua plugins
    -----------------------------------------------------------
    {
        -- Insert mode から抜けると IME を無効にする
        'keaising/im-select.nvim',
        event = 'InsertEnter',
        cond = function()
            return vim.env.SSH_CLIENT == nil
        end,
        config = function()
            local opt = {}
            if IsWSL then
                opt['default_im_select'] = '0'
                opt['default_command'] = 'spzenhan.exe'
            else
                opt['default_im_select'] = 'keyboard-jp'
                opt['default_command'] = 'fcitx5-remote'
            end
            require('im_select').setup(opt)
        end,
    }, {
        -- 括弧の補完
        'hrsh7th/nvim-insx',
        event = 'InsertEnter',
        config = function()
            require('insx.preset.standard').setup()
        end
    }, {
        -- markdown のプレビューを表示する
        'iamcco/markdown-preview.nvim',
        cmd = { 'MarkdownPreview' },
        ft = 'markdown',
        build = "cd app && yarn install",
        init = function()
            vim.g.mkdp_filetypes = { "markdown" }
        end,
    }, {
        -- カラーコードに色をつける
        "catgoose/nvim-colorizer.lua",
        event = { "BufReadPre", "BufNewFile" },
        opts = {},
    }, {
        -- TODO などを目立たせる
        'folke/todo-comments.nvim',
        event = { 'BufReadPre', 'BufNewFile' },
        dependencies = { 'nvim-lua/plenary.nvim' },
        opts = {},
    }, {
        -- タイムアウトするとマッピング一覧を表示する
        'folke/which-key.nvim',
        event = 'VeryLazy',
        config = function()
            require('which-key').setup()
            vim.o.timeout = true
            vim.o.timeoutlen = 1000
        end,
    }, {
        -- Git の状態を表示
        'lewis6991/gitsigns.nvim',
        event = 'VeryLazy',
        opts = {
            signcolumn = false,
            numhl = true,
        }
    }, {
        -- 構文解析ツールを管理
        "romus204/tree-sitter-manager.nvim",
        dependencies = {}, -- tree-sitter CLI must be installed system-wide
	branch = 'develop',
	config = function()
            require("tree-sitter-manager").setup()
        end,
    }, {
        -- terminal の見た目をよくする
        'akinsho/toggleterm.nvim',
        keys = {
            { '<C-t>',
              '<CMD>ToggleTerm direction=float<CR>',
              mode = {'n', 'v', 'i'},
              desc = 'ToggleTerm open float' },
            { '<leader>yt',
              '<CMD>ToggleTerm direction=horizontal size=10<CR>',
              mode = {'n', 'v'},
              desc = 'ToggleTerm open float' },
            { '<leader>yy',
              '<CMD>ToggleTerm direction=vertical size=50<CR>',
              mode = {'n', 'v'},
              desc = 'ToggleTerm open side' },
        },
        config = function()
            require('toggleterm').setup()
            -- Terminal 内でも <ESC> を使えるようにする
            vim.api.nvim_create_autocmd('TermOpen', {
                pattern = { 'term://*' },
                callback = function()
                    vim.api.nvim_buf_set_keymap(0, 't', '<ESC>', [[<C-\><C-n>]], { noremap = true, silent = true })
                end
            })
        end
    }, {
        -- スクロールをスムーズにする
        'karb94/neoscroll.nvim',
        event = 'VeryLazy',
        opts = {
            mappings = { '<C-u>', '<C-d>', '<C-b>', '<C-f>', '<C-y>', '<C-e>', 'zt', 'zz', 'zb', },
            duration_multiplier = 0.5,   -- Global duration multiplier
        },
    }, {
        -- comment out プラグイン
        'numToStr/Comment.nvim',
        event = 'VeryLazy',
        opts = {},
    }, {
        -- show macro status
        "chrisgrieser/nvim-recorder",
        event = 'VeryLazy',
        dependencies = "rcarriga/nvim-notify",
        opts = {},
    }, {
        -- vim.ui.select を改善
        'stevearc/dressing.nvim',
        event = 'VeryLazy',
        opts = {},
    }, {
        -- funny plugins
        'eandrju/cellular-automaton.nvim',
        cmd = 'CellularAutomaton',
    }, {
        -- f を高機能にする
        'smoka7/hop.nvim',
        event = 'VeryLazy',
        config = function()
            local hop = require('hop')
            local directions = require('hop.hint').HintDirection
            vim.keymap.set('', 'f',
            function() hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true }) end,
            { remap = true })
            vim.keymap.set('', 'F',
            function() hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true }) end,
            { remap = true })
            vim.keymap.set('', 't',
            function() hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = false }) end,
            { remap = true })
            vim.keymap.set('', 'T',
            function() hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = false }) end,
            { remap = true })
            hop.setup()
        end,
    }, {
        -- buffer line プラグイン
        'akinsho/bufferline.nvim',
        event = 'VimEnter',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        opts = {
            options = { separator_style = 'padded_slant' }
        },
    }, {
        -- 行番号を打つと peek する
        'nacro90/numb.nvim',
        event = 'VeryLazy',
        opts = {},
    }, {
        -- Git Diff を 2 side で表示する
        'sindrets/diffview.nvim',
        event = 'VeryLazy',
    }, {
        -- vim 上で翻訳する
        'uga-rosa/translate.nvim',
        opts = {},
        keys = {
            { '<leader>t', ':Translate ja -output=floating<CR>', mode = { 'n', 'v' }, desc = 'Translate', silent = true }
        },
    }, {
        -- ファイラ
        'nvim-tree/nvim-tree.lua',
        keys = {
            { "<leader>o", "<cmd>NvimTreeToggle<CR>", desc = "NvimTreeToggle" },
        },
        opts = {},
    }, {
        -- Markdown ファイルの見た目を豪華に
        'MeanderingProgrammer/render-markdown.nvim',
        event = { 'BufReadPre', 'BufNewFile' },
        opts = {
            file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
    }, {
        -- Lazygit を vim 上で使う
        "kdheepak/lazygit.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        keys = {
            { "<leader>g", "<cmd>LazyGit<cr>", desc = "LazyGit" }
        },
    }, {
        -- Swagger File を可視化する
        "vinnymeller/swagger-preview.nvim",
        file_types = { "yaml" },
        cmd = { "SwaggerPreview", "SwaggerPreviewStop", "SwaggerPreviewToggle" },
        build = "npm i",
        opts = {},
    }, {
        -- Buffer を削除しても Window を閉じないようにする
        'ojroques/nvim-bufdel',
        keys = {
            { "<leader>w", "<cmd>BufDel<CR>", desc = "Buffer Delete" },
        },
        opts = {
            next = 'tabs',
            quit = false,
        },
    }, {
        -- インデントガイドを表示
    --     "lukas-reineke/indent-blankline.nvim",
    --     main = "ibl",
    --     opts = {},
    -- }, {
        -- utility plugin
        "folke/snacks.nvim",
        lazy = false,
        opts = {
            dashboard = { enabled = true },
            bigfile = { enabled = true },
            quickfile = { enabled = true },
            scratch = { enabled = true },
            styles = {
                scratch = {
                    width = 200,
                    height = 50,
                }
            },
            indent = { enabled = true },
            scope = { enabled = true },

            input = { enabled = false },
            notifier = { enabled = false },
            scroll = { enabled = false },
            statuscolumn = { enabled = false },
            words = { enabled = true },
            picker = { enabled = false },
            explorer = { enabled = false },
        },
        keys = {
            -- Other
            { "<leader>.",  function() Snacks.scratch() end, desc = "Toggle Scratch Buffer" },
            { "<leader>S",  function() Snacks.scratch.select() end, desc = "Select Scratch Buffer" },
            { "<leader>n",  function() Snacks.notifier.show_history() end, desc = "Notification History" },
            { "<leader>un", function() Snacks.notifier.hide() end, desc = "Dismiss All Notifications" },
        },
        init = function()
            vim.api.nvim_create_autocmd("User", {
                pattern = "VeryLazy",
                callback = function()
                    -- Setup some globals for debugging (lazy-loaded)
                    _G.dd = function(...)
                        Snacks.debug.inspect(...)
                    end
                    _G.bt = function()
                        Snacks.debug.backtrace()
                    end

                    -- Override print to use snacks for `:=` command
                    if vim.fn.has("nvim-0.11") == 1 then
                        vim.print = function(_, ...)
                            dd(...)
                        end
                    else
                        vim.print = _G.dd
                    end

                    -- Create some toggle mappings
                    Snacks.toggle.diagnostics():map("<leader>ud")
                    Snacks.toggle.inlay_hints():map("<leader>uh")
                end,
            })
        end,
    }, {
        "monaqa/dial.nvim",
        keys = {
            { "<C-a>", function() return require("dial.map").inc_normal() end, desc = "Increment", expr = true, mode = { "n", "x" } },
            { "<C-s>", function() return require("dial.map").dec_normal() end, desc = "Decrement", expr = true, mode = { "n", "x" } },
            { "g<C-a>", function() return require("dial.map").inc_gnormal() end, desc = "Increment (visual)", expr = true, mode = { "n", "x" } },
            { "g<C-s>", function() return require("dial.map").dec_gnormal() end, desc = "Decrement (visual)", expr = true, mode = { "n", "x" } },
        },
        config = function()
            local augend = require("dial.augend")
            require("dial.config").augends:register_group{
                default = {
                    augend.integer.alias.decimal,
                    augend.integer.alias.hex,
                    augend.date.alias["%Y/%m/%d"],
                    augend.date.alias["%H:%M:%S"],
                    augend.constant.alias.alpha,
                    augend.constant.alias.Alpha,
                    augend.constant.alias.bool,
                    augend.semver.alias.semver,
                },
            }
        end
    },
    -----------------------------------------------------------
    -- AI Boost
    -----------------------------------------------------------
    {
        -- AI 補完
        "zbirenbaum/copilot.lua",
        event = 'InsertEnter',
        config = function()
            require("copilot").setup({
                -- needed by copilot-cmp
                suggestion = { enabled = false },
                panel = { enabled = false },
            })
        end,
    }, {
        "yetone/avante.nvim",
        -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
        -- ⚠️ must add this setting! ! !
        build = vim.fn.has("win32") ~= 0
        and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
        or "make",
        event = "VeryLazy",
        version = false, -- Never set this value to "*"! Never!
        ---@module 'avante'
        ---@type avante.Config
        opts = {
            provider = "codex",
            acp_providers = {
                ["codex"] = {
                    command = "codex-acp",
                    args = {},
                    env = {
                        NODE_NO_WARNINGS = "1",
                        OPENAI_API_KEY = os.getenv("OPENAI_API_KEY"),
                    },
                },
            },
        },
        dependencies = {
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
        },
    },
    -----------------------------------------------------------
    -- Telescope plugin
    -----------------------------------------------------------
    {
        -- ファジーファインダー
        'nvim-telescope/telescope.nvim',
        cmd = 'Telescope',
        dependencies = { 'nvim-lua/plenary.nvim' },
        keys = {
            { '<leader>ff', '<CMD>Telescope find_files<CR>', desc = 'Telescope find files'},
            { '<leader>fg', '<CMD>Telescope live_grep<CR>', desc = 'Telescope live grep'},
        },
    },
    -----------------------------------------------------------
    -- completion plugins
    -----------------------------------------------------------
    {
        -- copilot.lua の nvim-cmp ソース
        "zbirenbaum/copilot-cmp",
        event = 'InsertEnter',
        dependencies = {"zbirenbaum/copilot.lua"},
        config = function()
            require("copilot_cmp").setup()
        end
    }, {
        -- Completion
        'hrsh7th/nvim-cmp',
        event = {'InsertEnter', 'CmdlineEnter'},
        dependencies = {
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-cmdline',
            'hrsh7th/cmp-vsnip',
            'hrsh7th/cmp-calc',
            'hrsh7th/vim-vsnip',
            'zbirenbaum/copilot-cmp',
            "onsails/lspkind.nvim",
        },
        config = function()
            vim.opt.completeopt = 'menu,menuone,noselect'
            local cmp = require('cmp')
            local feedkey = function(key, mode)
                vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
            end
            local has_words_before = function()
                unpack = unpack or table.unpack
                local line, col = unpack(vim.api.nvim_win_get_cursor(0))
                return col ~= 0 and
                vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
            end

            cmp.setup({
                snippet = {
                    expand = function(args)
                        vim.fn['vsnip#anonymous'](args.body)
                    end,
                },
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                },
                mapping = cmp.mapping.preset.insert({
                    ["<Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif vim.fn["vsnip#available"](1) == 1 then
                            feedkey("<Plug>(vsnip-expand-or-jump)", "")
                        elseif has_words_before() then
                            cmp.complete()
                        else
                            fallback()
                        end
                    end, { 'i', 's' }),
                    ["<S-Tab>"] = cmp.mapping(function()
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif vim.fn["vsnip#jumpable"](-1) == 1 then
                            feedkey("<Plug>(vsnip-jump-prev)", "")
                        end
                    end, { "i", "s" }),
                    ['<C-s>'] = cmp.mapping.complete(),
                    ['<C-c>'] = cmp.mapping.abort(),
                    ["<CR>"] = cmp.mapping({
                        i = function(fallback)
                            if cmp.visible() and cmp.get_active_entry() then
                                cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
                            else
                                fallback()
                            end
                        end,
                        s = cmp.mapping.confirm({ select = true }),
                        c = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false }),
                    }),
                    ["<S-CR>"] = cmp.mapping({
                        i = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
                        s = cmp.mapping.confirm({ select = true }),
                        c = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
                    }),
                }),
                sources = cmp.config.sources({
                    { name = 'nvim_lsp' },
                    { name = 'vsnip' },
                    { name = 'path' },
                    { name = 'buffer',  keyword_length = 3 },
                    { name = 'copilot' },
                    { name = 'calc' },
                    { name = "lazydev", group_index = 0 },
                }),
                formatting = {
                    fields = { "kind", "abbr", "menu" },
                    format = function(entry, vim_item)
                        local kind = require("lspkind").cmp_format({ mode = "symbol_text", maxwidth = 50 })(entry, vim_item)
                        local strings = vim.split(kind.kind, "%s", { trimempty = true })
                        kind.kind = " " .. (strings[1] or "") .. " "
                        kind.menu = "    (" .. (strings[2] or "") .. ")"

                        return kind
                    end,
                },
            })

            cmp.setup.cmdline('/', {
                mapping = cmp.mapping.preset.cmdline(),
                sources = {
                    { name = 'buffer' }
                }
            })

            cmp.setup.cmdline(':', {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    { name = 'path' },
                    { name = 'cmdline' }
                })
            })
        end
    },
    -----------------------------------------------------------
    -- Adapter Plugins
    -----------------------------------------------------------
    {
        -- LSP 用のデータセット
        'neovim/nvim-lspconfig',
        lazy = false,
    }, {
        -- LSP のセットアップ状態を表示する
        'j-hui/fidget.nvim',
        lazy = false,
        opts = {},
    }, {
        -- LSP ツールをインストール&セットアップ
        'mason-org/mason.nvim',
        lazy = false,
        opts = { ui = { border = 'single' } }
    }, {
        -- Mason と LSPConfig を連携させる
        'mason-org/mason-lspconfig.nvim',
        dependencies = {
            'mason-org/mason.nvim',
            'neovim/nvim-lspconfig',
        },
        lazy = false,
        opts = {
            automatic_enable = {
                exclude = {
                    "rust_analyzer",
                }
            },
        },
    }, {
        -- Rust 用 LSP
        'mrcjkb/rustaceanvim',
        ft = {'rust'},
        lazy = false,
    }, {
        -- Flutter 用統合開発環境
        'nvim-flutter/flutter-tools.nvim',
        event = {'BufReadPre', 'BufNewFile'},
        ft = {'dart'},
        dependencies = {
            'nvim-lua/plenary.nvim',
            'stevearc/dressing.nvim',
        },
        opts = {},
    }, {
        -- init.lua 用 LSP
        "folke/lazydev.nvim",
        ft = "lua",
        opts = {
          library = {
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
          },
        },
    }, {
        -- formatter を設定
        "stevearc/conform.nvim",
        event = {'BufReadPre', 'BufNewFile'},
        config = function()
            require("conform").setup({
                formatters_by_ft = {
                    lua = { "stylua" },
                    python = { "ruff_format" },
                    rust = { "rustfmt" },

                    javascript = { "prettier" },
                    typescript = { "prettier" },
                    javascriptreact = { "prettier" },
                    typescriptreact = { "prettier" },
                    json = { "prettier" },
                    yaml = { "prettier" },
                    markdown = { "prettier" },

                    sh = { "shfmt" },
                },

                -- save 時に自動でフォーマットする
                format_on_save = function(bufnr)
                    if not vim.b[bufnr].format_on_save_enabled then
                        return
                    end

                    return {
                        timeout_ms = 500,
                        lsp_format = "fallback",
                    }
                end,
            })

            -- format コマンド
            vim.api.nvim_create_user_command(
                "Format",
                    function()
                        require("conform").format({
                            async = true,
                            lsp_format = "fallback",
                        })
                    end,
                { desc = "Format current buffer", }
            )

            vim.keymap.set("n", "<leader>f", "<cmd>Format<CR>", {
                desc = "Format current buffer",
            })

            -- format on save を切り替えるコマンド
            vim.api.nvim_create_user_command("FormatOnSaveToggle", function()
                vim.b.format_on_save_enabled = not vim.b.format_on_save_enabled

                vim.notify(
                    "Format on save: "
                    .. (vim.b.format_on_save_enabled and "enabled" or "disabled")
                    .. " for current buffer"
                )
            end, { desc = "Toggle format on save for current buffer", })

            vim.keymap.set("n", "<leader>tf", "<cmd>FormatOnSaveToggle<CR>", {
                desc = "Toggle format on save",
            })

        end
    }
    },
lazy_opt
)


-----------------------------------------------------------
-- LSP Settings
-----------------------------------------------------------

vim.lsp.config('*', {
    capabilities = require('cmp_nvim_lsp').default_capabilities(),
})

-- 型情報を補足する
vim.lsp.inlay_hint.enable()
vim.api.nvim_create_user_command('InlayHintToggle', function()
    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
    vim.notify(string.format("Inlay Hint: %s", vim.lsp.inlay_hint.is_enabled()))
end, {})

-- diagnostic の行末→非表示，フロート表示→ボーダー付表示
vim.diagnostic.config({
  virtual_text = false,
  float = {
    border = "single",
    focusable = false,
  },
})

-- diagnostic のフロート表示をカーソル位置に追従させる
vim.g.show_diagnostics = true
vim.api.nvim_create_autocmd("CursorHold", {
  group = vim.api.nvim_create_augroup("DiagnosticsFloat", { clear = true }),
  callback = function()
    if vim.g.show_diagnostics then
      vim.diagnostic.open_float(nil, {
        border = "single",
        focusable = false,
      })
    end
  end,
})

-- diagnostic のフロート表示を切り替えるコマンド
vim.keymap.set("n", "<leader>d", function()
  vim.g.show_diagnostics = not vim.g.show_diagnostics
  vim.notify(string.format("Show Diagnostic: %s", vim.g.show_diagnostics))
end, {
  desc = "Toggle diagnostic float",
})

-- LSP がアタッチされたときに keybindings を設定
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('LspAttachSettings', {}),
    callback = function(args)
        local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
        local bufnr = args.buf

        lsp_keybindings(client, bufnr)
    end,
})
