" Vundle stuff
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'octol/vim-cpp-enhanced-highlight'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'lifepillar/vim-solarized8'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
call vundle#end()

filetype plugin indent on

let g:ycm_extra_conf_globlist = ['~/extra/Dropbox/CppProjects/*','~/extra/Dropbox/BRprojects/*', '~/projects/*']
set completeopt-=preview " required to quell a problem where insert mode is disabled after completion
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:ycm_key_list_select_completion=[]
let g:ycm_key_list_previous_completion=[]
let g:ycm_always_populate_location_list=1
let g:cpp_member_variable_highlight=1
let g:cpp_class_scope_highlight=1
let g:cpp_class_decl_highlight=1

" bottom bar
let g:airline_theme='solarized'
let g:airline_solarized_bg='dark'

let mapleader="-"
let maplocalleader="\\"
set background=dark
colorscheme solarized8
syntax on
set cindent
" both number and nonumber to get the number of the focal line
set number
set relativenumber
set cursorline
set hlsearch
set guifont=Menlo\ Regular\ 11
"set guifont=Menlo\ Regular\ 11
" get rid of the toolbar
set guioptions-=T
set shiftwidth=4
set tabstop=4
"set textwidth=90
"set colorcolumn=+1
set linebreak
" key remaps
" crtl-s to save from insert mode
inoremap <C-s> <C-\><C-o>:w<CR>
" remap end of line and beginning of line from insert mode
inoremap <S-Left> <Home>
inoremap <S-Right> <End>
" clear search highlights
nnoremap <leader>cl :nohl<CR>
" paste
nnoremap <C-p> "+gP
" copy to clipboard
vnoremap <C-y> "+y
" Opening and sourcing .vimrc
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
" abbrevs
iabbrev adn and
iabbrev teh the
iabbrev tp to
iabbrev texit textit
iabbrev bolsymbol boldsymbol
" comment shortcuts
augroup comment_shotcuts
	autocmd!
	autocmd FileType tex nnoremap <buffer> <localleader>c I%<esc>
	autocmd FileType cpp nnoremap <buffer> <localleader>c I//<esc>
augroup END
" set spellcheckers
augroup set_spell
	autocmd!
	autocmd FileType tex    set spell spelllang=en_us
	autocmd FileType rnoweb set spell spelllang=en_us
	autocmd FileType mkd    set spell spelllang=en_us
augroup END

" typesetting/compilation shortcuts
augroup compile_shortcuts
	autocmd!
	autocmd FileType tex nnoremap <localleader>t :!pdflatex %<cr>
augroup END

" moving around in C++ files
augroup cpp_movement
	autocmd!
	autocmd FileType cpp nnoremap <localleader>n :lnext <cr>
	autocmd FileType cpp nnoremap <localleader>p :lprevious <cr>
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

