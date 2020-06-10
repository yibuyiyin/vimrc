" A sensible vimrc for Go development
"
" Please note that the following settings are some default that I used
" for years. However it might be not the case for you (and your
" environment). I highly encourage to change/adapt the vimrc to your own
" needs. Think of a vimrc as a garden that needs to be maintained and fostered
" throughout years. Keep it clean and useful - Fatih Arslan

function Updates()
  let baseI = line('.')
  let word = expand("<cword>")
  let i = 0
  let start = 0
  let end = 0
  while 1
    exe "normal!j"
    let i += 1
    if i == 1
      exe "normal!f,f d$a ".word.");"
      continue
    endif
    let autoI = i + baseI
    let line_str = getline(autoI)
    if line_str =~ "add("
      let start = start>0 ? start : autoI
      let end = autoI
    else
      break
    endif
  endwhile
  if start > 0
    exe "normal!dd"
    exe start.",".end."s/add(/".word.".add(/g"
    exe "silent :".start.",".end." m ".baseI
  endif
endfunction

nmap <F3> :call Updates()<CR>

call plug#begin()

" 配色方案
" colorscheme neodark
" Plug 'KeitaNakamura/neodark.vim'
" colorscheme monokai
" Plug 'crusoexia/vim-monokai'
" colorscheme github 
" Plug 'acarapetis/vim-colors-github'
" colorscheme one 
" Plug 'rakr/vim-one'
" colorscheme molokai
Plug 'fatih/molokai'

" go 主要插件
Plug 'fatih/vim-go', { 'tag': '*' }
Plug 'nsf/gocode', { 'rtp': 'vim' }

Plug 'AndrewRadev/splitjoin.vim'

" markdown 插件
Plug 'iamcco/mathjax-support-for-mkdp'
Plug 'iamcco/markdown-preview.vim'

" 自动生成代码
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" 文件搜索
Plug 'ctrlpvim/ctrlp.vim'

" 用来提供一个导航目录的侧边栏
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }

" 可以使 nerdtree 的 tab 更加友好些
Plug 'jistr/vim-nerdtree-tabs'

" 可以在导航目录中看到 git 版本信息
Plug 'Xuyuanp/nerdtree-git-plugin'

" 查看当前代码文件中的变量和函数列表的插件，
" 可以切换和跳转到代码中对应的变量和函数的位置
" 大纲式导航, Go 需要 https://github.com/jstemmer/gotags 支持
Plug 'majutsushi/tagbar'

" 自动补全括号的插件，包括小括号，中括号，以及花括号
Plug 'jiangmiao/auto-pairs'

" 代码自动完成，安装完插件还需要额外配置才可以使用
Plug 'Valloric/YouCompleteMe'

" 可以在文档中显示 git 信息
Plug 'airblade/vim-gitgutter'

Plug 'vim-syntastic/syntastic'
Plug 'posva/vim-vue'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'posva/vim-vue'
Plug 'scrooloose/nerdcommenter'

" 可以快速对齐的插件
Plug 'junegunn/vim-easy-align'

" 可以在 vim 中使用 tab 补全
"Plug 'vim-scripts/SuperTab'

" 可以在 vim 中自动完成
"Plug 'Shougo/neocomplete.vim'

" sudo yum install -y the_silver_searcher
" sudo apt install silversearcher-ag
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
set autochdir
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
" colorscheme github
" colorscheme monokai
" colorscheme github 
" colorscheme one 

""""""""""""""""""""""
"      Mappings      "
""""""""""""""""""""""

" Set leader shortcut to a comma ','. By default it's the backslash
let mapleader = ","

if has('win32')
elseif has('unix')
  " linux下复制到系统剪贴板 $ sudo apt-get install xclip
  map "+y :w !xclip -selection c<CR><CR>
elseif has('mac')
  " mac下复制到系统剪贴板
  map "+y :w !pbcopy<CR><CR>
  map "+p :r !pbpaste<CR><CR> 
endif

" 快速查找文件
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
" 设置过滤不进行查找的后缀名
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn|pyc)$'

"==============================================================================
"  Valloric/YouCompleteMe 插件
"==============================================================================

" 配置和 SirVer/ultisnips 冲突的快捷键
let g:ycm_key_list_select_completion = ['<C-n>', '<space>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'

" better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

"==============================================================================
"  其他插件配置
"==============================================================================

" markdwon 的快捷键
map <silent> <F6> <Plug>MarkdownPreview
map <silent> <F7> <Plug>StopMarkdownPreview

" 加载.vimrc
:nn <Leader>vr :source $MYVIMRC<CR>

" tab 标签页切换快捷键
:nn <Leader>1 1gt
:nn <Leader>2 2gt
:nn <Leader>3 3gt
:nn <Leader>4 4gt
:nn <Leader>5 5gt
:nn <Leader>6 6gt
:nn <Leader>7 7gt
:nn <Leader>8 8gt
:nn <Leader>9 8gt
:nn <Leader>0 :tablast<CR>

" " ==== 系统剪切板复制粘贴 ====
" " v 模式下复制内容到系统剪切板
" vmap <Leader>c "+yy
" " n 模式下复制一行到系统剪切板
" nmap <Leader>c "+yy
" " n 模式下粘贴系统剪切板的内容
" nmap <Leader>v "+p

" Jump to next error with Ctrl-n and previous error with Ctrl-m. Close the
" quickfix window with <leader>a
map <C-n> :cnext<CR>
map <C-m> :cprevious<CR>
nnoremap <leader>a :cclose<CR>

" 刷新
nnoremap <leader>f :syntax sync fromstart<CR>

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

" 多窗口分割是自动调整大小
au VimResized * exe "normal! \<c-w>="

autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Enter automatically into the files directory
autocmd BufEnter * silent! lcd %:p:h

autocmd FileType html setlocal sw=2 ts=2
autocmd FileType html syntax sync fromstart
autocmd FileType css setlocal sw=2 ts=2
autocmd FileType css syntax sync fromstart
autocmd FileType javascript setlocal sw=2 ts=2
autocmd FileType javascript syntax sync fromstart
autocmd FileType wxss setlocal sw=2 ts=2
autocmd FileType wxss syntax sync fromstart
autocmd FileType wxml setlocal sw=2 ts=2
autocmd FileType wxml syntax sync fromstart

" vim
autocmd FileType vim setlocal sw=2 ts=2
autocmd FileType vim syntax sync fromstart

" vue
autocmd FileType vue setlocal sw=2 ts=2
autocmd FileType vue syntax sync fromstart

" makefile
autocmd FileType make setlocal sw=8 ts=8 noet
autocmd FileType make syntax sync fromstart

" 退出插入模式指定类型的文件自动保存
au InsertLeave *.go,*.sh,*.php,*.py,*.java write

"""""""""""""""""""""
"      Plugins      "
"""""""""""""""""""""
" vue
" npm i -g eslint eslint-plugin-vue
autocmd FileType vue syntax sync fromstart

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

let g:syntastic_python_checkers = ['python3']
" curl -sS https://getcomposer.org/installer | php
" composer config repo.packagist composer https://packagist.phpcomposer.com
" composer global require phpmd/phpmd
" composer global require phpstan/phpstan
let g:syntastic_php_checkers = ['php', 'phpmd', 'phpstan']
" wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.35.0/install.sh | sh
" nvm install 10.17.0
" npm -g install eslint
let g:syntastic_javascript_checkers = ['eslint']
" npm -g install stylelint
let g:syntastic_css_checkers = ['stylelint']
" sudo apt install tidy
let g:syntastic_html_checkers=['tidy', 'stylelint', 'eslint']
" let g:syntastic_php_checkers = ['php', 'phpcs', 'phpmd', 'phplint', 'phpstan']

" vim-go
let g:go_fmt_command = "goimports"
let g:go_autodetect_gopath = 1
let g:go_list_type = "quickfix"
let g:go_version_warning = 0

let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_generate_tags = 1

" nerdtree
nmap <F5> :NERDTreeToggle<cr>
autocmd VimEnter * NERDTree
" nerdcommenter 注释的时候自动加个空格, 强迫症必配
let g:NERDSpaceDelims=1
" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1
" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1
" Enable NERDCommenterToggle to check all selected lines is commented or not 
let g:NERDToggleCheckAllLines = 1
" 显示行号
let NERDTreeShowLineNumbers=1
" 打开文件时是否显示目录
let NERDTreeAutoCenter=1
" 是否显示隐藏文件
let NERDTreeShowHidden=0
" 设置宽度
" let NERDTreeWinSize=31
" 忽略一下文件的显示
let NERDTreeIgnore=['\.pyc','\~$','\.swp']
" 打开 vim 文件及显示书签列表
let NERDTreeShowBookmarks=2
" 在终端启动vim时，共享NERDTree
let g:nerdtree_tabs_open_on_console_startup=1


" majutsushi/tagbar 插件打开关闭快捷键
nmap <F4> :TagbarToggle<CR>

let g:tagbar_type_go = {
    \ 'ctagstype' : 'go',
    \ 'kinds'     : [
        \ 'p:package',
        \ 'i:imports:1',
        \ 'c:constants',
        \ 'v:variables',
        \ 't:types',
        \ 'n:interfaces',
        \ 'w:fields',
        \ 'e:embedded',
        \ 'm:methods',
        \ 'r:constructor',
        \ 'f:functions'
    \ ],
    \ 'sro' : '.',
    \ 'kind2scope' : {
        \ 't' : 'ctype',
        \ 'n' : 'ntype'
    \ },
    \ 'scope2kind' : {
        \ 'ctype' : 't',
        \ 'ntype' : 'n'
    \ },
    \ 'ctagsbin'  : 'gotags',
    \ 'ctagsargs' : '-sort -silent'
\ }


"==============================================================================
"  nerdtree-git-plugin 插件
"==============================================================================
let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ 'Ignored'   : '☒',
    \ "Unknown"   : "?"
    \ }

let g:NERDTreeShowIgnoredStatus = 1


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
"
if has("cscope")
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

  function! BuildCscope()
    if g:proj_path == ''
      return 0
    endif
    execute 'silent !find '.g:proj_path.' \( -path .git -prune -o -name "*.php" -o -name "*.py" -o -name "*.phtml" \) -a -type f > '.g:ide.'cscope.files'
    " 过滤.gitignore匹配字符不加入cscope，解决非代码文件导致打开慢的问题
    if filereadable(g:proj_path.'.gitignore')
      execute 'silent !grep -F -v -f '.g:proj_path.'.gitignore '.g:ide.'cscope.files > '.g:ide.'cscope.files.tmp; mv '.g:ide.'cscope.files.tmp '.g:ide.'cscope.files'
    endif
    execute 'silent !cscope -bqk -i '.g:ide.'cscope.files -f '.g:ide.'cscope.out'
    execute 'silent :cscope kill  '.g:ide.'cscope.out'
    execute 'silent :cscope add '.g:ide.'cscope.out'
    execute 'silent !rm -f '.g:ide.'tags'
    execute 'silent !ctags --tag-relative=yes --fields=+iaS --extra=+q -f '.g:ide.'tags -L '.g:ide.'cscope.files'
    return 0
  endfunction

  call BuildCscope()
  let phplib_cscope = '/data1/phplib/.ide/cscope.out'
  if glob(phplib_cscope) != g:ide.'cscope.out' && g:proj_path != ''
    execute 'silent :cscope add '.phplib_cscope
  endif

  augroup cscope
    autocmd!
    autocmd BufWritePre *.php,*.py :call BuildCscope()
  augroup END

  " cscope
  " sudo yum install -y cscope
  " sudo apt install -y cscope
  nmap <C-g>s :cs find s <C-R>=expand("<cword>")<CR><CR>
  nmap <C-g>g :cs find g <C-R>=expand("<cword>")<CR><CR>
  nmap <C-g>c :cs find c <C-R>=expand("<cword>")<CR><CR>
  nmap <C-g>t :cs find t <C-R>=expand("<cword>")<CR><CR>
  nmap <C-g>e :cs find e <C-R>=expand("<cword>")<CR><CR>
  nmap <C-g>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
  nmap <C-g>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
  nmap <C-g>d :cs find d <C-R>=expand("<cword>")<CR><CR>
endif

" 解决粘贴时自动补全加注释符的问题
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "no rm $"|endif|endif

