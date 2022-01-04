set clipboard=unnamedplus
set shell=/usr/bin/zsh
set completeopt=menu,menuone,noselect
let mapleader="-"
let maplocalleader="\\"
call plug#begin(stdpath('data') . '/plugged')
Plug 'arcticicestudio/nord-vim'                              " Nord color scheme
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " syntax highlighting
Plug 'neovim/nvim-lspconfig'                                 " LSP
Plug 'hrsh7th/nvim-cmp'                                      " Autocomplete
Plug 'hrsh7th/cmp-nvim-lsp'                                  " Autocomplete
Plug 'hrsh7th/cmp-buffer'                                    " Autocomplete
Plug 'hrsh7th/cmp-path'                                      " Autocomplete
Plug 'SirVer/ultisnips'                                      " Snippets
Plug 'quangnguyen30192/cmp-nvim-ultisnips'                   " UltiSnips source for nvim-cmp
Plug 'nvim-lua/popup.nvim'                                   " for telescope
Plug 'nvim-lua/plenary.nvim'                                 " for telescope
Plug 'nvim-telescope/telescope.nvim'                         " fuzzy search
Plug 'tpope/vim-fugitive'                                    " git integration
Plug 'rrethy/vim-hexokinase'                                 " shows a color as you enter its code
Plug 'pechorin/any-jump.vim'                                 " code inspection
Plug 'hoob3rt/lualine.nvim'                                  " status line
Plug 'kyazdani42/nvim-web-devicons'                          " status line icons
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
		"cpp",
		"css",
		"html",
		"jsonc",
		"latex",
		"lua",
		"python",
		"r",
		"scss",
		"toml",
		"yaml",
		"vim",
	},
	highlight = {
	enable = true,              -- false will disable the whole extension
	custom_captures = {
		-- Highlight the @foo.bar capture group with the "Identifier" highlight group.
		["foo.bar"] = "Identifier",
	},
	incremental_selection = {
		enable = true,
		keymaps = {
		init_selection    = "gnn",
		node_incremental  = "grn",
		scope_incremental = "grc",
		node_decremental  = "grm",
		},
	},
		additional_vim_regex_highlighting = true, -- required to disble spellcheking of code
	},
}
require'lualine'.setup {
	options = {
		icons_enabled        = true,
		theme                = 'nord',
		component_separators = {'', ''},
		section_separators   = {'', ''},
		disabled_filetypes   = {}
	},
	sections = {
		lualine_a = {'mode'},
		lualine_b = {'branch', 'diff'},
		lualine_c = {'filename'},
		lualine_x = {'encoding', 'fileformat', 'filetype'},
		lualine_y = { {'diagnostics', sources = {'nvim_diagnostic'}, sections = {'error', 'warn'}} },
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
-- language servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
	properties = {
		'documentation',
		'detail',
		'additionalTextEdits',
	}
}
require'lspconfig'.bashls.setup {
	capabilities = capabilities,
}
require'lspconfig'.clangd.setup {
	capabilities = capabilities,
	cmd = {'clangd', '--background-index',  '--clang-tidy', '--completion-style=detailed'}
}
require'lspconfig'.r_language_server.setup {
	capabilities = capabilities,
}
require'lspconfig'.vimls.setup {
	capabilities = capabilities,
}
require'lspconfig'.yamlls.setup {
	capabilities = capabilities,
}
require'lspconfig'.texlab.setup {
	capabilities = capabilities,
}
-- HTML and CSS
require'lspconfig'.cssls.setup {
	capabilities = capabilities,
}
require'lspconfig'.html.setup {
	capabilities = capabilities,
}
-- nvim-cmp
local cmp = require('cmp')

cmp.setup({
	snippet = {
		-- REQUIRED - you must specify a snippet engine
		expand = function(args)
			vim.fn["UltiSnips#Anon"](args.body)
		end,
	},
	mapping = {
		["<Tab>"] = cmp.mapping({
			i = function(fallback)
				if cmp.visible() then
					cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
			--	elseif vim.fn["UltiSnips#CanJumpForwards"]() == 1 then
			--		vim.api.nvim_feedkeys(t("<Plug>(ultisnips_jump_forward)"), 'm', true)
				else
					fallback()
				end
			end,
			s = function(fallback)
				if vim.fn["UltiSnips#CanJumpForwards"]() == 1 then
					vim.api.nvim_feedkeys(t("<Plug>(ultisnips_jump_forward)"), 'm', true)
				else
					fallback()
				end
			end
		}),
		["<S-Tab>"] = cmp.mapping({
			i = function(fallback)
				if cmp.visible() then
					cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
				--elseif vim.fn["UltiSnips#CanJumpBackwards"]() == 1 then
				--	vim.api.nvim_feedkeys(t("<Plug>(ultisnips_jump_backward)"), 'm', true)
				else
					fallback()
				end
			end,
			s = function(fallback)
				if vim.fn["UltiSnips#CanJumpBackwards"]() == 1 then
					vim.api.nvim_feedkeys(t("<Plug>(ultisnips_jump_forward)"), 'm', true)
				else
					fallback()
				end
			end
		}),
		['<Down>'] = cmp.mapping(cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }), {'i'}),
		['<Up>'] = cmp.mapping(cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }), {'i'}),
		['<C-n>'] = cmp.mapping({
			i = function(fallback)
				if cmp.visible() then
					cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
				else
					fallback()
				end
			end
		}),
		['<C-p>'] = cmp.mapping({
			i = function(fallback)
				if cmp.visible() then
					cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
				else
					fallback()
				end
			end
		}),
		['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
		['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
		['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
		['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
		['<C-e>'] = cmp.mapping({
			i = cmp.mapping.abort(),
		}),
		['<CR>'] = cmp.mapping({
			i = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false }),
		}),
	},
		sources = cmp.config.sources({
			{ name = 'nvim_lsp' },
			{ name = 'ultisnips' }
		}, {
			{ name = 'buffer' },
			{ name = 'path' }
		})
})

	-- Setup lspconfig.
	local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
EOF
" LSP keybindings
nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gD <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> gr <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> gi <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <leader>k <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> <C-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> <leader>n <cmd>lua vim.diagnostic.goto_prev()<CR>
nnoremap <silent> <leader>p <cmd>lua vim.diagnostic.goto_next()<CR>
" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<CR>
nnoremap <leader>fu <cmd>Telescope find_files cwd=..<CR>
nnoremap <leader>fp <cmd>Telescope find_files cwd=~/projects<CR>
nnoremap <leader>fd <cmd>Telescope find_files cwd=~/extra/Dropbox<CR>
nnoremap <leader>fo <cmd>Telescope oldfiles<CR>
nnoremap <leader>fb <cmd>Telescope buffers<CR>
nnoremap <leader>fh <cmd>Telescope help_tags<CR>
" Snippets
let g:UltiSnipsExpandTrigger="<C-k>"
let g:UltiSnipsJumpForwardTrigger="<C-b>"
let g:UltiSnipsJumpBackwardTrigger="<C-m>"
" Compe completion
inoremap <silent><expr> <C-y> compe#confirm('<CR>')
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
colorscheme nord
let g:nord_underline=1
let g:nord_italic=1
let g:nord_italic_comments=1
let g:nord_uniform_diff_background=1
syntax on
let g:load_doxygen_syntax=1
" Keep terminal transparecy; this line must be after syntax on
hi Normal guibg=NONE ctermbg=NONE
hi Terminal guibg=NONE ctermbg=NONE
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
" LSP highlighting; must be here
hi DiagnosticUnderlineError guibg=#2E3440 guifg=#BF616A
hi DiagnosticUnderlineWarn guibg=#2E3440 guifg=#EBCB8B
hi DiagnosticError guibg=#2E3440 guifg=#BF616A
hi DiagnosticWarn guibg=#2E3440 guifg=#EBCB8B
hi DiagnosticSignError guibg=#2E3440 guifg=#BF616A
hi DiagnosticSignWarn guibg=#2E3440 guifg=#EBCB8B
hi DiagnosticFloatingError guibg=#2E3440 guifg=#BF616A
hi DiagnosticFloatingWarn guibg=#2E3440 guifg=#EBCB8B
hi DiagnosticVirtualTextError guibg=#2E3440 guifg=#BF616A
hi DiagnosticVirtualTextWarn guibg=#2E3440 guifg=#EBCB8B
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
