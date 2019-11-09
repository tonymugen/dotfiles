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
let g:airline_powerline_fonts=1

let mapleader="-"
let maplocalleader="\\"
set background=dark
colorscheme solarized8
syntax on
hi Normal ctermbg=NONE
set cindent
" both number and nonumber to get the number of the focal line
set number
set relativenumber
set cursorline
set hlsearch
set guifont=Menlo\ Nerd\ Font\ 11
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
" directory explorer (who needs NERDTree?)
let g:netrw_liststyle = 3
let g:netrw_banner = 0
let g:netrw_browse_split = 3
augroup project
	autocmd!
	autocmd StdinReadPre * let s:std_in=1
	autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | Vexplore | endif
	autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | execute 'Vexplore' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif
augroup END
nnoremap <leader>d :Vexplore<cr>
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
	autocmd FileType tex      set spell spelllang=en_us
	autocmd FileType rnoweb   set spell spelllang=en_us
	autocmd FileType mkd      set spell spelllang=en_us
	autocmd FileType markdown set spell spelllang=en_us
	autocmd FileType text     set spell spelllang=en_us
	autocmd FileType mail     set spell spelllang=en_us
augroup END

" typesetting/compilation shortcuts
" NOTE: these are rather specific to my personal set-up and file naming scheme
augroup compile_shortcuts
	autocmd!
	autocmd FileType tex nnoremap <localleader>t :!pdflatex %<cr>
	autocmd FileType plaintex nnoremap <localleader>t :!pdflatex %<cr>
	autocmd FileType tex nnoremap <localleader>p :execute "!zathura " . split(expand('%'), '\.')[0] . ".pdf &"<cr>
	autocmd FileType plaintex nnoremap <localleader>p :execute "!zathura " . split(expand('%'), '\.')[0] . ".pdf &"<cr>
	autocmd FileType tex nnoremap <localleader>b :execute "!bibtex " . split(expand('%'), '\.')[0]<cr>
	autocmd FileType plaintex nnoremap <localleader>b :execute "!bibtex " . split(expand('%'), '\.')[0]<cr>
	autocmd FileType tex nnoremap <localleader>x :execute "!xelatex " . split(expand('%'), '\.')[0]<cr>
	autocmd FileType plaintex nnoremap <localleader>x :execute "!xelatex " . split(expand('%'), '\.')[0]<cr>
	autocmd FileType rnoweb nnoremap <localleader>r :!R CMD Sweave %<cr>
	autocmd FileType rnoweb nnoremap <localleader>t :execute "!pdflatex " . split(expand('%'), '\.')[0] . ".tex"<cr>
	autocmd FileType rnoweb nnoremap <localleader>p :execute "!zathura " . split(expand('%'), '\.')[0] . ".pdf &"<cr>
augroup END

" moving around in C++ files
augroup cpp_movement
	autocmd!
	" next and previous compiler error
	autocmd FileType cpp nnoremap <localleader>n :lnext <cr>
	autocmd FileType cpp nnoremap <localleader>p :lprevious <cr>
augroup END

augroup insert_templates
	autocmd!
	" insert ggplot2 .Rnw header template
	autocmd FileType rnoweb nnoremap <localleader>g :0read $HOME/.config/templates/plotTemplate.Rnw <cr>
	autocmd FileType rnoweb inoremap ;g <esc>:0read $HOME/.config/templates/plotTemplate.Rnw <cr>
	" insert ggplot2 PDF figure
	autocmd FileType rnoweb nnoremap <localleader>f :.-1read $HOME/.config/templates/ggPDFplot.Rnw <cr>
	autocmd FileType rnoweb inoremap ;f <esc>:.-1read $HOME/.config/templates/ggPDFplot.Rnw <cr>
	" insert histogram ggplot2 PDF
	autocmd FileType rnoweb nnoremap <localleader>h :.-1read $HOME/.config/templates/ggHistPDF.Rnw <cr>
	autocmd FileType rnoweb inoremap ;h <esc>:.-1read $HOME/.config/templates/ggHistPDF.Rnw <cr>
	" insert TeX starter template
	autocmd FileType plaintex nnoremap <localleader>d :.-1read $HOME/.config/templates/texTemplate.tex <cr>
	autocmd FileType tex nnoremap <localleader>d :.-1read $HOME/.config/templates/texTemplate.tex <cr>
	autocmd FileType plaintex inoremap ;d <esc>:.-1read $HOME/.config/templates/texTemplate.tex <cr>
	autocmd FileType tex inoremap ;d <esc>:.-1read $HOME/.config/templates/texTemplate.tex <cr>
	" insert Beamer starter template
	autocmd FileType plaintex nnoremap <localleader>B :.-1read $HOME/.config/templates/beamerTemplate.tex <cr>
	autocmd FileType tex nnoremap <localleader>B :.-1read $HOME/.config/templates/beamerTemplate.tex <cr>
	autocmd FileType plaintex inoremap ;B <esc>:.-1read $HOME/.config/templates/beamerTemplate.tex <cr>
	autocmd FileType tex inoremap ;B <esc>:.-1read $HOME/.config/templates/beamerTemplate.tex <cr>
	" insert slide
	autocmd FileType plaintex nnoremap <localleader>s :.-1read $HOME/.config/templates/oneSlide.tex <cr>
	autocmd FileType tex nnoremap <localleader>s :.-1read $HOME/.config/templates/oneSlide.tex <cr>
	autocmd FileType plaintex inoremap ;s <esc>:.-1read $HOME/.config/templates/oneSlide.tex <cr>
	autocmd FileType tex inoremap ;s <esc>:.-1read $HOME/.config/templates/oneSlide.tex <cr>
	" insert BSD license
	autocmd FileType cpp nnoremap <localleader>l :0read $HOME/.config/templates/BSDlicense.txt <cr>
	autocmd FileType cpp inoremap ;l <esc>:0read $HOME/.config/templates/BSDlicense.txt <cr>
	autocmd FileType r nnoremap <localleader>l :0read $HOME/.config/templates/BSDlicenseR.txt <cr>
	autocmd FileType r inoremap ;l <esc>:0read $HOME/.config/templates/BSDlicenseR.txt <cr>
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

