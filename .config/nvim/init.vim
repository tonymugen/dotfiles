set clipboard=unnamedplus
set shell=/usr/bin/zsh
set completeopt=menu,menuone,noselect
let mapleader="-"
let maplocalleader="\\"
call plug#begin(stdpath('data') . '/plugged')
Plug 'rmehri01/onenord.nvim', { 'branch': 'main' }           " Color scheme
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " syntax highlighting
Plug 'quarto-dev/quarto-nvim'                                " Quarto plug-in
Plug 'jmbuhr/otter.nvim'                                     " .qmd contextual highlighting
Plug 'neovim/nvim-lspconfig'                                 " LSP
Plug 'hrsh7th/nvim-cmp'                                      " Autocomplete
Plug 'hrsh7th/cmp-nvim-lsp'                                  " Autocomplete
Plug 'hrsh7th/cmp-nvim-lsp-signature-help'                   " Autocomplete
Plug 'hrsh7th/cmp-buffer'                                    " Autocomplete
Plug 'hrsh7th/cmp-path'                                      " Autocomplete
Plug 'jmbuhr/cmp-pandoc-references'                          " Autocomplete
Plug 'kdheepak/cmp-latex-symbols'                            " Autocomplete
Plug 'saadparwaiz1/cmp_luasnip'                              " Add LuaSnip to autocomplete
Plug 'L3MON4D3/LuaSnip'                                      " Snippets
Plug 'nvim-lua/popup.nvim'                                   " for telescope
Plug 'nvim-lua/plenary.nvim'                                 " for telescope
Plug 'nvim-telescope/telescope.nvim'                         " fuzzy search
Plug 'tpope/vim-fugitive'                                    " git integration
Plug 'rrethy/vim-hexokinase'                                 " shows a color as you enter its code
Plug 'folke/todo-comments.nvim'                              " Highlight TODOs in comments
Plug 'Maan2003/lsp_lines.nvim'                               " Multi-line LSP error messages
Plug 'pechorin/any-jump.vim'                                 " code inspection
Plug 'hoob3rt/lualine.nvim'                                  " status line
Plug 'nvim-tree/nvim-web-devicons'                           " status line icons
Plug 'mhinz/vim-startify'                                    " starting page
call plug#end()
"#################################
"
" lua-based set-ups
lua <<EOF
require'nvim-treesitter.configs'.setup {
		ensure_installed = { -- one of "all", "maintained" (parsers with maintainers), or a list of languages
		"bash",
		"bibtex",
		"c",
		"cmake",
		"cpp",
		"css",
		"cmake",
		"html",
		"jsonc",
		"latex",
		"lua",
		"make",
		"markdown",
		"python",
		"perl",
		"r",
		"rnoweb",
		"scss",
		"toml",
		"yaml",
		"vim",
	},
	highlight = {
		enable = true,              -- false will disable the whole extension
		incremental_selection = {
			enable = true,
			keymaps = {
				init_selection    = "gnn",
				node_incremental  = "grn",
				scope_incremental = "grc",
				node_decremental  = "grm",
			},
		}
	},
}
require'lualine'.setup {
	options = {
		icons_enabled        = true,
		theme                = 'onenord',
		component_separators = {'', ''},
		section_separators   = {'', ''},
		disabled_filetypes   = {}
	},
	sections = {
		lualine_a = {'mode'},
		lualine_b = {'branch', 'diff'},
		lualine_c = {'filename'},
		lualine_x = {'encoding', 'fileformat', 'filetype'},
		lualine_y = { {
				'diagnostics',
				sources = {'nvim_diagnostic'}, 
				sections = {'error', 'warn'},
				symbols = {error = " ", warn = " "}} 
			},
		lualine_z = {'progress', 'location', '%L'}
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = {'filename'},
		lualine_x = {'location'},
		lualine_y = {},
		lualine_z = {}
	},
	tabline    = {},
	extensions = {fugitive}
}
-- LuaSnip set-up
local luasnip = require('luasnip')
require("luasnip.loaders.from_lua").lazy_load()
luasnip.filetype_extend("quarto", { "markdown" })
luasnip.filetype_extend("rmarkdown", { "markdown" })
local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }
keymap("i", "<c-n>", "<cmd>lua require'luasnip'.jump(1)<CR>", opts)
keymap("s", "<c-n>", "<cmd>lua require'luasnip'.jump(1)<CR>", opts)
keymap("i", "<c-p>", "<cmd>lua require'luasnip'.jump(-1)<CR>", opts)
keymap("s", "<c-p>", "<cmd>lua require'luasnip'.jump(-1)<CR>", opts)
-- language servers
local on_attach_qmd = function(client, bufnr)
	local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
	local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

	buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
	local opts = { noremap = true, silent = true }

	buf_set_keymap('n', 'gh', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
	buf_set_keymap('n', 'gi', '<cmd>Telescope lsp_implementations<CR>', opts)
	buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
	buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
	client.server_capabilities.document_formatting = true
end
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
	properties = {
		'documentation',
		'detail',
		'additionalTextEdits',
	}
}
local util = require("lspconfig.util")
require'lspconfig'.bashls.setup {
	capabilities = capabilities,
}
require'lspconfig'.clangd.setup {
	capabilities = capabilities,
	cmd = {
		'clangd',
		'--background-index',
		'--clang-tidy',
		'--malloc-trim',
		'--completion-style=detailed'
	}
}
--require'lspconfig'.r_language_server.setup {
--	capabilities = capabilities,
--}
require'lspconfig'.vimls.setup {
	capabilities = capabilities,
}
require'lspconfig'.yamlls.setup {
	capabilities = capabilities,
}
require'lspconfig'.texlab.setup {
	capabilities = capabilities,
}
require'lspconfig'.neocmake.setup {
	capabilities = capabilities,
}
require'lspconfig'.marksman.setup {
	on_attach = on_attach_qmd,
	capabilities = capabilities,
	filetypes = { 'markdown', 'quarto' },
	root_dir = util.root_pattern(".git", ".marksman.toml", "_quarto.yml"),
}
-- HTML and CSS
require'lspconfig'.cssls.setup {
	capabilities = capabilities,
}
require'lspconfig'.html.setup {
	capabilities = capabilities,
}
-- quarto
require'quarto'.setup {
  debug = false,
  closePreviewOnExit = true,
  lspFeatures = {
    enabled = true,
    languages = { 'r', 'bash' },
    chunks = 'curly', -- 'curly' or 'all'
    diagnostics = {
      enabled = true,
      triggers = { "BufWritePost" }
    },
    completion = {
      enabled = true,
    },
  },
  keymap = {
    hover = '<leader>k',
    definition = 'gd',
    rename = '<leader>lR',
    references = 'gr',
  }
}
-- nvim-cmp
local cmp = require('cmp')

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

cmp.setup({
	snippet = {
		-- REQUIRED - you must specify a snippet engine
		expand = function(args)
			if not luasnip then
				return
			end
			luasnip.lsp_expand(args.body)
	end,
	},
	mapping = {
		["<CR>"] = cmp.mapping.confirm { select = true },
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			elseif has_words_before() then
				cmp.complete()
			else
				fallback()
			end
		end, { "i", "s" }),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),
	},
	sources = cmp.config.sources({
		{ name = 'buffer' },
		{ name = 'luasnip' },
		{ name = 'nvim_lsp' },
		{ name = 'nvim_lsp_signature_help' },
		{ name = 'pandoc_references' },
		{ name = 'treesitter' },
		{ name = 'otter' },
		{ name = 'latex_symbols' },
		{ name = 'path' }
	})
})
require("todo-comments").setup { }
require("lsp_lines").setup { }
vim.diagnostic.config({ virtual_lines = { only_current_line = true } })
require('onenord').setup({
  theme = "dark", -- "dark" or "light". Alternatively, remove the option and set vim.o.background instead
  borders = true, -- Split window borders
  fade_nc = false, -- Fade non-current windows, making them more distinguishable
  -- Style that is applied to various groups: see `highlight-args` for options
  styles = {
    comments = "NONE",
    strings = "NONE",
    keywords = "bold",
    functions = "NONE",
    variables = "NONE",
    diagnostics = "underline",
  },
  disable = {
    background = true, -- Disable setting the background color
    cursorline = false, -- Disable the cursorline
    eob_lines = true, -- Hide the end-of-buffer lines
  },
  -- Inverse highlight for different groups
  inverse = {
    match_paren = true,
  },
})
EOF
" LSP keybindings
nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gD <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> gr <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> gi <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <leader>k <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> <leader>s <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> <leader>p <cmd>lua vim.diagnostic.goto_prev()<CR>
nnoremap <silent> <leader>n <cmd>lua vim.diagnostic.goto_next()<CR>
" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<CR>
nnoremap <leader>fu <cmd>Telescope find_files cwd=..<CR>
nnoremap <leader>fp <cmd>Telescope find_files cwd=~/projects<CR>
nnoremap <leader>fd <cmd>Telescope find_files cwd=~/extra/Dropbox<CR>
nnoremap <leader>fo <cmd>Telescope oldfiles<CR>
nnoremap <leader>fb <cmd>Telescope buffers<CR>
nnoremap <leader>fh <cmd>Telescope help_tags<CR>
nnoremap <leader>fl <cmd>Telescope current_buffer_fuzzy_find<CR>
nnoremap <leader>fq <cmd>Telescope diagnostics<CR>
" Color visualization
let g:Hexokinase_highlighters = [ 'virtual' ]
let g:Hexokinase_optInPatterns = 'full_hex,rgb,rgba,hsl,hsla'
let g:Hexokinase_ftDisabled = [ 'cpp' ]
" any jump to inspect all instances of a word
nnoremap <leader>j :AnyJump<cr>
" session management
let g:startify_session_dir='$HOME/.config/nvim/sessions'
let g:sessions_dir='$HOME/.config/nvim/sessions'
exec 'nnoremap <leader>ss :mksession! ' . g:sessions_dir . '/'
"let g:startify_fortune_use_unicode=1
let g:startify_lists = [
	\ { 'type': 'files',     'header': ['   MRU']            },
	\ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
	\ { 'type': 'commands',  'header': ['   Commands']       },
	\ ]
let g:startify_custom_header=''
let g:startify_bookmarks = [ {'p': '~/projects'} ]
let g:startify_skiplist = [ '.*/init\.vim', '.*\.tsv$', '.*\.csv$' ]
" enable scrolling in terminal
set mouse=a
" Color scheme
set termguicolors
syntax on
let g:load_doxygen_syntax=1
set cindent
" Marking misspelled words with underlines only
hi clear SpellBad
hi clear SpellCap
hi clear SpellRare
hi clear SpellLocal
hi SpellBad   gui=underline
hi SpellCap   gui=underline
hi SpellRare  gui=underline
hi SpellLocal gui=underline
" both number and nonumber to get the number of the focal line
set number
set relativenumber
" cursor line and column highlighting
set cursorline
set cursorcolumn
set hlsearch
set tabstop=4
set softtabstop=4
set shiftwidth=4
set linebreak
" global statusline
set laststatus=3
" paste from insert mode
inoremap <C-p> <esc>"+pa
" Matching parens
inoremap ( ()<Left>
inoremap { {}<Left>
inoremap [ []<Left>
" select inside enclosures
nnoremap ci( f(ci(
nnoremap yi( f(yi(
nnoremap vi( f(vi(
nnoremap ci{ f{ci{
nnoremap yi{ f{yi{
nnoremap vi{ f{vi{
nnoremap ci[ f[ci[
nnoremap yi[ f[yi[
nnoremap vi[ f[vi[
" delete to black hole (not pastable)
nnoremap <leader>dd "_dd
nnoremap <leader>dw "_dw
" Move to the current buffer's directory
nnoremap <leader>c :cd %:p:h<cr>
" remap end of line and beginning of line from insert mode
inoremap <S-Left> <Home>
inoremap <S-Right> <End>
" Center screen when entering insert mode
autocmd InsertEnter * norm zz
" clear search highlights
nnoremap <leader>cl :nohl<cr>
" Use the space bar to insert a space from normal mode
nnoremap <Space> i <ESC>
nnoremap <CR> i<CR> <ESC>
" Remap moving between tabs
nnoremap <C-h> :tabprevious<cr>
nnoremap <C-l> :tabnext<cr>
nnoremap <C-t> :below vert terminal<cr>
" remap moving between splits
nnoremap g] :wincmd l<cr>
nnoremap g[ :wincmd h<cr>
" abbrevs
iabbrev adn and
iabbrev teh the
iabbrev tp to
iabbrev texit textit
iabbrev bolsymbol boldsymbol
" comment shortcuts
augroup comment_shortcuts
	autocmd!
	autocmd FileType tex	nnoremap <buffer> <localleader>c I%<esc>
	autocmd FileType r		nnoremap <buffer> <localleader>c I#<esc>
	autocmd FileType rnoweb	nnoremap <buffer> <localleader>c I#<esc>
	autocmd FileType perl	nnoremap <buffer> <localleader>c I#<esc>
	autocmd FileType sh		nnoremap <buffer> <localleader>c I#<esc>
	autocmd FileType cpp	nnoremap <buffer> <localleader>c I//<esc>
augroup END
" set spellcheckers
set nospell
augroup set_spell
	autocmd!
	autocmd FileType tex		set spell spelllang=en_us
	autocmd FileType rnoweb		set spell spelllang=en_us
	autocmd FileType mkd		set spell spelllang=en_us
	autocmd FileType markdown	set spell spelllang=en_us
	autocmd FileType text		set spell spelllang=en_us
	autocmd FileType mail		set spell spelllang=en_us
	autocmd FileType cpp		set spell spelllang=en_us
augroup END
" typesetting/compilation shortcuts
" NOTE: these are rather specific to my personal set-up and file naming scheme
augroup compile_shortcuts
	autocmd!
	autocmd FileType tex		nnoremap <localleader>t :!pdflatex %<cr>
	autocmd FileType plaintex	nnoremap <localleader>t :!pdflatex %<cr>
	autocmd FileType tex		nnoremap <localleader>x :!xelatex %<cr>
	autocmd FileType plaintex	nnoremap <localleader>x :!xelatex %<cr>
	autocmd FileType tex		nnoremap <localleader>p :execute "!zathura " . split(expand('%'), '\.')[0] . ".pdf &"<cr>
	autocmd FileType plaintex	nnoremap <localleader>p :execute "!zathura " . split(expand('%'), '\.')[0] . ".pdf &"<cr>
	autocmd FileType tex		nnoremap <localleader>b :execute "!bibtex " . split(expand('%'), '\.')[0]<cr>
	autocmd FileType plaintex	nnoremap <localleader>b :execute "!bibtex " . split(expand('%'), '\.')[0]<cr>
"
	autocmd FileType rnoweb		nnoremap <localleader>r :!R CMD Sweave %<cr>
	autocmd FileType rnoweb		nnoremap <localleader>t :execute "!pdflatex " . split(expand('%'), '\.')[0] . ".tex"<cr>
	autocmd FileType rnoweb		nnoremap <localleader>p :execute "!zathura " . split(expand('%'), '\.')[0] . ".pdf &"<cr>
"
	autocmd FileType markdown	nnoremap <localleader>w :execute "!pandoc --from markdown --to docx % > " .split(expand('%'), '\.')[0] . ".docx"<cr>
	autocmd FileType markdown	nnoremap <localleader>c :execute "!pandoc --from markdown --to pdf % > " .split(expand('%'), '\.')[0] . ".pdf"<cr>
	autocmd FileType markdown	nnoremap <localleader>p :execute "!zathura " . split(expand('%'), '\.')[0] . ".pdf &"<cr>
	autocmd FileType quarto     nnoremap <localleader>r :QuartoPreview --no-browser<cr>
	autocmd FileType quarto  	nnoremap <localleader>p :execute "!zathura " . split(expand('%'), '\.')[0] . ".pdf &"<cr>
augroup END

augroup terminals
	autocmd!
	autocmd FileType r      nnoremap <localleader>orv :vsplit term://R<cr>
	autocmd FileType rnoweb nnoremap <localleader>orv :vsplit term://R<cr>
	autocmd FileType r      nnoremap <localleader>orh :split term://R<cr>
	autocmd FileType rnoweb nnoremap <localleader>orh :split term://R<cr>
augroup END

augroup highlight_yank
	autocmd!
	autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank()
augroup END

augroup insert_templates
	autocmd!
	" insert ggplot2 .Rnw header template
	autocmd FileType rnoweb		nnoremap <localleader>g :0read $HOME/.config/templates/plotTemplate.Rnw <cr>
	" insert ggplot2 PDF figure
	autocmd FileType rnoweb		nnoremap <localleader>f :.-1read $HOME/.config/templates/ggPDFplot.Rnw <cr>
	" insert histogram ggplot2 PDF
	autocmd FileType rnoweb		nnoremap <localleader>h :.-1read $HOME/.config/templates/ggHistPDF.Rnw <cr>
	" insert TeX starter template
	autocmd FileType plaintex	nnoremap <localleader>d :.-1read $HOME/.config/templates/texTemplate.tex <cr>
	autocmd FileType tex		nnoremap <localleader>d :.-1read $HOME/.config/templates/texTemplate.tex <cr>
	" insert BSD license
	autocmd FileType cpp		nnoremap <localleader>l :0read $HOME/.config/templates/BSDlicense.txt <cr>
	autocmd FileType r			nnoremap <localleader>l :0read $HOME/.config/templates/BSDlicenseR.txt <cr>
	autocmd FileType sh			nnoremap <localleader>l :0read $HOME/.config/templates/BSDlicenseR.txt <cr>
augroup END

" Open the master .bib file
augroup open_bibfile
	autocmd FileType tex		nnoremap <localleader>B :tabedit $DPBX/books_papers/tony.bib <cr>
	autocmd FileType plaintex	nnoremap <localleader>B :tabedit $DPBX/books_papers/tony.bib <cr>
	autocmd FileType bib		nnoremap <localleader>B :tabedit $DPBX/books_papers/tony.bib <cr>
augroup END
" e-mail composition: kill hard wrapping of text
augroup mail_compose
	autocmd FileType mail set textwidth=0
augroup END

" Set custom file types from extensions
augroup ftFromExt
	autocmd BufRead,BufNewFile *.cff set filetype=yaml
augroup END
