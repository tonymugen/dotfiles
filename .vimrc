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
Plugin 'arcticicestudio/nord-vim'         " Nord color scheme
Plugin 'vim-airline/vim-airline'          " bottom bar
Plugin 'vim-airline/vim-airline-themes'   " themes for the bottom bar
Plugin 'rrethy/vim-hexokinase'            " shows a color as you enter its code
Plugin 'mhinz/vim-startify'               " starting page
Plugin 'junegunn/fzf.vim'                 " fuzzy finder
Plugin 'tpope/vim-fugitive'               " git integration
call vundle#end()

filetype plugin indent on

" YouCompleteMe settings
let g:ycm_extra_conf_globlist = ['~/extra/Dropbox/CppProjects/*','~/extra/Dropbox/BRprojects/*', '~/projects/*']
let g:ycm_key_list_select_completion=['<C-Tab>', '<Down>']
let g:ycm_key_list_previous_completion=['<Up>']
let g:ycm_key_list_stop_completion = ['<Enter>']
let g:ycm_auto_trigger=1
let g:ycm_always_populate_location_list=1
let g:ycm_filetype_whitelist={'cpp': 1, 'c': 1, 'r': 1, 'rnoweb': 1, 'tex': 1, 'plaintex': 1, 'vim': 1, 'sh': 1}
let g:ycm_seed_identifiers_with_syntax=1
let g:ycm_autoclose_preview_window_after_insertion=1
" UltiSnips settings
let g:UltiSnipsExpandTrigger="<Tab>"
let g:UltiSnipsJumpForwardTrigger="<Tab>"
let g:UltiSnipsJumpBackwardTrigger="<S-Tab>"
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
" Color scheme
" bash shell better for non-interactive stuff
set shell=/usr/bin/bash
let mapleader="-"
let maplocalleader="\\"
set termguicolors
" enable scrolling in terminal
set mouse=a
colorscheme nord
let g:nord_underline=1
let g:nord_italic=1
let g:nord_italic_comments=1
let g:nord_uniform_diff_background=1
syntax on
" Keep terminal transparecy; this line must be after syntax on
hi Normal guibg=NONE ctermbg=NONE
set cindent
" both number and nonumber to get the number of the focal line
set number
set relativenumber
" cursor line and column highlighting (default solized8 hard to see)
set cursorline
set cursorcolumn
"highlight CursorLine ctermbg=grey guibg=#003449
"highlight CursorColumn ctermbg=grey guibg=#074664
set hlsearch
set guifont=Menlo\ Nerd\ Font\ 11
" get rid of the toolbar in the GUI
set guioptions-=T
set shiftwidth=4
set tabstop=4
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
nnoremap <Tab> %
" paste
nnoremap <C-p> "+gP
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

" directory explorer (who needs NERDTree?)
let g:netrw_liststyle = 3
let g:netrw_banner = 0
let g:netrw_browse_split = 3
let g:netrw_winsize = 15
nnoremap <leader>d :Vexplore<cr>
" abbrevs
iabbrev adn and
iabbrev teh the
iabbrev tp to
iabbrev texit textit
iabbrev bolsymbol boldsymbol
" comment shortcuts
augroup comment_shortcuts
	autocmd!
	autocmd FileType tex nnoremap <buffer> <localleader>c I%<esc>
	autocmd FileType r nnoremap <buffer> <localleader>c I#<esc>
	autocmd FileType rnoweb nnoremap <buffer> <localleader>c I#<esc>
	autocmd FileType perl nnoremap <buffer> <localleader>c I#<esc>
	autocmd FileType sh nnoremap <buffer> <localleader>c I#<esc>
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
	autocmd FileType cpp      set spell spelllang=en_us
augroup END

" typesetting/compilation shortcuts
" NOTE: these are rather specific to my personal set-up and file naming scheme
augroup compile_shortcuts
	autocmd!
	autocmd FileType tex nnoremap <localleader>t :!pdflatex %<cr>
	autocmd FileType plaintex nnoremap <localleader>t :!pdflatex %<cr>
	autocmd FileType tex nnoremap <localleader>p :execute "!GDK_SCALE=2 zathura " . split(expand('%'), '\.')[0] . ".pdf &"<cr>
	autocmd FileType plaintex nnoremap <localleader>p :execute "!GDK_SCALE=2 zathura " . split(expand('%'), '\.')[0] . ".pdf &"<cr>
	autocmd FileType tex nnoremap <localleader>b :execute "!bibtex " . split(expand('%'), '\.')[0]<cr>
	autocmd FileType plaintex nnoremap <localleader>b :execute "!bibtex " . split(expand('%'), '\.')[0]<cr>
	autocmd FileType rnoweb nnoremap <localleader>r :!R CMD Sweave %<cr>
	autocmd FileType rnoweb nnoremap <localleader>t :execute "!pdflatex " . split(expand('%'), '\.')[0] . ".tex"<cr>
	autocmd FileType rnoweb nnoremap <localleader>p :execute "!GDK_SCALE=2 zathura " . split(expand('%'), '\.')[0] . ".pdf &"<cr>
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
	autocmd FileType rnoweb nnoremap <localleader>g :0read $HOME/.config/templates/plotTemplate.Rnw <cr>
	" insert ggplot2 PDF figure
	autocmd FileType rnoweb nnoremap <localleader>f :.-1read $HOME/.config/templates/ggPDFplot.Rnw <cr>
	" insert histogram ggplot2 PDF
	autocmd FileType rnoweb nnoremap <localleader>h :.-1read $HOME/.config/templates/ggHistPDF.Rnw <cr>
	" insert TeX starter template
	autocmd FileType plaintex nnoremap <localleader>d :.-1read $HOME/.config/templates/texTemplate.tex <cr>
	autocmd FileType tex nnoremap <localleader>d :.-1read $HOME/.config/templates/texTemplate.tex <cr>
	" insert BSD license
	autocmd FileType cpp nnoremap <localleader>l :0read $HOME/.config/templates/BSDlicense.txt <cr>
	autocmd FileType r nnoremap <localleader>l :0read $HOME/.config/templates/BSDlicenseR.txt <cr>
	autocmd FileType sh nnoremap <localleader>l :0read $HOME/.config/templates/BSDlicenseR.txt <cr>
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

