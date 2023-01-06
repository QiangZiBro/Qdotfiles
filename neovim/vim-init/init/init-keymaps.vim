"======================================================================
"
" init-keymaps.vim - 按键设置，按你喜欢更改
"
"   - 快速移动
"   - 标签切换
"   - 窗口切换
"   - 终端支持
"   - 编译运行
"   - 符号搜索
"======================================================================
" vim: set ts=4 sw=4 tw=78 noet :


map s <nop>
"----------------------------------------------------------------------
" Leader键相关配置
"----------------------------------------------------------------------
let mapleader = " "
" nnoremap R :source $MYVIMRC<cr>
nnoremap <leader>ev :e ~/.Qdotfiles/neovim/vim-init/init<cr>
nnoremap <leader>w :w<cr>
nnoremap <leader>q :q<cr>
nnoremap <leader><cr> :set nohlsearch<cr>
" Find files using Telescope command-line sugar.
nnoremap <leader>f <cmd>Telescope find_files<cr>
nnoremap <leader>g <cmd>Telescope live_grep<cr>
nnoremap <Leader>s :<C-u>call gitblame#echo()<CR>
"----------------------------------------------------------------------
" INSERT 模式下使用 EMACS 键位
"----------------------------------------------------------------------
inoremap <c-a> <home>
inoremap <c-e> <end>
inoremap <c-d> <del>
inoremap <c-_> <c-k>

"----------------------------------------------------------------------
" 设置 CTRL+HJKL 移动光标（INSERT 模式偶尔需要移动的方便些）
" 使用 SecureCRT/XShell 等终端软件需设置：Backspace sends delete
" 详见：http://www.skywind.me/blog/archives/2021
"----------------------------------------------------------------------
noremap <C-h> <left>
noremap <C-j> <down>
noremap <C-k> <up>
noremap <C-l> <right>
inoremap <C-h> <left>
inoremap <C-j> <down>
inoremap <C-k> <up>
inoremap <C-l> <right>

"----------------------------------------------------------------------
" 命令模式的快速移动
"----------------------------------------------------------------------
cnoremap <c-h> <left>
cnoremap <c-j> <down>
cnoremap <c-k> <up>
cnoremap <c-l> <right>
cnoremap <c-a> <home>
cnoremap <c-e> <end>
cnoremap <c-f> <c-d>
cnoremap <c-b> <left>
cnoremap <c-d> <del>
cnoremap <c-_> <c-k>

"----------------------------------------------------------------------
" <leader>+数字键 切换tab
"----------------------------------------------------------------------
noremap <silent><leader>1 1gt<cr>
noremap <silent><leader>2 2gt<cr>
noremap <silent><leader>3 3gt<cr>
noremap <silent><leader>4 4gt<cr>
noremap <silent><leader>5 5gt<cr>
noremap <silent><leader>6 6gt<cr>
noremap <silent><leader>7 7gt<cr>
noremap <silent><leader>8 8gt<cr>
noremap <silent><leader>9 9gt<cr>
noremap <silent><leader>0 10gt<cr>

"----------------------------------------------------------------------
" TAB：创建，关闭，上一个，下一个，左移，右移
" 其实还可以用原生的 CTRL+PageUp, CTRL+PageDown 来切换标签
"----------------------------------------------------------------------
noremap <silent>tn :tabnew<cr>
noremap <silent> tj :tabnext<cr>
noremap <silent> tk :tabprev<cr>
noremap <silent> tl :tabnext<cr>
noremap <silent> th :tabprev<cr>
noremap <silent> to :tabonly<cr>


" 左移 tab
function! Tab_MoveLeft()
	let l:tabnr = tabpagenr() - 2
	if l:tabnr >= 0
		exec 'tabmove '.l:tabnr
	endif
endfunc

" 右移 tab
function! Tab_MoveRight()
	let l:tabnr = tabpagenr() + 1
	if l:tabnr <= tabpagenr('$')
		exec 'tabmove '.l:tabnr
	endif
endfunc

noremap <silent><leader>th :call Tab_MoveLeft()<cr>
noremap <silent><leader>tl :call Tab_MoveRight()<cr>
noremap <silent><leader>tk :call Tab_MoveLeft()<cr>
noremap <silent><leader>tj :call Tab_MoveRight()<cr>
"----------------------------------------------------------------------
" 窗口分隔：s+hjkl
"----------------------------------------------------------------------
map sl :set splitright<CR>:vsplit<CR>
map sh :set nosplitright<CR>:vsplit<CR>
map sk :set nosplitbelow<CR>:split<CR>
map sj :set splitbelow<CR>:split<CR>

"----------------------------------------------------------------------
" 窗口切换：<leader>+hjkl
" 窗口大小：上下左右
"----------------------------------------------------------------------
noremap <leader>h <c-w>h
noremap <leader>l <c-w>l
noremap <leader>j <c-w>j
noremap <leader>k <c-w>k
noremap <up> :res+5<CR>
noremap <down> :res-5<CR>
noremap <left> :vertical :res-5<CR>
noremap <right> :vertical :res+5<CR>

"----------------------------------------------------------------------
" 编译运行 C/C++ 项目
" 详细见：http://www.skywind.me/blog/archives/2084
"----------------------------------------------------------------------

"" 自动打开 quickfix window ，高度为 6
let g:asyncrun_open = 6

" 任务结束时候响铃提醒
let g:asyncrun_bell = 1

" 设置 F10 打开/关闭 Quickfix 窗口
nnoremap <F10> :call asyncrun#quickfix_toggle(6)<cr>

"" F9 编译 C/C++ 文件
"nnoremap <silent> <F9> :AsyncRun gcc -Wall -O2 "$(VIM_FILEPATH)" -o "$(VIM_FILEDIR)/$(VIM_FILENOEXT)" <cr>

" F5 运行文件
nnoremap <silent> <F5> :call ExecuteFile('host')<cr>
nnoremap <silent> <S-F5> :call ExecuteFile('choose-container')<cr>
nnoremap <silent> <leader><F5> :call ExecuteFile('container')<cr>
"" F7 编译项目
"nnoremap <silent> <F7> :AsyncRun -cwd=<root> make <cr>
"
"" F8 运行项目
"nnoremap <silent> <F8> :AsyncRun -cwd=<root> -raw make run <cr>
"
"" F6 测试项目
"nnoremap <silent> <F6> :AsyncRun -cwd=<root> -raw make test <cr>
"
"" 更新 cmake
"nnoremap <silent> <F4> :AsyncRun -cwd=<root> cmake . <cr>

" Windows 下支持直接打开新 cmd 窗口运行
" if has('win32') || has('win64')
" 	nnoremap <silent> <F8> :AsyncRun -cwd=<root> -mode=4 make run <cr>
" endif


"----------------------------------------------------------------------
" tasks
"----------------------------------------------------------------------
nnoremap <silent> <leader>tt :Leaderf --nowrap task<cr>
"----------------------------------------------------------------------
" tags
"----------------------------------------------------------------------
map <F4> :Tagbar<cr>
"----------------------------------------------------------------------
" F5 运行当前文件：根据文件类型判断方法，并且输出到 quickfix 窗口
"----------------------------------------------------------------------
function! ExecuteFile(choice='host')
	let cmd = ''
	if index(['c'], &ft) >= 0
		" native 语言，把当前文件名去掉扩展名后作为可执行运行
		" 写全路径名是因为后面 -cwd=? 会改变运行时的当前路径，所以写全路径
		" 加双引号是为了避免路径中包含空格
		let cmd = 'gcc "$(VIM_FILEPATH)" -o "$(VIM_FILEDIR)/$(VIM_FILENOEXT)" && "$(VIM_FILEDIR)/$(VIM_FILENOEXT)"'
	elseif &ft == 'cpp'
		let cmd = 'g++ -std=c++17 "$(VIM_FILEPATH)" -o "$(VIM_FILEDIR)/$(VIM_FILENOEXT)" && "$(VIM_FILEDIR)/$(VIM_FILENOEXT)"'
	elseif &ft == 'python'
		let $PYTHONUNBUFFERED=1 " 关闭 python 缓存，实时看到输出
		let cmd = 'python3 $(VIM_FILEPATH)'
	elseif &ft == 'zsh'
		let cmd = 'zsh $(VIM_FILEPATH)'
	elseif &ft == 'sh'
		let cmd = 'bash $(VIM_FILEPATH)'
	else
		return
	endif
	" Windows 下打开新的窗口 (-mode=4) 运行程序，其他系统在 quickfix 运行
	" -raw: 输出内容直接显示到 quickfix window 不匹配 errorformat
	" -save=2: 保存所有改动过的文件
	" -cwd=$(VIM_FILEDIR): 运行初始化目录为文件所在目录
	if has('win32') || has('win64')
		exec 'AsyncRun -cwd=$(VIM_FILEDIR) -raw -save=2 -mode=4 '. cmd
	else
		if a:choice == 'host'
			exec 'AsyncRun -mode=term -pos=floaterm -cwd=$(VIM_FILEDIR) -save=2 ' cmd
		elseif a:choice == 'container'
			exec 'AsyncRun -mode=term -pos=floaterm -cwd=$(VIM_FILEDIR) -save=2 ~/.Qdotfiles/bin/d' cmd
		elseif a:choice == 'choose-container'
			exec 'AsyncRun -mode=term -pos=floaterm -cwd=$(VIM_FILEDIR) -save=2 ~/.Qdotfiles/bin/d -a' cmd
		endif
	endif
endfunc

"----------------------------------------------------------------------
" F2 在项目目录下 Grep 光标下单词，默认 C/C++/Py/Js ，扩展名自己扩充
" 支持 rg/grep/findstr ，其他类型可以自己扩充
" 不是在当前目录 grep，而是会去到当前文件所属的项目目录 project root
" 下面进行 grep，这样能方便的对相关项目进行搜索
"----------------------------------------------------------------------
" if executable('rg')
" 	noremap <silent><F2> :AsyncRun! -cwd=<root> rg -n --no-heading 
" 				\ --color never -g *.h -g *.c* -g *.py -g *.js -g *.vim 
" 				\ <C-R><C-W> "<root>" <cr>
" elseif has('win32') || has('win64')
" 	noremap <silent><F2> :AsyncRun! -cwd=<root> findstr /n /s /C:"<C-R><C-W>" 
" 				\ "\%CD\%\*.h" "\%CD\%\*.c*" "\%CD\%\*.py" "\%CD\%\*.js"
" 				\ "\%CD\%\*.vim"
" 				\ <cr>
" else
" 	noremap <silent><F2> :AsyncRun! -cwd=<root> grep -n -s -R <C-R><C-W> 
" 				\ --include='*.h' --include='*.c*' --include='*.py' 
" 				\ --include='*.js' --include='*.vim'
" 				\ '<root>' <cr>
" endif


" coc.nvim
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
function! s:check_back_space() abort
let col = col('.') - 1
return !col || getline('.')[col - 1]  =~ '\s'
endfunction

" Insert <tab> when previous text is space, refresh completion if not.
inoremap <silent><expr> <TAB>
\ coc#pum#visible() ? coc#pum#next(1):
\ <SID>check_back_space() ? "\<Tab>" :
\ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" For lazygit
noremap <c-g> :tabe<CR>:-tabmove<CR>:term lazygit<CR>a

" Ranger
let g:ranger_map_keys = 0
map <leader>r :Ranger<CR>

" Floaterm
" Open terminal in the path of this file
noremap <silent><leader>7   :FloatermNew --cwd=<buffer><CR>

" 注释
noremap <silent><c-_> :Commentary<CR>
" Ctrl+Shift+l 一键格式化中文md文档
noremap <silent><c-L> :PanguAll<CR>
