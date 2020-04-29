" Vundle stuff
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'Valloric/YouCompleteMe'           " C++ syntax completion
Plugin 'octol/vim-cpp-enhanced-highlight' " C++ syntax highlights
Plugin 'SirVer/ultisnips'                 " Custom syntax completion
Plugin 'honza/vim-snippets'               " Pre-sets for Ultisnips
Plugin 'lifepillar/vim-solarized8'        " Color scheme
Plugin 'vim-airline/vim-airline'          " bottom bar
Plugin 'vim-airline/vim-airline-themes'   " themes for the bottom bar
Plugin 'rrethy/vim-hexokinase'            " shows a color as you enter its code
Plugin 'mhinz/vim-startify'               " starting page
call vundle#end()

filetype plugin indent on

let g:ycm_extra_conf_globlist = ['~/extra/Dropbox/CppProjects/*','~/extra/Dropbox/BRprojects/*', '~/projects/*']
"set completeopt-=preview " required to quell a problem where insert mode is disabled after completion
" UltiSnips settings
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"
" YouCompleteMe settings
let g:ycm_key_list_select_completion=['<Down>']
let g:ycm_key_list_previous_completion=['<Up>']
let g:ycm_key_list_stop_completion = ['<Enter>']
let g:ycm_auto_trigger=1
let g:ycm_always_populate_location_list=1
let g:ycm_filetype_whitelist={'cpp': 1, 'r': 1, 'rnoweb': 1, 'tex': 1, 'latex': 1, 'vim': 1}
let g:ycm_seed_identifiers_with_syntax=1
let g:ycm_autoclose_preview_window_after_insertion=1

let g:cpp_member_variable_highlight=1
let g:cpp_class_scope_highlight=1
let g:cpp_class_decl_highlight=1

" Color visualization
let g:Hexokinase_highlighters = [ 'background' ]
let g:Hexokinase_optInPatterns = 'full_hex,rgb,rgba,hsl,hsla'
" bottom bar
let g:airline_theme='solarized'
let g:airline_solarized_bg='dark'
let g:airline_powerline_fonts=1
" Color scheme
let g:solarized_termtrans=1
" bash shell better for non-interactive stuff
set shell=/usr/bin/bash
let mapleader="-"
let maplocalleader="\\"
set termguicolors
" enable scrolling in terminal
set mouse=a
set background=dark
colorscheme solarized8
syntax on
set cindent
" both number and nonumber to get the number of the focal line
set number
set relativenumber
" cursor line and column highlighting (default solized8 hard to see)
set cursorline
set cursorcolumn
highlight CursorLine ctermbg=grey guibg=#003449
highlight CursorColumn ctermbg=grey guibg=#074664
set hlsearch
set guifont=Menlo\ Nerd\ Font\ 11
" get rid of the toolbar in the GUI
set guioptions-=T
set shiftwidth=4
set tabstop=4
"set textwidth=90
"set colorcolumn=+1
set linebreak
" cursor appearance in different modes
let &t_SI = "\<Esc>[6 q"
let &t_SR = "\<Esc>[4 q"
let &t_EI = "\<Esc>[2 q"
" for quick switching back to normal mode
set timeoutlen=1000 ttimeoutlen=0
" completion in the gutter
set wildmode=longest,list,full
" key remaps
" crtl-s to save from insert mode
inoremap <C-s> <C-\><C-o>:w<CR>
" remap end of line and beginning of line from insert mode
inoremap <S-Left> <Home>
inoremap <S-Right> <End>
" Remap moving between tabs
inoremap <C-h> :tabprevious<CR>
nnoremap <C-h> :tabprevious<CR>
inoremap <C-l> :tabnext<CR>
nnoremap <C-l> :tabnext<CR>
" clear search highlights
nnoremap <leader>cl :nohl<CR>
" paste
nnoremap <C-p> "+gP
" copy to clipboard
vnoremap <C-y> "+y
" Opening and sourcing .vimrc
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
" Toggling color preview
nnoremap <leader>hx :HexokinaseToggle<cr>
" directory explorer (who needs NERDTree?)
let g:netrw_liststyle = 3
let g:netrw_banner = 0
let g:netrw_browse_split = 3
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
set nospell
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

