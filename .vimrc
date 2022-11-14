"开启高亮
syntax on

"设置tab为4个空格
set ts=4

"显示行号
set nu

"显示相对行号
set relativenumber

"设置字不会超出屏幕，会换行显示
set wrap

"用浅色高亮当前行
"autocmd InsertLeave * se nocul
"autocmd InsertEnter * se cul
"set cursorline

"显示标尺
"set ruler

"显示自己输入的命令
set showcmd

"在输入命令时,按tab会有选项提示
set wildmenu

"去掉vi一致性模式以避免bug
set nocompatible

"禁止生成临时文件
set nobackup
set noswapfile

"utf-8编码
set enc=utf-8

"高亮匹配括号
"set showmatch

"C程序提供自动缩进
set smartindent

"设置一次缩进为1个tab
set shiftwidth=4

"搜索高亮
set hlsearch

"搜索输入时高亮同步
set incsearch

"搜索忽略大小写
set ignorecase

"显示末尾空格
"set list
"set listchars=tab:▸\ ,trail:♪

"强制开头和末尾保留8行
set scrolloff=8

"启用鼠标
set mouse=a
set selection=exclusive
set selectmode=mouse,key

"普通模式下快捷键，ff是格式化代码
nnoremap <c-s> <ESC>:w<CR>
nnoremap <c-z> <ESC>u
nnoremap ff <ESC>gg=Gg

"快速光标前进
nnoremap <s-j> 5j
nnoremap <s-k> 5k
nnoremap <s-l> 5l
nnoremap <s-h> 5h

vnoremap <s-j> 5j
vnoremap <s-k> 5k
vnoremap <s-l> 5l
vnoremap <s-h> 5h

"插入模式下快捷键
inoremap <c-s> <ESC>:w<CR>i

"括号引号小于号自动配对
inoremap { {}<ESC>i
inoremap } <c-r>=ClosePair('}')<CR>

inoremap ( ()<ESC>i
inoremap ) <c-r>=ClosePair(')')<CR>

inoremap [ []<ESC>i
inoremap ] <c-r>=ClosePair(']')<CR>

inoremap < <><ESC>i
inoremap > <c-r>=ClosePair('>')<CR>

inoremap " ""<ESC>i

inoremap ' ''<ESC>i

"自动删除一对括号
inoremap <BS> <c-r>=DelPair()<CR>

func ClosePair(char)
	if getline('.')[col('.') - 1] == a:char
		return "\<Right>"
	else
		return a:char
	endif
endfunc

func DelPair()
	let a =	getline('.')[col('.') - 2]
	let b =	getline('.')[col('.') - 1] 
	if ((a == '{') && (b == '}')) || ((a == '(') && (b == ')')) || ((a == '[') && (b == ']')) || ((a == '<') && (b == '>')) || ((a == '"') && (b == '"')) || ((a == "'") && (b == "'")) 
		return "\<ESC>xxi"
	else
		return "\<BS>"
	endif
endfunc

"如果在一对大括号中间发生换行，那就像ide一样自动缩进
inoremap <CR> <c-r>=EnterPair()<CR><c-r>=AutoTab()<CR>

func EnterPair()
	if (getline('.')[col('.') - 1] == '}') && (getline('.')[col('.') - 2] == '{')
		return "\<CR>\<CR>\<Left>\<Del>\<Up>$"
	else
		return "\<CR>"
	endif
endfunc 
func AutoTab()
	if (getline('.')[col('.') - 2] != '$')
		return ""
	endif
	let i = 0
	let s = "\<BS>\<Tab>"
	while (getline(line('.') + 1)[i] == "\<Tab>")
		let s .= "\<Tab>"
		let i += 1
	endwhile
	return s 
endfunc
