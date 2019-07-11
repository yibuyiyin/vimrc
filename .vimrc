" A sensible vimrc for Go development
"
" Please note that the following settings are some default that I used
" for years. However it might be not the case for you (and your
" environment). I highly encourage to change/adapt the vimrc to your own
" needs. Think of a vimrc as a garden that needs to be maintained and fostered
" throughout years. Keep it clean and useful - Fatih Arslan

call plug#begin()
" Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
Plug 'nsf/gocode', { 'rtp': 'vim' }
Plug 'fatih/molokai'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'vim-syntastic/syntastic'
Plug 'posva/vim-vue'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'posva/vim-vue'
Plug 'scrooloose/nerdcommenter'
" sudo yum install -y the_silver_searcher
Plug 'rking/ag.vim'
call plug#end()

""""""""""""""""""""""
"      Settings      "
""""""""""""""""""""""
set nocompatible                " Enables us Vim specific features
filetype off                    " Reset filetype detection first ...
filetype plugin indent on       " ... and enable filetype detection
set ttyfast                     " Indicate fast terminal conn for faster redraw
set ttymouse=xterm2             " Indicate terminal type for mouse codes
set ttyscroll=3                 " Speedup scrolling
set laststatus=2                " Show status line always
set encoding=utf-8              " Set default encoding to UTF-8
set autoread                    " Automatically read changed files
set autoindent                  " Enabile Autoindent
set backspace=indent,eol,start  " Makes backspace key more powerful.
set incsearch                   " Shows the match while typing
set hlsearch                    " Highlight found searches
set noerrorbells                " No beeps
set number                      " Show line numbers
set showcmd                     " Show me what I'm typing
set noswapfile                  " Don't use swapfile
set nobackup                    " Don't create annoying backup files
set splitright                  " Vertical windows should be split to right
set splitbelow                  " Horizontal windows should split to bottom
set autowrite                   " Automatically save before :next, :make etc.
set hidden                      " Buffer should still exist if window is closed
set fileformats=unix,dos,mac    " Prefer Unix over Windows over OS 9 formats
set noshowmatch                 " Do not show matching brackets by flickering
set noshowmode                  " We show the mode with airline or lightline
set ignorecase                  " Search case insensitive...
set smartcase                   " ... but not it begins with upper case
set completeopt=menu,menuone    " Show popup menu, even if there is one entry
set pumheight=10                " Completion window max size
set nocursorcolumn              " Do not highlight column (speeds up highlighting)
set nocursorline                " Do not highlight cursor (speeds up highlighting)
set lazyredraw                  " Wait to redraw
set fdm=manual "indent,syntax,marker,expr,diff
set backupcopy=yes
set wildmenu
set si
set et
set sw=4
set ts=4

" Enable to copy to clipboard for operations like yank, delete, change and put
" http://stackoverflow.com/questions/20186975/vim-mac-how-to-copy-to-clipboard-without-pbcopy
if has('unnamedplus')
  set clipboard^=unnamed
  set clipboard^=unnamedplus
endif

" This enables us to undo files even if you exit Vim.
if has('persistent_undo')
  set undofile
  set undodir=~/.config/vim/tmp/undo//
endif

" Colorscheme
syntax enable
set t_Co=256
let g:rehash256 = 1
let g:molokai_original = 1
colorscheme molokai

""""""""""""""""""""""
"      Mappings      "
""""""""""""""""""""""

" Set leader shortcut to a comma ','. By default it's the backslash
let mapleader = ","

" mac下复制到系统剪贴板
map "+y :w !pbcopy<CR><CR>
map "+p :r !pbpaste<CR><CR> 

" 快速查找文件
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
" 设置过滤不进行查找的后缀名
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn|pyc)$'

" Jump to next error with Ctrl-n and previous error with Ctrl-m. Close the
" quickfix window with <leader>a
map <C-n> :cnext<CR>
map <C-m> :cprevious<CR>
nnoremap <leader>a :cclose<CR>

" Visual linewise up and down by default (and use gj gk to go quicker)
noremap <Up> gk
noremap <Down> gj
noremap j gj
noremap k gk

" Search mappings: These will make it so that going to the next one in a
" search will center on the line it's found in.
nnoremap n nzzzv
nnoremap N Nzzzv

" Act like D and C
nnoremap Y y$

" splitjoin
nmap sj :SplitjoinSplit<cr>
nmap sk :SplitjoinJoin<cr>

" 命令模式按键映射
" cnoremap <C-a> <Home>
" cnoremap <C-e> <End>
" cnoremap <C-p> <Up>
" cnoremap <C-n> <Down>

" 更方便窗口间移动
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" other
nmap j gj
nmap k gk
inoremap jj <ESC>
nnoremap <silent><Leader>j :bp<CR>
nnoremap <silent><Leader>k :bn<CR>
noremap <silent><space> :set hls! hls?<CR>
noremap <silent><Leader>S :set rnu! rnu?<CR>
noremap <silent><Leader>L :set list! list?<CR>
nnoremap <Leader>C @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>

" cscope
" sudo yum install -y cscope
nmap <C-g>s :cs find s <C-R>=expand("<cword>")<CR><CR>
nmap <C-g>g :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-g>c :cs find c <C-R>=expand("<cword>")<CR><CR>
nmap <C-g>t :cs find t <C-R>=expand("<cword>")<CR><CR>
nmap <C-g>e :cs find e <C-R>=expand("<cword>")<CR><CR>
nmap <C-g>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <C-g>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap <C-g>d :cs find d <C-R>=expand("<cword>")<CR><CR>

" 多窗口分割是自动调整大小
au VimResized * exe "normal! \<c-w>="

" 解决粘贴时自动补全加注释符的问题
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "no rm $"|endif|endif
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Enter automatically into the files directory
autocmd BufEnter * silent! lcd %:p:h

autocmd FileType html setlocal sw=2 ts=2
autocmd FileType css setlocal sw=2 ts=2
autocmd FileType javascript setlocal sw=2 ts=2
autocmd FileType wxss setlocal sw=2 ts=2
autocmd FileType wxml setlocal sw=2 ts=2

" vue
autocmd FileType vue syntax sync fromstart

"""""""""""""""""""""
"      Plugins      "
"""""""""""""""""""""
" vue
" npm i -g eslint eslint-plugin-vue
" autocmd FileType vue syntax sync fromstart

" airline tab style
let g:airline#extensions#tabline#enabled = 0
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#formatter = 'unique_tail'

" syntastic
set statusline=[%F]%y%r%m%*[%{&encoding}]%=[Line:%l/%L,Column:%c][%p%%]
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1

" php checker
" php静态语法检查
" composer require --dev phpstan/phpstan
" ln -sf $PWD/vendor/bin/phpstan /usr/local/bin
" php代码质量检查
" sudo wget http://static.phpmd.org/php/2.6.0/phpmd.phar -O /usr/local/bin/phpmd

let g:syntastic_python_checkers = ['python', 'python36']
let g:syntastic_php_checkers = ['php', 'phpmd', 'phpstan']
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_css_checkers = ['stylelint']
let g:syntastic_html_checkers=['tidy']
" let g:syntastic_html_checkers=['tidy', 'stylelint']
" let g:syntastic_php_checkers = ['php', 'phpcs', 'phpmd', 'phplint', 'phpstan']

" vim-go
let g:go_fmt_command = "goimports"
let g:go_autodetect_gopath = 1
let g:go_list_type = "quickfix"

let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_generate_tags = 1

" nerdtree
nmap <F5> :NERDTreeToggle<cr>
autocmd VimEnter * NERDTree
let NERDTreeShowBookmarks=1

" nerdcommenter 注释的时候自动加个空格, 强迫症必配
let g:NERDSpaceDelims=1
" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1
" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1
" Enable NERDCommenterToggle to check all selected lines is commented or not 
let g:NERDToggleCheckAllLines = 1

" Open :GoDeclsDir with ctrl-g
nmap <C-g> :GoDeclsDir<cr>
imap <C-g> <esc>:<C-u>GoDeclsDir<cr>

" 修正易错命令
command -bang -nargs=* Q q<bang>
command -bang -nargs=* Wa wa<bang>
command -bang -nargs=* WA wa<bang>
command -bang -nargs=* -complete=file W w<bang> <args>
command -bang -nargs=* -complete=file Wq wq<bang> <args>
command -bang -nargs=* -complete=file WQ wq<bang> <args>

augroup go
  autocmd!

  " Show by default 4 spaces for a tab
  autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4

  " :GoBuild and :GoTestCompile
  autocmd FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>

  " :GoTest
  autocmd FileType go nmap <leader>t  <Plug>(go-test)

  " :GoRun
  autocmd FileType go nmap <leader>r  <Plug>(go-run)

  " :GoDoc
  autocmd FileType go nmap <Leader>d <Plug>(go-doc)

  " :GoCoverageToggle
  autocmd FileType go nmap <Leader>c <Plug>(go-coverage-toggle)

  " :GoInfo
  autocmd FileType go nmap <Leader>i <Plug>(go-info)

  " :GoMetaLinter
  autocmd FileType go nmap <Leader>l <Plug>(go-metalinter)

  " :GoDef but opens in a vertical split
  autocmd FileType go nmap <Leader>v <Plug>(go-def-vertical)
  " :GoDef but opens in a horizontal split
  autocmd FileType go nmap <Leader>s <Plug>(go-def-split)

  " :GoAlternate  commands :A, :AV, :AS and :AT
  autocmd Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
  autocmd Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
  autocmd Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
  autocmd Filetype go command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')
augroup END

" build_go_files is a custom function that builds or compiles the test file.
" It calls :GoBuild if its a Go file, or :GoTestCompile if it's a test file
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" cscope setting 代码跟踪工具
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocscopeverbose
let i = 0
let parent = ''
let g:proj_path = ''
while i < 8
    let g:ide = glob(fnamemodify(parent.".ide", ":p"))
    if strlen(g:ide)> 0
        let g:proj_path = fnamemodify(parent, ":p") 
        break
    endif
    let i += 1
    let parent .= '../'
endwhile

function! BuildTags()
    if g:proj_path == ''
        return 0
    endif
    execute 'silent !find '.g:proj_path.' \( -path .git -prune -o -name "*.php" -o -name "*.py" -o -name "*.phtml" \) -a -type f > '.g:ide.'cscope.files'
    execute 'silent !cscope -bqk -i '.g:ide.'cscope.files -f '.g:ide.'cscope.out'
    execute 'silent :cscope kill  '.g:ide.'cscope.out'
    execute 'silent :cscope add '.g:ide.'cscope.out'
    "execute 'silent !ctags --tag-relative=yes --fields=+iaS --extra=+q -f '.g:ide.'tags -L '.g:ide.'cscope.files'
    return 0
endfunction
call BuildTags()
autocmd BufWritePre *.(php|py) :call BuildTags()

" 加载php类库代码
let phplib_cscope = '/data1/phplib/.ide/cscope.out'
if glob(phplib_cscope) != g:ide.'cscope.out' && g:proj_path != ''
    execute 'silent :cscope add '.phplib_cscope
endif
