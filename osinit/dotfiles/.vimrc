" Vim Plug automatic installation (https://github.com/junegunn/vim-plug/wiki/faq#automatic-installation)
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

" Plugins
call plug#begin('~/.vim/plugged')
    " Color schemes
    Plug 'vim-scripts/wombat256.vim'

    " Core plugins
    Plug 'vim-airline/vim-airline'
    Plug 'scrooloose/nerdtree'
    Plug 'sjl/gundo.vim'
    Plug 'gcmt/taboo.vim'

    " Git
    Plug 'tpope/vim-fugitive'
    Plug 'airblade/vim-gitgutter'

    " Language specific
    Plug 'jmcantrell/vim-virtualenv', {'for': 'python'}
    Plug 'plasticboy/vim-markdown', {'for': 'markdown'}
call plug#end()

" Theme and personal overrides
syntax enable
set t_Co=256
silent! color wombat256mod
hi link NonText NONE
hi Normal ctermbg=233
hi SpecialKey ctermbg=233 ctermfg=18
hi ColorColumn ctermbg=234
hi CursorLine ctermbg=234

" Keybindings
let mapleader=","
nnoremap ,, ,
inoremap jk <esc>

" Tabs and Windows
nnoremap <A-h> gT
nnoremap <A-l> gt
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
" For iTerm2
map ˙ <A-h>
map ¬ <A-l>

" Moving lines
nnoremap <A-k> :m .-2<CR>==
nnoremap <A-j> :m .+1<CR>==
inoremap <A-k> <Esc>:m .-2<CR>==gi
inoremap <A-j> <Esc>:m .+1<CR>==gi
vnoremap <A-k> :m '<-2<CR>gv=gv
vnoremap <A-j> :m '>+1<CR>gv=gv
" For iTerm2
map ˚ <A-k>
map ∆ <A-j>

" Leader shortcuts
nnoremap <silent> <leader>ce :tabe $MYVIMRC<CR>
nnoremap <silent> <leader>cs :w<cr> :so $MYVIMRC<CR>

nnoremap <leader><space> :noh<CR>
nnoremap <leader>v :vnew<cr>
nnoremap <leader>t :tabe<cr>

noremap <leader>se :set expandtab!<CR>
noremap <leader>sn :set number!<CR>
noremap <leader>sw :set wrap!<cr>
noremap <leader>sl :set list!<cr>

noremap <leader>. <esc>:q<cr>
noremap <leader>/ <esc>:wa<cr>
noremap <leader>' <esc>:qa<cr>

" Miscellaneous shortcuts
set pastetoggle=<F2>
cnoremap w!! w !sudo tee % >/dev/null
nnoremap j gj
nnoremap k gk
nnoremap Y y$
nnoremap > >>
nnoremap < <<
vnoremap > >gv
vnoremap < <gv
nnoremap ; :
vnoremap ; :

" Appearance
set number
set nowrap
set colorcolumn=80,120
set cursorline
set cursorcolumn
set nolist
set listchars=tab:▸\ ,trail:⋅,extends:#
set showmode
set scrolloff=10
set mat=2

" Behavior
set backspace=2
set whichwrap+=<,>,h,l
set mouse=a

" Searching and highlighting
set ignorecase
set smartcase
set hlsearch
set incsearch
set gdefault

" Windows, buffers, and tabs
set splitbelow
set splitright
set hidden


" Tabs and indentation
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set smartindent
set autoindent
set copyindent

" Code folding
set foldmethod=indent
"set foldnestmax=2
set nofoldenable
set foldlevel=2

" Statusline
set laststatus=2
set statusline=%m\ B%n\ %<%f\ %y%h%r%w%=L%l\ /\ %L\ C%c%V\ %P

" Autocommands
aug OpenHelpInNewTab
    au!
    au BufWinEnter * if &filetype == "help" && histget("cmd") !~ "^vert" | wincmd T
aug end

" Backups and undo
set backup
set writebackup
set swapfile
set undofile

" Miscellaneous
set dictionary=/usr/share/dict/words
set viminfo='100,<1000,s10,h

" Initialize dires for backups and undo
function! InitDirs()
    if has('win32') || has('win32unix') "windows/cygwin
        let l:separator = '_'
    else
        let l:separator = '.'
    endif

    let l:parent = $HOME . '/' . l:separator . 'vim/'
    let l:dirs = [
        \ ['backupdir', l:parent . 'backup'],
        \ ['directory', l:parent . 'tmp'],
        \ ['undodir', l:parent . 'undo']]

    if exists('*mkdir')
        for l:dir in [['', l:parent]] + l:dirs
            if !isdirectory(l:dir[1])
                call mkdir(l:dir[1])
            endif
        endfor
    endif

    for l:dir in l:dirs
        if isdirectory(l:dir[1])
            execute 'set ' . l:dir[0] . '=' . escape(l:dir[1], ' ') . '//,.'
        else
            echo 'Warning: Unable to create directory:' l:dir[1]
            execute 'set ' . l:dir[0] . '=.'
        endif
    endfor
endfunction
call InitDirs()
