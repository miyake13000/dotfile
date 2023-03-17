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
" ファイルツリーの表示
Plug 'preservim/nerdtree'
" 日本語改行時の禁則処理
Plug 'vim-jp/autofmt'
" Rust フォーマッタ
Plug 'rust-lang/rust.vim'
" markdown の機能を追加する
Plug 'godlygeek/tabular'
Plug 'preservim/vim-markdown'
" markdown のプレビューを表示する
Plug 'iamcco/markdown-preview.nvim'
" disable IME when leave insert mode
Plug 'kaz399/spzenhan.vim'
" command を非同期に実行
Plug 'skywind3000/asyncrun.vim'
" カラーコードに色をつける
Plug 'norcalli/nvim-colorizer.lua'
" TODO などを目立たせる
Plug 'folke/todo-comments.nvim'
" スクロールバーを表示
Plug 'petertriho/nvim-scrollbar'
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
" sidebar
Plug 'sidebar-nvim/sidebar.nvim'
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
" hex editor
Plug 'Shougo/vinarise.vim'
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
" CursorHold のバグを修正する
Plug 'antoinemadec/FixCursorHold.nvim'
" LSP 対応外のツールを LS として使用できるようにする
Plug 'jose-elias-alvarez/null-ls.nvim'
" null-ls を mason に対応させる
Plug 'jayp0521/mason-null-ls.nvim'
" LSP のUI を改善する
Plug 'tami5/lspsaga.nvim'

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
require('gitsigns').setup()
require('sidebar-nvim').setup({})
require('neoscroll').setup()
require('Comment').setup()
require('orgmode').setup_ts_grammar()
require('orgmode').setup({})
require('spellsitter').setup()
require('lspsaga').setup()
require('null-ls').setup()
require('mason-null-ls').setup()
require('session_manager').setup({ autoload_mode = require('session_manager.config').AutoloadMode.Disabled })
require('dressing').setup()
require('lsp_lines').setup()
require('lsp_lines').toggle()
--require('urlview').setup()
--require('which-key').setup({})
EOT

"----------------------------------------------------------
" some settings
"----------------------------------------------------------
" ファイルタイプ別のVimプラグイン/インデントを有効にする
filetype plugin indent on
" sign column を常に表示する
set signcolumn=yes:2
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
" spell check
"set spell


" スニペットの保存先
let g:vsnip_snippet_dir = expand('~/.vim/snip')
" rust ファイルを保存時，自動で rustfmt にかける
let g:rustfmt_autosave = 1
" CursorHold が発動するまでのマージン
let g:cursorhold_updatetime = 300
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
" バイナリファイルを開くと hex editor を起動する
let g:vinarise_enable_auto_detect = 1
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
nnoremap <ESC><ESC> :nohlsearch<CR>
" 行が折り返し表示されていた場合、行単位ではなく表示行単位でカーソルを移動する
nnoremap j gj
nnoremap k gk
" 検索結果が画面中央に来るようにする
nmap n nzz
nmap N Nzz

" translate 用のバインド
nnoremap <leader>t <cmd>TranslateW<CR>
vnoremap <leader>t <cmd>TranslateW<CR>
" telescope 用のバインド
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
" ToggleTerm 用バインド
nnoremap <c-y> <Cmd>ToggleTerm size=80 direction=vertical<cr>
nnoremap <c-t> <Cmd>ToggleTerm direction=float<cr>
" Sidebar を開く
nnoremap <leader>a <Cmd>SidebarNvimToggle<cr>
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

" lsp_lines を切り替える
let g:lsp_lines_is_enable = 0
nnoremap <leader>l <Cmd>call LspLinesToggle()<cr>
function LspLinesToggle()
    if g:lsp_lines_is_enable == 0
        let g:lsp_lines_is_enable = 1
    else
        let g:lsp_lines_is_enable = 0
    endif
    lua require('lsp_lines').toggle()
endfunction

" diagnostic を float で開く
autocmd CursorHold * call ShowDiagnostics()
function ShowDiagnostics()
    if g:lsp_lines_is_enable == 0
        lua require('lspsaga.diagnostic').show_line_diagnostics()
    endif
endfunction

" lazygit を ToggleTerm で開く
nnoremap <leader>g <Cmd>lua _lazygit_toggle()<cr>
lua <<EOT
local Terminal = require("toggleterm.terminal").Terminal
local lazygit = Terminal:new({ cmd = "lazygit", direction = "float" })
function _lazygit_toggle()
    lazygit:toggle()
end
EOT

" ToggleTerm 中のキーマップ
autocmd! TermOpen term://* lua set_terminal_keymaps()
lua << EOT
function _G.set_terminal_keymaps()
  local opts = {noremap = true}
  vim.api.nvim_buf_set_keymap(0, 't', '<esc>', [[<C-\><C-n>]], opts)
end
EOT

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
" scrollbar
"----------------------------------------------------------
lua <<EOF
-- require("scrollbar").setup({
--     show_in_active_only = true,
--     hide_if_all_visible = false,
--     handle = {
--         color = '#555555',
--     },
--     marks = {
--         Search = { color = '#CCCCCC' },
--         Error = { color = '#D75F5F' },
--         Warn = { color = '#FFAF5F' },
--         Info = { color = '#4169E1' },
--         Hint = { color = '#3CB371' },
--         Misc = { color = '#9A8EB8' },
--     }
-- })
--
-- require("scrollbar.handlers.search").setup({nearest_only = true})
-- require("scrollbar.handlers.gitsigns").setup()
EOF


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
" autopairs
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
local on_attach = function(client, bufnr)
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

    local opts = { noremap=true, silent=true }
    buf_set_keymap("n", "gd",  "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
    buf_set_keymap("n", "gq",  "<cmd>Telescope diagnostics<CR>", opts)
    buf_set_keymap("n", "gr",  "<cmd>Telescope lsp_references<CR>", opts)
    buf_set_keymap("n", "gi",  "<cmd>Telescope lsp_implementations()<CR>", opts)
    buf_set_keymap("n", "gtd", "<cmd>Telescope lsp_type_definitions()<CR>", opts)
    buf_set_keymap("n", "grn", "<cmd>lua require('lspsaga.rename').rename()<CR>", opts)
    buf_set_keymap("n", "gca", "<cmd>lua require('lspsaga.codeaction').code_action()<CR>", opts)
end

local function show_documentation()
  local ft = vim.opt.filetype._value
  if ft == 'vim' or ft == 'help' then
    vim.cmd([[execute 'h ' . expand('<cword>') ]])
  else
    require('lspsaga.hover').render_hover_doc()
  end
end

vim.keymap.set({ 'n' }, 'gs', show_documentation)

------------------------------------------------------------
-- lsp settings
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

-- false : do not show error/warning/etc.. by virtual text
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, { virtual_text = false }
)
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
  vim.lsp.handlers.hover, { separator = true }
)
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
  vim.lsp.handlers.signature_help, { separator = true }
)

EOT

