"打开行号
set nu!
"自动折行
set wrap
"TAB距离
set tabstop=3
set softtabstop=3
set shiftwidth=3
set expandtab
set cindent
"颜色类型
colorscheme desert


" 设置编码
set encoding=utf-8
set fileencodings=utf-8,chinese,latin-1
if has("win32")
   set fileencoding=chinese
else
   set fileencoding=utf-8
endif

"解决consle输出乱码
language messages zh_CN.utf-8

" 设置文件编码检测类型及支持格式
set fencs=utf-8,gbk,ucs-bom,gb18030,gb2312,cp936
" 指定菜单语言
"set langmenu=zh_CN.utf-8
"source $VIMRUNTIME/delmenu.vim
"source $VIMRUNTIME/menu.vim
set guifont=Envy\ Code\ R\ 12
"set guifontwide=新宋体:h10:cGB2312


" 隐藏工具条
"
" see :help 'guioptions'
"
set guioptions-=T
"set guioptions-=m

"
" 状态条，显示字节数，列数，行数，当前行等信息
"
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]
set laststatus=2 " always show the status line



"帮助语言
set helplang=cn
set iskeyword+=

map <S-Right> :tabnext<CR>
map <S-Left> :tabprev<CR>



