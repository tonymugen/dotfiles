" Vundle stuff
set nocompatible
filetype off
" bash shell better for non-interactive stuff
set shell=/usr/bin/bash
let mapleader="-"
let maplocalleader="\\"

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'octol/vim-cpp-enhanced-highlight'          " C++ syntax highlights
Plugin 'neoclide/coc.nvim', {'branch': 'release'}  " Syntax completion for a bunch of stuff
Plugin 'arcticicestudio/nord-vim'                  " Nord color scheme
Plugin 'vim-airline/vim-airline'                   " bottom bar
Plugin 'vim-airline/vim-airline-themes'            " themes for the bottom bar
Plugin 'rrethy/vim-hexokinase'                     " shows a color as you enter its code
Plugin 'mhinz/vim-startify'                        " starting page
Plugin 'junegunn/fzf.vim'                          " fuzzy finder
Plugin 'tpope/vim-fugitive'                        " git integration
Plugin 'pechorin/any-jump.vim'                     " code inspection
call vundle#end()

filetype plugin indent on

"#################################
" COC configuration stuff
set hidden
set updatetime=300
set shortmess+=c
"set signcolumn=number
nmap <silent> <leader>n <Plug>(coc-diagnostic-next)
nmap <silent> <leader>p <Plug>(coc-diagnostic-prev)
" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gt <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction
" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)
" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)
" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)
" COC extension configs
nnoremap <silent> <leader>y  :<C-u>CocList -A yank<cr>
" Snippets completion, expansion, and jumping with <tab>
inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
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
nmap <leader>e :CocCommand explorer --preset .vim<CR>
" END COC configuration
" #################################
" cpp-enhanced settings
let g:cpp_member_variable_highlight=1
let g:cpp_class_scope_highlight=1
let g:cpp_class_decl_highlight=1

let g:startify_session_dir='~/.vim/sessions'
let g:startify_fortune_use_unicode=1
" Color visualization
let g:Hexokinase_highlighters = [ 'background' ]
let g:Hexokinase_optInPatterns = 'full_hex,rgb,rgba,hsl,hsla'
" bottom bar
let g:airline_theme='nord'
let g:airline_powerline_fonts=1
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
set cindent
" both number and nonumber to get the number of the focal line
set number
set relativenumber
" cursor line and column highlighting
set cursorline
set cursorcolumn
set hlsearch
set guifont=Menlo\ Nerd\ Font\ 11
" get rid of the toolbar in the GUI
set guioptions-=T
set shiftwidth=4
set tabstop=4
set linebreak
" cursor appearance in different modes
let &t_SI = "\<Esc>[6 q"
let &t_SR = "\<Esc>[5 q"
let &t_EI = "\<Esc>[2 q"
" for quick switching back to normal mode
set timeoutlen=1000 ttimeoutlen=0
" completion in the gutter
set wildmode=longest,list,full
" key remaps
" crtl-s to save from insert mode
inoremap <C-s> <C-\><C-o>:w<cr>
" remap end of line and beginning of line from insert mode
inoremap <S-Left> <Home>
inoremap <S-Right> <End>
" Remap moving between tabs
inoremap <C-h> :tabprevious<cr>
nnoremap <C-h> :tabprevious<cr>
inoremap <C-l> :tabnext<cr>
nnoremap <C-l> :tabnext<cr>
" clear search highlights
nnoremap <leader>cl :nohl<cr>
" Use the space bar to insert a space from normal mode
nnoremap <Space> i <esc>
" paste
nnoremap <C-p> "+p
inoremap <C-p> <esc>"+pa
nnoremap <C-i> "+P
" copy to clipboard
vnoremap <C-y> "+y
" Opening and sourcing .vimrc
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
" Toggling color preview
nnoremap <leader>hx :HexokinaseToggle<cr>
" Move to the current buffer's directory
nnoremap <leader>c :cd %:p:h<cr>
" Fuzzy finder
nnoremap <leader>f :Files<cr>
nnoremap <leader>g :BCommits<cr>
nnoremap <leader>C :Commands<cr>
nnoremap <leader>l :Lines<cr>

" abbrevs
iabbrev adn and
iabbrev teh the
iabbrev tp to
iabbrev texit textit
iabbrev bolsymbol boldsymbol
" comment shortcuts
augroup comment_shortcuts
	autocmd!
	autocmd FileType tex    nnoremap <buffer> <localleader>c I%<esc>
	autocmd FileType r      nnoremap <buffer> <localleader>c I#<esc>
	autocmd FileType rnoweb nnoremap <buffer> <localleader>c I#<esc>
	autocmd FileType perl   nnoremap <buffer> <localleader>c I#<esc>
	autocmd FileType sh     nnoremap <buffer> <localleader>c I#<esc>
	autocmd FileType cpp    nnoremap <buffer> <localleader>c I//<esc>
augroup END
" set spellcheckers
set nospell
augroup set_spell
	autocmd!
	autocmd FileType tex      set spell spelllang=en_us
	autocmd FileType rnoweb   set spell spelllang=en_us
	autocmd FileType mkd      set spell spelllang=en_us
	autocmd FileType markdown set spell spelllang=en_us
	autocmd FileType text     set spell spelllang=en_us
	autocmd FileType mail     set spell spelllang=en_us
	autocmd FileType cpp      set spell spelllang=en_us
augroup END

" typesetting/compilation shortcuts
" NOTE: these are rather specific to my personal set-up and file naming scheme
augroup compile_shortcuts
	autocmd!
	autocmd FileType tex      nnoremap <localleader>t :!pdflatex %<cr>
	autocmd FileType plaintex nnoremap <localleader>t :!pdflatex %<cr>
	autocmd FileType tex      nnoremap <localleader>p :execute "!GDK_SCALE=2 zathura " . split(expand('%'), '\.')[0] . ".pdf &"<cr>
	autocmd FileType plaintex nnoremap <localleader>p :execute "!GDK_SCALE=2 zathura " . split(expand('%'), '\.')[0] . ".pdf &"<cr>
	autocmd FileType tex      nnoremap <localleader>b :execute "!bibtex " . split(expand('%'), '\.')[0]<cr>
	autocmd FileType plaintex nnoremap <localleader>b :execute "!bibtex " . split(expand('%'), '\.')[0]<cr>
	autocmd FileType rnoweb   nnoremap <localleader>r :!R CMD Sweave %<cr>
	autocmd FileType rnoweb   nnoremap <localleader>t :execute "!pdflatex " . split(expand('%'), '\.')[0] . ".tex"<cr>
	autocmd FileType rnoweb   nnoremap <localleader>p :execute "!GDK_SCALE=2 zathura " . split(expand('%'), '\.')[0] . ".pdf &"<cr>
augroup END

" moving around in C++ files
augroup cpp_movement
	autocmd!
	" next and previous compiler error
	autocmd FileType cpp nnoremap <localleader>n :lnext <cr>
	autocmd FileType cpp nnoremap <localleader>p :lprevious <cr>
	autocmd FileType cpp nnoremap <localleader>gd :YcmCompleter GoToDefinition <cr>
	autocmd FileType cpp nnoremap <localleader>gD :YcmCompleter GoToDeclaration <cr>
	autocmd FileType cpp nnoremap <localleader>gI :YcmCompleter GoToInclude <cr>
	" quick GoTo
	autocmd FileType cpp nnoremap <localleader>gi :YcmCompleter GoToImprecise <cr>
augroup END

augroup insert_templates
	autocmd!
	" insert ggplot2 .Rnw header template
	autocmd FileType rnoweb   nnoremap <localleader>g :0read $HOME/.config/templates/plotTemplate.Rnw <cr>
	" insert ggplot2 PDF figure
	autocmd FileType rnoweb   nnoremap <localleader>f :.-1read $HOME/.config/templates/ggPDFplot.Rnw <cr>
	" insert histogram ggplot2 PDF
	autocmd FileType rnoweb   nnoremap <localleader>h :.-1read $HOME/.config/templates/ggHistPDF.Rnw <cr>
	" insert TeX starter template
	autocmd FileType plaintex nnoremap <localleader>d :.-1read $HOME/.config/templates/texTemplate.tex <cr>
	autocmd FileType tex      nnoremap <localleader>d :.-1read $HOME/.config/templates/texTemplate.tex <cr>
	" insert BSD license
	autocmd FileType cpp      nnoremap <localleader>l :0read $HOME/.config/templates/BSDlicense.txt <cr>
	autocmd FileType r        nnoremap <localleader>l :0read $HOME/.config/templates/BSDlicenseR.txt <cr>
	autocmd FileType sh       nnoremap <localleader>l :0read $HOME/.config/templates/BSDlicenseR.txt <cr>
augroup END

" Open the master .bib file
augroup open_bibfile
	autocmd FileType tex      nnoremap <localleader>B :tabedit /$DPBX/books_papers/tony.bib <cr>
	autocmd FileType plaintex nnoremap <localleader>B :tabedit /$DPBX/books_papers/tony.bib <cr>
	autocmd FileType bib      nnoremap <localleader>B :tabedit /$DPBX/books_papers/tony.bib <cr>
augroup END
" e-mail composition: kill hard wrapping of text
augroup mail_compose
	autocmd FileType mail set textwidth=0
augroup END
" status line definition
set statusline+=%t           " file name
set statusline+=%m           " modification flag
set statusline+=%y           " filetype pf current file
set statusline+=\ buffer:\   " label
set statusline+=%n           " buffer number
set statusline+=%=           " switch to the right side
set statusline+=%c           " column number
set statusline+=/            " separator
set statusline+=%L           " total lines

