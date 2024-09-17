vim.loader.enable()

vim.opt.encoding = 'utf8'
vim.scriptencoding = 'utf8'

-----------------------------------------------------------
-- Machine detection
-----------------------------------------------------------
if vim.fn.system({ 'sh', '-c', 'uname -r | grep -c microsoft' }) == 1 then
    local is_wsl = true
else
    local is_wsl = false
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
set_keymap('v', 'p', 'P', opts)
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
set_keymap('n', '<C-j>', ':bn<CR>', opts)
set_keymap('n', '<C-k>', ':bp<CR>', opts)

-- LSP 用の Keybindings
local lsp_keybindings = function(client, bufnr)
    local function set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local opts = { noremap = true, silent = true }
    set_keymap('n', 'gd', '<cmd>Lspsaga goto_definition<CR>', opts)
    set_keymap('n', 'gr', '<cmd>Lspsaga finder<CR>', opts)
    set_keymap('n', 'grn', '<cmd>Lspsaga rename<CR>', opts)
    set_keymap('n', 'gca', '<cmd>Lspsaga code_action<CR>', opts)
    set_keymap('n', 'gs', '<cmd>Lspsaga hover_doc<CR>', opts)
    set_keymap('n', 'gn', '<cmd>Lspsaga diagnostic_jump_next<CR>', opts)
    set_keymap('n', 'gp', '<cmd>Lspsaga diagnostic_jump_prev<CR>', opts)

    -- disable default diagnostic (virtual text)
    vim.diagnostic.config({ virtual_text = false })
    local diagnostic_status = 1
    local toggle_diagnostic = function()
        if diagnostic_status == 1 then
            diagnostic_status = 0
        else
            diagnostic_status = 1
        end
    end
    set_keymap('n', '<leader>l', '', {noremap = true, desc = 'Change Diagnostic View', callback = toggle_diagnostic})

    vim.api.nvim_create_augroup("lsp_diagnostics_hold", {})
    vim.api.nvim_create_autocmd('CursorHold', {
        group = "lsp_diagnostics_hold",
        desc = 'Open Diagnostic with Float',
        callback = function()
            if diagnostic_status == 1 then
                vim.diagnostic.open_float({ border = 'single', focusable = false })
            end
        end
    })
end


-----------------------------------------------------------
-- my command
-----------------------------------------------------------
-- カーソルが常に画面の中心になるようにする
vim.api.nvim_create_user_command('CenterCursorToggle', function()
    if vim.o.scrolloff == 999 then
        vim.opt.scrolloff = 0
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
    checker = { enabled = true },
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
        event = VeryLazy,
        priority = 1000,
        opts = {},
    },
    -----------------------------------------------------------
    -- status line
    -----------------------------------------------------------
    {
        -- lua 製 status line
        'nvim-lualine/lualine.nvim',
        event = 'VimEnter',
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
                lualine_z = { '%l/%L (%p%%)' }
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
        -- textwidth にあわせて線を引く
        'miyake13000/wrap-guide',
        command = {'WrapGuideEnable', 'WrapGuideToggle'},
    }, {
        -- quickfix-windows の見た目を改善
        'kevinhwang91/nvim-bqf',
        event = 'QuickFixCmdPre',
    }, {
        -- 囲まれている単語を調整
        'machakann/vim-sandwich',
        event = 'InsertEnter',
    }, {
        -- Rust フォーマッタ
        'rust-lang/rust.vim',
        ft = 'rust',
        config = function()
            -- Rust ファイルを保存時，自動で rustfmt にかける
            vim.g.rustfmt_autosave = 1
        end
    }, {
        -- 自動でインデント幅を設定する
        'timakro/vim-yadi',
        event = 'BufEnter',
        config = function()
            vim.cmd('DetectIndent')
        end
    }, {
        -- Whitespace を強調
        'ntpeters/vim-better-whitespace',
        event = 'BufEnter',
        config = function()
            vim.g.better_whitespace_filetypes_blacklist = {
                'toggleterm',
                'diff',
                'git',
                'gitcommit',
                'unite',
                'qf',
                'help',
                'markdown',
                'fugitive'
            }
            vim.api.nvim_set_hl(0, 'ExtraWhitespace', { bg = '#CF572D' })
        end
    }, {
        -- latex 用エコシステム
        'lervag/vimtex',
        ft = 'tex',
        config = function()
            -- tex ファイルコンパイル時に pdf を開くビューワー
            if is_wsl then
                vim.g.vimtex_view_general_viewer = 'sumatrapdf'
                vim.g.vimtex_view_general_options = '-reuse-instance @pdf'
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
    }, {
        -- Vim 内で Git を使えるようにする
        'tpope/vim-fugitive',
    },
    -----------------------------------------------------------
    -- lua plugins
    -----------------------------------------------------------
    {
        -- status line を非表示にして，通知形式でメッセージを表示する
        'folke/noice.nvim',
        event = 'VeryLazy',
        dependencies = {
            'MunifTanjim/nui.nvim',
            'rcarriga/nvim-notify',
        },
        opts = {
            lsp = {
                override = {
                    ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
                    ['vim.lsp.util.stylize_markdown'] = true,
                    ['cmp.entry.get_documentation'] = true,
                },
            },
            presets = {
                bottom_search = true,
                command_palette = true,
                long_message_to_split = true,
                inc_rename = false,
                lsp_doc_border = false,
            },
        },
    }, {
        -- インデントの可視化
        'lukas-reineke/indent-blankline.nvim',
        event = 'BufEnter',
        main = 'ibl',
        opts = { scope = { enabled = false } },
    }, {
        -- Insert mode から抜けると IME を無効にする
        'keaising/im-select.nvim',
        event = 'InsertEnter',
        cond = function()
            return vim.env.SSH_CLIENT == nil
        end,
        config = function()
            local opt = {}
            if is_wsl then
                opt['default_im_select'] = '1033'
                opt['default_command'] = 'im-select.exe'
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
        cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
        build = "cd app && yarn install",
        init = function()
            vim.g.mkdp_filetypes = { "markdown" }
        end,
    }, {
        -- カラーコードに色をつける
        'norcalli/nvim-colorizer.lua',
        lazy = false,
        config = function()
            require('colorizer').setup()
        end
    }, {
        -- TODO などを目立たせる
        'folke/todo-comments.nvim',
        event = 'UIEnter',
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
        event = 'BufEnter',
        opts = {
            signcolumn = false,
            numhl = true,
        }
    }, {
        -- 引数なしで起動すると起動画面を表示する
        'goolord/alpha-nvim',
        event = 'BufEnter',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()
            require('alpha').setup(require('alpha.themes.dashboard').config)
        end,
    }, {
        -- コードをハイライトする
        'nvim-treesitter/nvim-treesitter',
        event = 'BufEnter',
        build = ':TSUpdate',
        config = function()
            require('nvim-treesitter.configs').setup({
                highlight = { enable = true },
                matchup = { enable = true },
            })
        end
    }, {
        -- terminal の見た目をよくする
        'akinsho/toggleterm.nvim',
        keys = {
            { '<C-t>', '<CMD>ToggleTerm direction=float<CR>', mode = {'n', 'v', 'i'}, desc = 'ToggleTerm open float'},
            { '<leader>yt', '<CMD>ToggleTerm direction=horizontal size=10<CR>', mode = {'n', 'v'}, desc = 'ToggleTerm open float'},
            { '<leader>yy', '<CMD>ToggleTerm direction=vertical size=50<CR>', mode = {'n', 'v'}, desc = 'ToggleTerm open side'},
            {
                '<leader>g',
                '',
                desc = 'Open Lazygit',
                callback = function()
                    require('toggleterm.terminal').Terminal:new({ cmd = 'lazygit', direction = 'float' }):toggle()
                end
            }
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
        event = 'UIEnter',
        config = function()
            local neoscroll = require('neoscroll')
            local keymap = {
                ["<C-u>"] = function() neoscroll.ctrl_u({ duration = 75 }) end;
                ["<C-d>"] = function() neoscroll.ctrl_d({ duration = 75 }) end;
                ["<C-b>"] = function() neoscroll.ctrl_b({ duration = 150 }) end;
                ["<C-f>"] = function() neoscroll.ctrl_f({ duration = 150 }) end;
                ["zt"]    = function() neoscroll.zt({ half_win_duration = 75 }) end;
                ["zz"]    = function() neoscroll.zz({ half_win_duration = 75 }) end;
                ["zb"]    = function() neoscroll.zb({ half_win_duration = 75 }) end;
            }
            local modes = { 'n', 'v', 'x' }
            for key, func in pairs(keymap) do
              vim.keymap.set(modes, key, func)
            end
        end

    }, {
        -- comment out プラグイン
        'numToStr/Comment.nvim',
        event = 'InsertEnter',
        opts = {},
    }, {
        -- show macro status
        "chrisgrieser/nvim-recorder",
        dependencies = "rcarriga/nvim-notify",
        opts = {},
    }, {
        -- vim.ui.select を改善
        'stevearc/dressing.nvim',
        event = 'UIEnter',
        opts = {},
    }, {
        -- funny plugins
        'eandrju/cellular-automaton.nvim',
        cmd = 'CellularAutomaton',
    }, {
        -- f を高機能にする
        'smoka7/hop.nvim',
        event = 'UIEnter',
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
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        opts = {
            options = { separator_style = 'padded_slant' }
        },
    }, {
        -- 行番号をインクリメンタルに表示する
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
        -- Buffer を削除しても Window を閉じないようにする
        'ojroques/nvim-bufdel',
        keys = {
            { "<leader>q", "<cmd>BufDel<CR>", desc = "Buffer Delete" },
            { "<leader>w", "<cmd>BufDelOthers<CR>", desc = "Buffer Delete Others" },
            { "<leader>Q", "<cmd>BufDelAll<CR>", desc = "Buffer Delete All" },
        },
        opts = {
            next = 'tabs',
            quit = false,
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
        -- AI 補完
        "zbirenbaum/copilot.lua",
        event = InsertEnter,
        config = function()
            require("copilot").setup({
                -- needed by copilot-cmp
                suggestion = { enabled = false },
                panel = { enabled = false },
            })
        end,
    }, {
        -- copilot.lua の nvim-cmp ソース
        "zbirenbaum/copilot-cmp",
        event = InsertEnter,
        dependencies = {"zbirenbaum/copilot.lua"},
        event = InsertEnter,
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
                }),
                sources = cmp.config.sources({
                    { name = 'nvim_lsp' },
                    { name = 'vsnip' },
                    { name = 'path' },
                    { name = 'buffer',  keyword_length = 3 },
                    { name = 'copilot' },
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
    -- lsp plugins
    -----------------------------------------------------------
    {
        -- LSP のUI を改善する
        'nvimdev/lspsaga.nvim',
        dependencies = {
            'nvim-treesitter/nvim-treesitter',
            'nvim-tree/nvim-web-devicons',
        },
        event = 'LspAttach',
        opts = {
            ui = {
                code_action = ''
            },
            lightbulb = {
                virtual_text = false
            }
        },
    }, {
        -- LSP をユーザフレンドリーにセットアップする
        'williamboman/mason-lspconfig.nvim',
        lazy = false,
        dependencies = {
            'williamboman/mason.nvim',
            'neovim/nvim-lspconfig',
            'simrat39/rust-tools.nvim',
            "onsails/lspkind.nvim",
            'j-hui/fidget.nvim',
        },
        config = function()
            capabilities = require('cmp_nvim_lsp').default_capabilities()

            -- set keymap for lsp
            require('mason').setup({ ui = { border = 'single' } })
            require('mason-lspconfig').setup_handlers({
                function(server)
                    if server == 'rust_analyzer' then
                        require('rust-tools').setup({
                            server = {
                                capabilities = capabilities,
                                on_attach = lsp_keybindings,
                                settings = {
                                    ['rust-analyzer'] = {
                                        checkOnSave = {
                                            command = 'clippy'
                                        },
                                    }
                                },
                            },
                        })
                    else
                        require('lspconfig')[server].setup {
                            on_attach = lsp_keybindings,
                            capabilities = capabilities,
                        }
                    end
                end
            })
        end,
    }, {
        -- Flutter 用 統合開発環境
        'nvim-flutter/flutter-tools.nvim',
        ft = {'dart'},
        dependencies = {
            'nvim-lua/plenary.nvim',
            'stevearc/dressing.nvim',
        },
        opts = {
            lsp = {
                capabilities = capabilities,
                on_attach = lsp_keybindings,
            }
        },
    }, {
        -- LSP 対応外のツールを LS として使用できるようにする
        'nvimtools/none-ls.nvim',
        dependencies = {
            'nvim-lua/plenary.nvim',
        },
        opts = {}
    }, {
        -- LSP 対応外のツールを LS として使用できるようにする
        'jay-babu/mason-null-ls.nvim',
        event = { 'BufReadPre', 'BufNewFile' },
        dependencies = {
            'williamboman/mason.nvim',
            'nvimtools/none-ls.nvim',
        },
        opts = {
            automatic_installation = true,
            handlers = {},
        }
    },
    },
lazy_opt
)
