set encoding=utf-8
scriptencoding utf-8
set termguicolors

if system("uname -r | grep -c microsoft") == 1
    let g:is_wsl = 1
else
    let g:is_wsl = 0
end

"----------------------------------------------------------
" vim-plug
"----------------------------------------------------------

if &compatible
  set nocompatible
endif

filetype off

if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
    echo "install vim-plug..."
    call system("curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim")
    source $HOME/.local/share/nvim/site/autoload/plug.vim
endif

call plug#begin('~/.vim/bundle')

" 通知をリッチにする
Plug 'folke/noice.nvim'
" Diagnostic を行下に表示する
Plug 'ErichDonGubler/lsp_lines.nvim'
" textwidth にあわせて線を引く
Plug 'miyake13000/wrap-guide'
" インデントの可視化
Plug 'lukas-reineke/indent-blankline.nvim'
" 末尾の全角半角空白文字を赤くハイライト
Plug 'ntpeters/vim-better-whitespace'
" Status line for lua
Plug 'nvim-lualine/lualine.nvim'
" colorscheme
Plug 'folke/tokyonight.nvim'
" for showing powerline icon
Plug 'ryanoasis/vim-devicons'
" 括弧の補完
Plug 'windwp/nvim-autopairs'
" 日本語改行時の禁則処理
Plug 'vim-jp/autofmt'
" Rust フォーマッタ
Plug 'rust-lang/rust.vim'
" markdown の機能を追加する
Plug 'godlygeek/tabular'
Plug 'preservim/vim-markdown'
" markdown のプレビューを表示する
Plug 'iamcco/markdown-preview.nvim', {'do': 'cd app && yarn install'}
" disable IME when leave insert mode
Plug 'kaz399/spzenhan.vim'
" command を非同期に実行
Plug 'skywind3000/asyncrun.vim'
" カラーコードに色をつける
Plug 'norcalli/nvim-colorizer.lua'
" TODO などを目立たせる
Plug 'folke/todo-comments.nvim'
" fで一発移動できる文字をハイライト
Plug 'unblevable/quick-scope'
" *でカーソルを移動しなくする
Plug 'haya14busa/vim-asterisk'
" バッファを削除してもウィンドウが消えなくなる
Plug 'famiu/bufdelete.nvim'
" マッピング一覧を表示する
Plug 'folke/which-key.nvim'
" quickfix-windows の見た目を改善
Plug 'kevinhwang91/nvim-bqf'
" Git の状態を表示
Plug 'lewis6991/gitsigns.nvim'
" 選択したコードを画像にする "https://github.com/Aloxaf/silicon"
Plug 'segeljakt/vim-silicon'
" アイコンセット
Plug 'kyazdani42/nvim-web-devicons'
" 引数なしで起動すると起動画面を表示する
Plug  'goolord/alpha-nvim'
" スニペット
Plug 'hrsh7th/vim-vsnip'
" サンプルスニペット
Plug 'rafamadriz/friendly-snippets'
" コードをハイライトする
Plug 'nvim-treesitter/nvim-treesitter'
" treesitter デバッグ用
Plug 'nvim-treesitter/playground'
" treesitter のインデントを修正する
Plug 'yioneko/nvim-yati'
" ripgrep
Plug 'BurntSushi/ripgrep'
" ファジーファインダー
Plug 'nvim-telescope/telescope.nvim'
" org-mode
Plug 'nvim-orgmode/orgmode'
" 囲まれている単語を調整
Plug 'machakann/vim-sandwich'
" terminal の見た目をよくする
Plug 'akinsho/toggleterm.nvim'
" ポップアップ通知を出す
Plug 'rcarriga/nvim-notify'
" スクロールをスムーズにする
Plug 'karb94/neoscroll.nvim'
" vim 上で翻訳する
Plug 'voldikss/vim-translator'
" comment out プラグイン
Plug 'numToStr/Comment.nvim'
" 括弧マッチ
Plug 'andymass/vim-matchup'
" latex 用エコシステム
Plug 'lervag/vimtex'
" spell checker
Plug 'lewis6991/spellsitter.nvim'
" 自動でインデント幅を設定する
Plug 'timakro/vim-yadi'
" URL を開く
Plug 'axieax/urlview.nvim'
" セッションを保存する
Plug 'Shatur/neovim-session-manager'
" vim.ui.select を改善
Plug 'stevearc/dressing.nvim'

" funny plugins
Plug 'eandrju/cellular-automaton.nvim'

" LSP 関連
" build-in LSP のインタフェースを提供する
Plug 'neovim/nvim-lspconfig'
" LSP をインストール，セットアップする
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
" rust_analyzer のラッパーLSP
Plug 'simrat39/rust-tools.nvim'
" LSP 用の colorscheme
Plug 'folke/lsp-colors.nvim'
" LSP 対応外のツールを LS として使用できるようにする
Plug 'jose-elias-alvarez/null-ls.nvim'
" null-ls を mason に対応させる
Plug 'jayp0521/mason-null-ls.nvim'
" LSP のUI を改善する
Plug 'nvimdev/lspsaga.nvim'

" lua 用 plugin
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'mfussenegger/nvim-dap'
Plug 'rktjmp/lush.nvim'
Plug 'MunifTanjim/nui.nvim'

" Completion
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-cmdline'

call plug#end()


" lua 製の bundle を setup する
lua <<EOT
require('alpha').setup(require'alpha.themes.dashboard'.config)
require('colorizer').setup()
require('todo-comments').setup({})
require('toggleterm').setup({})
require('nvim-treesitter.configs').setup({yati = { enable = true }})
require('notify').setup()
require('neoscroll').setup()
require('Comment').setup()
require('orgmode').setup_ts_grammar()
require('orgmode').setup()
require('spellsitter').setup()
require('null-ls').setup()
require('mason-null-ls').setup()
require('session_manager').setup({ autoload_mode = require('session_manager.config').AutoloadMode.Disabled })
require('dressing').setup()
require('lsp_lines').setup()
require('urlview').setup()
require('which-key').setup()
EOT

"----------------------------------------------------------
" some settings
"----------------------------------------------------------
" ファイルタイプ別のVimプラグイン/インデントを有効にする
filetype plugin indent on
" sign column を常に表示する
set signcolumn=yes:1
" fold を無効にする
set nofoldenable
" 常にステータスラインを表示する
set laststatus=2
" swapファイルのディレクトリを変更
set directory=~/.vim/swp
" 保存せずにバッファを切り替えられる
set hidden
" 括弧の対応関係を一瞬表示する
set showmatch
" yank でクリップボードに入る
set clipboard&
set clipboard^=unnamedplus
" UTF-8 で保存する
set fileencoding=utf-8
" 読込み時に文字コードを自動で判別する(左優先)
set fileencodings=ucs-boms,utf-8,euc-jp,cp932
" 改行コードの自動判別(左優先)
set fileformats=unix,dos,mac
" 文字幅不明の文字に適応する文字幅
set ambiwidth=single
" timeout の時間を設定
set timeout
set ttimeout
set timeoutlen=300
set ttimeoutlen=50
" 補完失敗時に音を鳴らさない
set t_vb=
" コマンドモードの補完
" set wildmenu
" 保存するコマンド履歴の数
set history=5000
" タブ入力を複数の空白入力に置き換える
set expandtab
" 改行時に前の行のインデントを継続する
set autoindent
" 改行時に前の行の構文をチェックし次の行のインデントを増減する
set smartindent
" tabを可視化
set list listchars=tab:<->
" １文字入力毎に検索を行う
set incsearch
" 検索パターンに大文字小文字を区別しない
set ignorecase
" 検索パターンに大文字を含んでいたら大文字小文字を区別する
set smartcase
" 検索結果をハイライト
set hlsearch
" 行番号を表示
set number
set relativenumber
" カーソルラインをハイライト
set cursorline
" バックスペースキーの有効化
set backspace=indent,eol,start
" popup を透過する
set pumblend=10
" mode を表示しない
set noshowmode
" マウスでカーソル移動とスクロール
set mouse=a
" 画面上でタブ文字が占める幅
set tabstop=4
" smartindentで増減する幅
set shiftwidth=4
" 連続した空白に対してタブキーやバックスペースキーでカーソルが動く幅
set softtabstop=4
" 新規ウィンドウを右/下に開く
set splitbelow
set splitright
" CursorHold のタイミング
set updatetime=300


" スニペットの保存先
let g:vsnip_snippet_dir = expand('~/.vim/snip')
" rust ファイルを保存時，自動で rustfmt にかける
let g:rustfmt_autosave = 1
" * で検索時にカーソルを移動しない
let g:asterisk#keeppos = 1
" 翻訳時の対象言語
let g:translator_target_lang = 'ja'
" 翻訳結果を表示するウィンドウのサイズ
let g:translator_window_max_width = 0.9
let g:translator_window_max_height = 0.9
" whitespace を無視するファイル
let g:better_whitespace_filetypes_blacklist=
            \ ['toggleterm', 'diff', 'git', 'gitcommit',
            \'unite', 'qf', 'help', 'markdown', 'fugitive']
" tex ファイルコンパイル時に pdf を開くビューワー
if g:is_wsl
    let g:vimtex_view_general_viewer = 'sumatrapdf'
    let g:vimtex_view_general_options = '-reuse-instance @pdf'
else
    let g:vimtex_view_method = 'zathura'
end
" tex ファイルをコンパイルするコマンド
let g:vimtex_compiler_method = 'generic'
let g:vimtex_compiler_generic = {
    \ 'command' : 'make all',
    \}
" Silicon のフォントに HackGenNerd を使う
let g:silicon = {'font': 'HackGenNerd'}
" VimTex のハイライトを無効にする
let g:vimtex_syntax_enabled=0
" matchup を画面に表示しない
let g:matchup_matchparen_offscreen = {}
" normal モードに戻ると IME を切る
let g:spzenhan#default_status = 0

"----------------------------------------------------------
" alias
"----------------------------------------------------------
" leader を space に割当
let mapleader = "\<Space>"
let maplocalleader = "\<space>"
" jk でインサートモードを抜ける
inoremap <silent> jk <ESC>
" ESC 2回でサーチのハイライトを消す
nnoremap <silent> <ESC><ESC> :nohlsearch<CR>
" 行が折り返し表示されていた場合、行単位ではなく表示行単位でカーソルを移動する
nnoremap <silent> j gj
nnoremap <silent> k gk
" 検索結果が画面中央に来るようにする
nmap n nzz
nmap N Nzz

" translate 用のバインド
noremap <leader>t :TranslateW<CR>
" telescope 用のバインド
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
" Session Manager
nnoremap <leader>sl <Cmd>SessionManager load_last_session<cr>
nnoremap <leader>ss <Cmd>SessionManager load_session<cr>
nnoremap <leader>sc <Cmd>SessionManager load_current_session<cr>

" カーソルが常に画面中央に来るようにする
nnoremap <silent>zx <cmd>call CenteringCursorToggle()<cr>
function CenteringCursorToggle()
    if &scrolloff == 999
        set scrolloff=0
    else
        set scrolloff=999
    endif
endfunction

" 自動でインデント幅を検出する
autocmd BufRead * DetectIndent

"----------------------------------------------------------
" colorscheme
"----------------------------------------------------------
lua <<EOT
require("tokyonight").setup({
    styles = {
        comments = { italic = false },
        keywords = { italic = false },
        },
    terminal_colors = true,
    hide_inactive_statusline = false,
    on_colors = function(colors)
        colors.bg = "#101010"
        colors.bg_dark = "#080808"
        colors.bg_float = colors_bg
        colors.bg_highlight = "#202020"
        colors.bg_visual = "#404040"
        colors.fg = "#f0f0f0"
        colors.fg_dark = "#c0c0c0"
        colors.dark3 = "#404040"
        colors.dark5 = "#a5a5a5"
        colors.comment = "#808080"
        colors.fg_gutter = "#505050"
        colors.gitSigns = { change = colors.orange, add = colors.green, delete = colors.red }
        colors.border = colors.dark5
        colors.blue = "#7aa2f7"
        colors.cyan = "#7dcfff"
        colors.blue0 = "#d75f5f"
        colors.blue1 = "#ffaf5f"
        colors.blue2 = "#c0c000"
        colors.blue5 = "#3cb371"
        colors.blue6 = "#4169e1"
        colors.blue7 = "#8a2be2"
  end
})
EOT

set background=dark
colorscheme tokyonight-night
let g:is_dark = 1

command ColorSchemeToggle call ColorSchemeToggle()
function ColorSchemeToggle()
    if g:is_dark == 1
        colorscheme tokyonight-day
        let g:is_dark = 0
    else
        colorscheme tokyonight-night
        let g:is_dark = 1
    endif
endfunction

hi ExtraWhitespace guibg='#CF572D'
hi QuickScopePrimary gui=underline
hi link QuickScopeSecondary NONE

" hlslens color settings
hi HlSearchNear guibg='#505050'
hi clear Search
hi Search guibg='#555555'

" matchup highliting parentheses
hi MatchWord guifg='#bf6648' gui=underline
hi MatchParen guifg='#bf6648'


"----------------------------------------------------------
" toggle term
"----------------------------------------------------------
lua <<EOT
-- ToggleTerm 用 keybind
vim.api.nvim_set_keymap('n', '<C-t>', '<Cmd>ToggleTerm direction=float<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<C-y>', '<Cmd>ToggleTerm size=80 direction=vertical<CR>', {noremap = true, silent = true})

-- lazygit を ToggleTerm で開く
local Terminal = require("toggleterm.terminal").Terminal
local lazygit = Terminal:new({ cmd = "lazygit", direction = "float" })
local function open_lazygit()
    lazygit:toggle()
end
vim.api.nvim_set_keymap('n', '<leader>g', '', {noremap = true, silent = true, callback = open_lazygit})

-- Terminal 内でも <ESC> を使えるようにする
vim.api.nvim_create_autocmd('TermOpen', {
    pattern = {'term://*'},
    callback = function()
        vim.api.nvim_buf_set_keymap(0, 't', '<ESC>', [[<C-\><C-n>]], {noremap = true, silent = true})
    end
})
EOT


"----------------------------------------------------------
" indent blankline
"----------------------------------------------------------
hi IblScope guifg='#AAAAAA'

lua << EOT
require("ibl").setup({
    scope = {
       enabled = true,
       injected_languages = false,
       show_start = true,
       show_end = false,
    }
})
EOT


"----------------------------------------------------------
" Gitsigns
"----------------------------------------------------------
lua << EOT
require('gitsigns').setup({
    signcolumn = false,
    numhl = true
})
EOT


"----------------------------------------------------------
" neoscroll
"----------------------------------------------------------
lua << EOT
local t = {}

t['<C-u>'] = {'scroll', {'-vim.wo.scroll', 'true', '75'}}
t['<C-d>'] = {'scroll', { 'vim.wo.scroll', 'true', '75'}}
t['<C-b>'] = {'scroll', {'-vim.api.nvim_win_get_height(0)', 'true', '150'}}
t['<C-f>'] = {'scroll', { 'vim.api.nvim_win_get_height(0)', 'true', '150'}}
t['zt']    = {'zt', {'75'}}
t['zz']    = {'zz', {'75'}}
t['zb']    = {'zb', {'75'}}

require('neoscroll.config').set_mappings(t)
EOT


"----------------------------------------------------------
" tree-sitter
"----------------------------------------------------------
lua <<EOT
require'nvim-treesitter.configs'.setup {
    -- Install parsers synchronously (only applied to `ensure_installed`)
    sync_install = false,

    highlight = {
        enable = true,
        disable = {'org'},
        additional_vim_regex_highlighting = false,
    },
    matchup = {
        enable = true,
        disable = {},
    },
}
EOT


"----------------------------------------------------------
" lualine
"----------------------------------------------------------
lua<<EOT
local colors = require("tokyonight.colors").setup()
local my_a = { fg = colors.fg_dark, bg = colors.bg}
local my_b = { fg = colors.fg_dark, bg = colors.bg}
local my_c = { fg = colors.fg_dark, bg = colors.bg}
local my_set = { a = my_a, b = my_b, c = my_c}

local my_theme = { visual = my_set, replace = my_set, inactive = my_set, normal = my_set, insert = my_set }
local my_sections = {
    lualine_a = {'filename','branch', 'diff', 'diagnostics'},
    lualine_b = {},
    lualine_c = {},
    lualine_x = {'encoding', 'fileformat', 'filetype','%l/%L (%p%%)'},
    lualine_y = {},
    lualine_z = {}
}

require('lualine').setup({
    options = { theme  = my_theme },
    sections = my_sections,
    inactive_sections = my_sections,
})
EOT


"----------------------------------------------------------
" autopairs
"---------------------------------------------------------
lua <<EOT
local npairs = require("nvim-autopairs")
local Rule = require('nvim-autopairs.rule')

npairs.setup({
    check_ts = true,
    ignored_next_char = "[%w%.]",
    enable_check_bracket_line = false,
})

EOT

"----------------------------------------------------------
" noice
"---------------------------------------------------------
lua <<EOT
require("noice").setup({
lsp = {
    -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
    override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
        ["cmp.entry.get_documentation"] = true,
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
})
EOT


"----------------------------------------------------------
" LSP settings
"---------------------------------------------------------
lua <<EOT

------------------------------------------------------------
-- lspsaga settings
------------------------------------------------------------
require('lspsaga').setup({
    ui = {
        code_action = ''
    },
    lightbulb = {
        virtual_text = false
    }
})


------------------------------------------------------------
-- completion settings
------------------------------------------------------------
vim.opt.completeopt = "menu,menuone,noselect"
local cmp = require'cmp'
local cmp_autopairs = require('nvim-autopairs.completion.cmp')

local feedkey = function(key, mode)
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end

cmp.setup({
    snippet = {
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
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
            else
                fallback()
            end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function()
            if cmp.visible() then
                cmp.select_prev_item()
            end
        end, { "i", "s" }),
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-s>'] = cmp.mapping.complete(),
        ['<C-c>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = false }),
    }),
    experimental = { ghost_text = false },
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'vsnip' },
        { name = 'buffer', keyword_length = 4 },
        { name = 'path' },
    })
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
        { name = 'path' }
    }, {
        { name = 'cmdline' }
    })
})

cmp.event:on(
    'confirm_done',
    cmp_autopairs.on_confirm_done()
)

------------------------------------------------------------
-- keybindings
------------------------------------------------------------
local function change_diagnostic_state(float, text, line)
    return function()
        vim.g.lsp_float_is_enable = float
        vim.diagnostic.config({virtual_text = text, virtual_lines = line})
    end
end
local function show_line_diagnostics()
    if vim.g.lsp_float_is_enable then
        vim.cmd('Lspsaga show_line_diagnostics ++unfocus')
    end
end

local on_attach = function(client, bufnr)
    local function set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

    local opts = { noremap=true, silent=true }
    set_keymap("n", "gj",  "<cmd>Lspsaga goto_definition<CR>", opts)
    set_keymap("n", "gd",  "<cmd>Lspsaga peek_definition<CR>", opts)
    set_keymap("n", "grn", "<cmd>Lspsaga rename<CR>", opts)
    set_keymap("n", "gca", "<cmd>Lspsaga code_action<CR>", opts)
    set_keymap("n", "gs",  "<cmd>Lspsaga hover_doc<CR>", opts)
    set_keymap("n", "gn",  "<cmd>Lspsaga diagnostic_jump_next<CR>", opts)
    set_keymap("n", "gp",  "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts)
    set_keymap('n', '<leader>l0', '', {callback = change_diagnostic_state(false, false, false)})
    set_keymap('n', '<leader>l1', '', {callback = change_diagnostic_state(true,  false, false)})
    set_keymap('n', '<leader>l2', '', {callback = change_diagnostic_state(false, true,  false)})
    set_keymap('n', '<leader>l3', '', {callback = change_diagnostic_state(false, false, true )})
    vim.api.nvim_create_autocmd('CursorHold', {
        pattern = {'*'},
        callback = show_line_diagnostics
    })
end


------------------------------------------------------------
-- server settings
------------------------------------------------------------
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- none, single, double, rounded, solid, shadow
require("mason").setup({ui = {border = "single"}})

require('mason-lspconfig').setup_handlers({
    function(server)
        if server == 'rust_analyzer' then
            require('rust-tools').setup({
                server = {
                    capabilities = capabilities,
                    on_attach = on_attach,
                    settings = {
                        ["rust-analyzer"] = {
                            checkOnSave = {
                                command = "clippy"
                            },
                        }
                    },
                },
            })
        else
            require('lspconfig')[server].setup {
                on_attach = on_attach,
                capabilities = capabilities,
            }
        end
    end
})

------------------------------------------------------------
-- diagnostic settings
------------------------------------------------------------

-- open diagnostic on floatng window
vim.g.lsp_float_is_enable=true
-- disable default diagnostic (virtual text)
vim.diagnostic.config({virtual_lines = false, virtual_text = false})

EOT

