set clipboard=unnamedplus
set shell=/usr/bin/zsh
let mapleader="-"
let maplocalleader="\\"
call plug#begin(stdpath('data') . '/plugged')
Plug 'neoclide/coc.nvim', {'branch': 'release'}  " Syntax completion for a bunch of stuff
Plug 'arcticicestudio/nord-vim'                  " Nord color scheme
Plug 'vim-airline/vim-airline'                   " bottom bar
Plug 'vim-airline/vim-airline-themes'            " themes for the bottom bar
Plug 'rrethy/vim-hexokinase'                     " shows a color as you enter its code
Plug 'mhinz/vim-startify'                        " starting page
Plug 'junegunn/fzf.vim'                          " fuzzy finder
Plug 'tpope/vim-fugitive'                        " git integration
Plug 'tpope/vim-surround'                        " change surrounding characters
Plug 'tpope/vim-commentary'                      " comment out lines of code
Plug 'pechorin/any-jump.vim'                     " code inspection
Plug 'jackguo380/vim-lsp-cxx-highlight'          " C++ semantic highlighting
call plug#end()
"#################################
" COC configuration stuff
nmap <silent> <leader>n <Plug>(coc-diagnostic-next)
nmap <silent> <leader>p <Plug>(coc-diagnostic-prev)
" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gt <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
" Use K to show documentation in preview window.
nmap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction
" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)
" search project-wide
nmap <leader>rw :CocSearch <C-r>=expand("<cword>")<cr><cr>
" Applying codeAction to the selected region.
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)
" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)
" COC extension configs
nmap <silent> <leader>y  :<C-u>CocList -A yank<cr>
" Snippets completion, expansion, and jumping with <tab>
inoremap <silent><expr> <tab>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<cr>" :
      \ <SID>check_back_space() ? "\<tab>" :
      \ coc#refresh()
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
let g:coc_snippet_next = '<tab>'
" for BibTeX completion
call coc#config('list.source.bibtex', {'files': ['~/extra/Dropbox/books_papers/tony.bib']})
call coc#config('list.source.bibtex.citation', {'before': '\citep{','after': '}'})
" explorer settings
nnoremap <leader>e :CocCommand explorer<cr>
" END COC configuration
" #################################
" Color visualization
let g:Hexokinase_highlighters = [ 'virtual' ]
let g:Hexokinase_optInPatterns = 'full_hex,rgb,rgba,hsl,hsla'
let g:Hexokinase_ftDisabled = [ 'cpp' ]
" bottom bar
let g:airline_theme='nord'
let g:airline_powerline_fonts=1
let g:airline_left_sep=''
let g:airline_right_sep=''
" any jump to inspect all instances of a word
nnoremap <leader>j :AnyJump<cr>
" FZF stuff
let $FZF_DEFAULT_OPTS='--reverse'
" session management
let g:startify_session_dir='$HOME/.config/nvim/sessions'
let g:sessions_dir='$HOME/.config/nvim/sessions'
exec 'nnoremap <leader>ss :mksession! ' . g:sessions_dir . '/'
"let g:startify_fortune_use_unicode=1
let g:startify_custom_header=''
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
" delete to black hole (not pastable)
nnoremap <leader>dd "_dd
nnoremap <leader>dw "_dw
" Toggling color preview
nnoremap <leader>hx :HexokinaseToggle<cr>
" Move to the current buffer's directory
nnoremap <leader>c :cd %:p:h<cr>
" remap end of line and beginning of line from insert mode
inoremap <S-Left> <Home>
inoremap <S-Right> <End>
" Fuzzy finder
nnoremap <leader>f :Files<cr>
nnoremap <leader>g :BCommits<cr>
nnoremap <leader>C :Commands<cr>
nnoremap <leader>l :Lines<cr>
" Center screen when entering insert mode
autocmd InsertEnter * norm zz
" clear search highlights
nnoremap <leader>cl :nohl<cr>
" Use the space bar to insert a space from normal mode
nnoremap <Space> i <esc>
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
