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

" vim-plug
" textwidth にあわせて線を引く
Plug 'miyake13000/wrap-guide'
" LSP 用の colorscheme
Plug 'folke/lsp-colors.nvim'
" インデントの可視化
Plug 'lukas-reineke/indent-blankline.nvim'
" 末尾の全角半角空白文字を赤くハイライト
Plug 'ntpeters/vim-better-whitespace'
" Status line for lua
Plug 'nvim-lualine/lualine.nvim'
" buffer file
Plug 'akinsho/bufferline.nvim'
" colorscheme
" Plug 'metalelf0/jellybeans-nvim'
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
" rust_analyzer のラッパーLSP
Plug 'simrat39/rust-tools.nvim'
" build-in LSP のインタフェースを提供する
Plug 'neovim/nvim-lspconfig'
" LSP をインストール，セットアップする
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
" LSP の status を表示
Plug 'j-hui/fidget.nvim'
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
" スクロールバーに検索結果を表示
Plug 'kevinhwang91/nvim-hlslens'
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
" LSP の見た目をよくする
Plug 'folke/trouble.nvim'
" terminal の見た目をよくする
Plug 'akinsho/toggleterm.nvim'
" insert mode のときだけ絶対行表記
" Plug 'myusuf3/numbers.vim'
" ポップアップ通知を出す
Plug 'rcarriga/nvim-notify'
" sidebar
Plug 'sidebar-nvim/sidebar.nvim'
" スクロールをスムーズにする
Plug 'karb94/neoscroll.nvim'
" CursorHold のバグを修正する
Plug 'antoinemadec/FixCursorHold.nvim'
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
Plug 'hrsh7th/cmp-omni'

call plug#end()


" lua 製の bundle を setup する
lua <<EOT
require('alpha').setup(require'alpha.themes.dashboard'.config)
require('colorizer').setup()
require('todo-comments').setup({})
require('fidget').setup({})
require('trouble').setup({})
require('toggleterm').setup({})
require('bufferline').setup({})
require('nvim-treesitter.configs').setup({yati = { enable = true }})
require('notify').setup()
require('gitsigns').setup()
require('sidebar-nvim').setup({})
require('neoscroll').setup()
require('hlslens').setup({nearest_only = true})
require('Comment').setup()
require('orgmode').setup_ts_grammar()
require('orgmode').setup({})
require('spellsitter').setup()
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
" 構文に色を付ける
" syntax enable
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
set wildmenu
" 保存するコマンド履歴の数
set history=5000
" タブ入力を複数の空白入力に置き換える
set expandtab
" 連続した空白に対してタブキーやバックスペースキーでカーソルが動く幅
set softtabstop=4
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
" 折り返し表示しない
set nowrap
" spell check
"set spell


" スニペットの保存先
let g:vsnip_snippet_dir = expand('~/.vim/snip')
" rust ファイルを保存時，自動で rustfmt にかける
let g:rustfmt_autosave = 1
" CursorHold が発動するまでのマージン
let g:cursorhold_updatetime = 300
" * で検索時にカーソルを移動しない
" let g:asterisk#keeppos = 1
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
" display matching line in popup
let g:matchup_matchparen_offscreen = {'method': 'popup'}

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
nnoremap <down> gj
nnoremap <up> gk
" 検索結果が画面中央に来るようにする
nmap n nzz
nmap N Nzz

" NerdTree 用のバインド
nnoremap <leader>n :NERDTreeToggle<CR>
" translate 用のバインド
nnoremap <leader>g :TranslateW<CR>
vnoremap <leader>g :TranslateW<CR>
" Trouble 用のバインド
nnoremap <leader>xx <cmd>TroubleToggle<cr>
nnoremap <leader>xq <cmd>TroubleToggle quickfix<cr>
" telescope 用のバインド
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
" ToggleTerm 用バインド
nnoremap <leader>tt <Cmd>ToggleTerm size=80 direction=vertical<cr>
nnoremap <leader>tf <Cmd>ToggleTerm direction=float<cr>
" Sidebar を開く
nnoremap <leader>s <Cmd>SidebarNvimToggle<cr>
" asterisk で HlSearch を実行
nnoremap '*'  <Plug>(asterisk-z*)  <Cmd>lua require('hlslens').start()<CR>
nnoremap '#'  <Plug>(asterisk-z#)  <Cmd>lua require('hlslens').start()<CR>
nnoremap 'g*' <Plug>(asterisk-zg*) <Cmd>lua require('hlslens').start()<CR>
nnoremap 'g#' <Plug>(asterisk-zg#) <Cmd>lua require('hlslens').start()<CR>
" w3m 用のキーマップ
nnoremap <leader>w <cmd>call ExecW3M()<cr>
function ExecW3M()
    let inputtext = input("Search words > ")
    let args = '"exec ggr ' . inputtext . '"'
    let cmd = "TermExec direction=float cmd=" . args
    exe cmd
endfunction
" カーソルが常に画面中央に来るようにする
nnoremap <silent>zx <cmd>call CenteringCursorToggle()<cr>
function CenteringCursorToggle()
    if &scrolloff == 999
        set scrolloff=0
    else
        set scrolloff=999
    endif
endfunction

" ホバーで diagnostic を float で開く
autocmd CursorHold * :lua vim.diagnostic.open_float()

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
    terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
    hide_inactive_statusline = true, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
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
hi HlSearchLensNear guifg='#333333' guibg='#888888'
hi HlSearchLens guifg='#AAAAAA' guibg='#222222'
hi HlSearchNear guibg='#505050'
hi clear Search
hi Search guibg='#555555'

" matchup highliting parentheses
hi MatchWord guifg='#bf6648' gui=underline
hi MatchParen guifg='#bf6648'

"----------------------------------------------------------
" netscroll
"----------------------------------------------------------
lua << EOT
local t = {}

t['<C-u>'] = {'scroll', {'-vim.wo.scroll', 'true', '75'}}
t['<C-d>'] = {'scroll', { 'vim.wo.scroll', 'true', '75'}}
t['<C-b>'] = {'scroll', {'-vim.api.nvim_win_get_height(0)', 'true', '150'}}
t['<C-f>'] = {'scroll', { 'vim.api.nvim_win_get_height(0)', 'true', '150'}}

require('neoscroll.config').set_mappings(t)
EOT


"----------------------------------------------------------
" マウスでカーソル移動とスクロール
"----------------------------------------------------------
if has('mouse')
    set mouse=a
    if has('mouse_sgr')
        set ttymouse=sgr
    elseif v:version > 703 || v:version is 703 && has('patch632')
        "set ttymouse=sg
    else
        set ttymouse=xterm2
    endif
endif


"----------------------------------------------------------
" クリップボードからのペースト
"----------------------------------------------------------
" 挿入モードでクリップボードからペーストする時に自動でインデントさせないようにする
if &term =~ "tmux-256color"
    let &t_SI .= "\e[?2004h"
    let &t_EI .= "\e[?2004l"
    let &pastetoggle = "\e[201~"

    function XTermPasteBegin(ret)
        set paste
        return a:ret
    endfunction

    inoremap <special> <expr> <Esc>[200~ XTermPasteBegin("")
endif


"----------------------------------------------------------
" txt ファイルを自動改行するようにする
"----------------------------------------------------------
augroup filetypeIndent
    autocmd!
    autocmd BufNewFile,BufRead *.txt setlocal textwidth=70
augroup END

set formatoptions+=mM


"----------------------------------------------------------
" indent setting
"----------------------------------------------------------
" 画面上でタブ文字が占める幅
set tabstop=4
" smartindentで増減する幅
set shiftwidth=4

augroup filetypeIndent
    autocmd!
    autocmd BufNewFile,BufRead *.tex setlocal ts=2 sw=2
    autocmd BufNewFile,BufRead *.rb setlocal ts=2 sw=2
    autocmd BufNewFile,BufRead *.html setlocal ts=2 sw=2
augroup END


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
        -- additional_vim_regex_highlighting = {'org'},
        additional_vim_regex_highlighting = false,
    },
    matchup = {
        enable = true, -- mandatory, false will disable the whole extension
        disable = {},  -- optional, list of language that will be disabled
    },
}
EOT


"----------------------------------------------------------
" lualine
"----------------------------------------------------------
lua<<EOT
local colors = require("tokyonight.colors").setup()
local my_a = { fg = colors.fg, bg = colors.dark5}
local my_b = { fg = colors.fg, bg = colors.dark3}
local my_c = { fg = colors.dark5, bg = colors.bg}
local my_set = { a = my_a, b = my_b, c = my_c}

local my_theme = { visual = my_set, replace = my_set, inactive = my_set, normal = my_set, insert = my_set }

require('lualine').setup({
    options = { theme  = my_theme },
    sections = {
        lualine_a = {'mode'},
        lualine_b = {'filename'},
        lualine_c = {'branch', 'diff', 'diagnostics'},
        lualine_x = {'encoding', 'fileformat', 'filetype'},
        lualine_y = {'%l/%L (%c)'},
        lualine_z = {'progress'}
    }
})
EOT


"----------------------------------------------------------
" scrollbar
"----------------------------------------------------------
lua <<EOF
require("scrollbar").setup({
    handle = {
        color = '#555555',
    },
    marks = {
        Search = { color = '#CCCCCC' },
        Error = { color = '#D75F5F' },
        Warn = { color = '#FFAF5F' },
        Info = { color = '#4169E1' },
        Hint = { color = '#3CB371' },
        Misc = { color = '#9A8EB8' },
    }
})

require("scrollbar.handlers.search").setup()
EOF


"----------------------------------------------------------
" LSP settings
"---------------------------------------------------------
lua <<EOT
local npairs = require("nvim-autopairs")
local Rule = require('nvim-autopairs.rule')

npairs.setup({
    check_ts = true,
    ignored_next_char = "[%w%.]",
    enable_check_bracket_line = false,
    ts_config = {
        lua = {'string'},-- it will not add a pair on that treesitter node
        javascript = {'template_string'},
        java = false,-- don't check treesitter on java
    }
})

local ts_conds = require('nvim-autopairs.ts-conds')


-- press % => %% only while inside a comment or string
npairs.add_rules({
  Rule("%", "%", "lua")
    :with_pair(ts_conds.is_ts_node({'string','comment'})),
  Rule("$", "$", "lua")
    :with_pair(ts_conds.is_not_ts_node({'function'}))
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

local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

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
        -- completion = cmp.config.window.bordered(),
        -- documentation = cmp.config.window.bordered(),
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
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function()
            if cmp.visible() then
                cmp.select_prev_item()
            elseif vim.fn["vsnip#jumpable"](-1) == 1 then
                feedkey("<Plug>(vsnip-jump-prev)", "")
            end
        end, { "i", "s" }),
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-s>'] = cmp.mapping.complete(),
        ['<C-c>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = false }),
    }),
    sources = cmp.config.sources({
            { name = 'nvim_lsp' },
            { name = 'vsnip' },
            { name = 'omni' },
            { name = 'buffer' },
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

cmp.event:on( 'confirm_done', cmp_autopairs.on_confirm_done({  map_char = { tex = '' } }))

------------------------------------------------------------
-- keybindings
------------------------------------------------------------
local on_attach = function(client, bufnr)
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

    local opts = { noremap=true, silent=true }
    buf_set_keymap("n", "gd",  "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
    buf_set_keymap("n", "gr",  "<cmd>lua vim.lsp.buf.references()<CR>", opts)
    buf_set_keymap("n", "gi",  "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
    buf_set_keymap("n", "gtd", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
    buf_set_keymap("n", "grn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
    buf_set_keymap("n", "gca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
end

------------------------------------------------------------
-- lsp settings
------------------------------------------------------------
local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

require("mason").setup({})

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

EOT

