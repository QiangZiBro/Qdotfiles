"----------------------------------------------------------------------
" 默认情况下的分组，可以再前面覆盖之
"----------------------------------------------------------------------
if !exists('g:bundle_group')
	let g:bundle_group = ['basic', 'tags', 'enhanced', 'filetypes', 'textobj']
	let g:bundle_group += ['tags', 'airline', 'echodoc']
	let g:bundle_group += ['leaderf', 'coc']
endif


"----------------------------------------------------------------------
" 计算当前 vim-init 的子路径
"----------------------------------------------------------------------
let s:home = fnamemodify(resolve(expand('<sfile>:p')), ':h:h')

function! s:path(path)
	let path = expand(s:home . '/' . a:path )
	return substitute(path, '\\', '/', 'g')
endfunc


"----------------------------------------------------------------------
" 在 ~/.vim/bundles 下安装插件
"----------------------------------------------------------------------
call plug#begin(get(g:, 'bundle_home', '~/.vim/bundles'))


"----------------------------------------------------------------------
" 默认插件 
"----------------------------------------------------------------------

" 全文快速移动，<leader><leader>f{char} 即可触发
Plug 'easymotion/vim-easymotion'
map f <Plug>(easymotion-prefix)   
map f <Plug>(easymotion-s)

" 表格对齐，使用命令 Tabularize
Plug 'godlygeek/tabular', { 'on': 'Tabularize' }

" Diff 增强，支持 histogram / patience 等更科学的 diff 算法
Plug 'chrisbra/vim-diff-enhanced'

" 代码模板
Plug 'tibabit/vim-templates'
let g:tmpl_search_paths = ['~/.Qdotfiles/neovim/vim-init/templates']
let g:tmpl_author_email = substitute(system('git config user.email'),'\n\+$', '', '')
let g:tmpl_author_name = substitute(system('git config user.name'),'\n\+$', '', '')
"----------------------------------------------------------------------
" 基础插件
"----------------------------------------------------------------------
if index(g:bundle_group, 'basic') >= 0

	Plug 'zivyangll/git-blame.vim'
	autocmd CursorHold * :call gitblame#echo()
	" 一次性安装一大堆 colorscheme
	Plug 'flazz/vim-colorschemes'

	" 支持库，给其他插件用的函数库
	Plug 'xolox/vim-misc'

	" 用于在侧边符号栏显示 marks （ma-mz 记录的位置）
	Plug 'kshenoy/vim-signature'

	" 用于在侧边符号栏显示 git/svn 的 diff
	Plug 'mhinz/vim-signify'

	" 根据 quickfix 中匹配到的错误信息，高亮对应文件的错误行
	" 使用 :RemoveErrorMarkers 命令或者 <space>ha 清除错误
	Plug 'mh21/errormarker.vim'

	" 使用 ALT+e 会在不同窗口/标签上显示 A/B/C 等编号，然后字母直接跳转
	Plug 't9md/vim-choosewin'

	" 提供基于 TAGS 的定义预览，函数参数预览，quickfix 预览
	Plug 'skywind3000/vim-preview'

	" Git 支持
	Plug 'tpope/vim-fugitive'

	" 使用 ALT+E 来选择窗口
	nmap <m-e> <Plug>(choosewin)

	" 默认不显示 startify
	let g:startify_disable_at_vimenter = 1
	let g:startify_session_dir = '~/.vim/session'

	" signify 调优
	let g:signify_vcs_list = ['git', 'svn']
	let g:signify_sign_add               = '+'
	let g:signify_sign_delete            = '_'
	let g:signify_sign_delete_first_line = '‾'
	let g:signify_sign_change            = '~'
	let g:signify_sign_changedelete      = g:signify_sign_change

	" git 仓库使用 histogram 算法进行 diff
	let g:signify_vcs_cmds = {
			\ 'git': 'git diff --no-color --diff-algorithm=histogram --no-ext-diff -U0 -- %f',
			\}

endif


"----------------------------------------------------------------------
" 增强插件
"----------------------------------------------------------------------
if index(g:bundle_group, 'enhanced') >= 0
	Plug 'preservim/tagbar'
	Plug 'nvim-lua/plenary.nvim'
	Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' }
	Plug 'hotoo/pangu.vim', { 'for': ['markdown', 'vimwiki', 'text'] }
	let g:pangu_rule_date = 1
	Plug 'tpope/vim-commentary'
	Plug 'junegunn/fzf'
	Plug 'voldikss/fzf-floaterm'
	Plug 'voldikss/vim-floaterm'
	let g:floaterm_keymap_new    = '<F7>'
	let g:floaterm_keymap_prev   = '<F8>'
	let g:floaterm_keymap_next   = '<F9>'
	let g:floaterm_keymap_toggle = '<F12>'

	" 在 nvim 里打开ranger
	Plug 'rbgrouleff/bclose.vim'
	Plug 'francoiscabrol/ranger.vim'

	" 用 v 选中一个区域后，ALT_+/- 按分隔符扩大/缩小选区
	Plug 'terryma/vim-expand-region'

	" 使用 :FlyGrep 命令进行实时 grep
	Plug 'wsdjeg/FlyGrep.vim'

	" 使用 :CtrlSF 命令进行模仿 sublime 的 grep
	Plug 'dyng/ctrlsf.vim'

	" 配对括号和引号自动补全
	Plug 'Raimondi/delimitMate'

	" 提供 gist 接口
	Plug 'lambdalisue/vim-gista', { 'on': 'Gista' }
	
	
	" ALT_+/- 用于按分隔符扩大缩小 v 选区
	map <m-=> <Plug>(expand_region_expand)
	map <m--> <Plug>(expand_region_shrink)
	Plug 'Yggdroot/LeaderF', { 'do': ':LeaderfInstallCExtension' }

	Plug 'skywind3000/asynctasks.vim'
	let g:asynctasks_term_pos = 'floaterm'
	Plug 'skywind3000/asyncrun.vim'
	Plug 'benmills/vimux'
	let g:asyncrun_open = 6
	" stole from https://github.com/skywind3000/asynctasks.vim/wiki/UI-Integration
	"
	function! s:lf_task_source(...)
		let rows = asynctasks#source(&columns * 48 / 100)
		let source = []
		for row in rows
			let name = row[0]
			let source += [name . '  ' . row[1] . '  : ' . row[2]]
		endfor
		return source
	endfunction


	function! s:lf_task_accept(line, arg)
		let pos = stridx(a:line, '<')
		if pos < 0
			return
		endif
		let name = strpart(a:line, 0, pos)
		let name = substitute(name, '^\s*\(.\{-}\)\s*$', '\1', '')
		if name != ''
			exec "AsyncTask " . name
		endif
	endfunction

	function! s:lf_task_digest(line, mode)
		let pos = stridx(a:line, '<')
		if pos < 0
			return [a:line, 0]
		endif
		let name = strpart(a:line, 0, pos)
		return [name, 0]
	endfunction

	function! s:lf_win_init(...)
		setlocal nonumber
		setlocal nowrap
	endfunction


	let g:Lf_Extensions = get(g:, 'Lf_Extensions', {})
	let g:Lf_Extensions.task = {
				\ 'source': string(function('s:lf_task_source'))[10:-3],
				\ 'accept': string(function('s:lf_task_accept'))[10:-3],
				\ 'get_digest': string(function('s:lf_task_digest'))[10:-3],
				\ 'highlights_def': {
				\     'Lf_hl_funcScope': '^\S\+',
				\     'Lf_hl_funcDirname': '^\S\+\s*\zs<.*>\ze\s*:',
				\ },
				\ 'help' : 'navigate available tasks from asynctasks.vim',
				\ }


	function! s:fzf_sink(what)
		let p1 = stridx(a:what, '<')
		if p1 >= 0
			let name = strpart(a:what, 0, p1)
			let name = substitute(name, '^\s*\(.\{-}\)\s*$', '\1', '')
			if name != ''
				exec "AsyncTask ". fnameescape(name)
			endif
		endif
	endfunction

	function! s:fzf_task()
		let rows = asynctasks#source(&columns * 48 / 100)
		let source = []
		for row in rows
			let name = row[0]
			let source += [name . '  ' . row[1] . '  : ' . row[2]]
		endfor
		let opts = { 'source': source, 'sink': function('s:fzf_sink'),
					\ 'options': '+m --nth 1 --inline-info --tac' }
		if exists('g:fzf_layout')
			for key in keys(g:fzf_layout)
				let opts[key] = deepcopy(g:fzf_layout[key])
			endfor
		endif
		call fzf#run(opts)
	endfunction

	command! -nargs=0 AsyncTaskFzf call s:fzf_task()
endif


"----------------------------------------------------------------------
" coc.nvim
"----------------------------------------------------------------------
if index(g:bundle_group, 'coc') >= 0
	" Coc补全
	Plug 'neoclide/coc.nvim', {'branch': 'release'}
	let g:coc_disable_startup_warning = 1
	" Coc的补全插件
	let g:coc_global_extensions = ['coc-json', 'coc-pyright', 'coc-vimlsp', 'coc-sh', 'coc-ultisnips']
	" Set internal encoding of vim, not needed on neovim, since coc.nvim using some
	" unicode characters in the file autoload/float.vim
	set encoding=utf-8
	
	" TextEdit might fail if hidden is not set.
	set hidden
	
	" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
	" delays and poor user experience.
	set updatetime=100
	" Symbol renaming.
	nmap R <Plug>(coc-rename)
	
	" Don't pass messages to |ins-completion-menu|.
	set shortmess+=c
	
	" Use tab for trigger completion with characters ahead and navigate.
	" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
	" other plugin before putting this into your config.
	inoremap <silent><expr> <TAB>
	      \ pumvisible() ? "\<C-n>" :
	      \ <SID>check_back_space() ? "\<TAB>" :
	      \ coc#refresh()
	inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
	
	function! s:check_back_space() abort
	  let col = col('.') - 1
	  return !col || getline('.')[col - 1]  =~# '\s'
	endfunction
	
	" GoTo code navigation.
	nmap <silent> gd <Plug>(coc-definition)
	nmap <silent> gy <Plug>(coc-type-definition)
	nmap <silent> gi <Plug>(coc-implementation)
	nmap <silent> gr <Plug>(coc-references)
	" Use `[g` and `]g` to navigate diagnostics
	" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
	nmap <silent> [g <Plug>(coc-diagnostic-prev)
	nmap <silent> ]g <Plug>(coc-diagnostic-next)
	
	" Use K to show documentation in preview window.
	nnoremap <silent> K :call <SID>show_documentation()<CR>
	
	function! s:show_documentation()
	  if (index(['vim','help'], &filetype) >= 0)
	    execute 'h '.expand('<cword>')
	  elseif (coc#rpc#ready())
	    call CocActionAsync('doHover')
	  else
	    execute '!' . &keywordprg . " " . expand('<cword>')
	  endif
	endfunction
	" Track the engine.
	Plug 'SirVer/ultisnips'

	" Snippets are separated from the engine. Add this if you want them:
	Plug 'QiangZiBro/vim-snippets'
	let g:UltiSnipsJumpForwardTrigger="<tab>"                                       
	let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
endif


"----------------------------------------------------------------------
" 文本对象：textobj 全家桶
"----------------------------------------------------------------------
if index(g:bundle_group, 'textobj') >= 0

	" 基础插件：提供让用户方便的自定义文本对象的接口
	Plug 'kana/vim-textobj-user'

	" indent 文本对象：ii/ai 表示当前缩进，vii 选中当缩进，cii 改写缩进
	Plug 'kana/vim-textobj-indent'

	" 语法文本对象：iy/ay 基于语法的文本对象
	Plug 'kana/vim-textobj-syntax'

	" 函数文本对象：if/af 支持 c/c++/vim/java
	Plug 'kana/vim-textobj-function', { 'for':['c', 'cpp', 'vim', 'java'] }

	" 参数文本对象：i,/a, 包括参数或者列表元素
	Plug 'sgur/vim-textobj-parameter'

	" 提供 python 相关文本对象，if/af 表示函数，ic/ac 表示类
	Plug 'bps/vim-textobj-python', {'for': 'python'}

	" 提供 uri/url 的文本对象，iu/au 表示
	Plug 'jceb/vim-textobj-uri'
endif


"----------------------------------------------------------------------
" 文件类型扩展
"----------------------------------------------------------------------
if index(g:bundle_group, 'filetypes') >= 0

	" powershell 脚本文件的语法高亮
	Plug 'pprovost/vim-ps1', { 'for': 'ps1' }

	" lua 语法高亮增强
	Plug 'tbastos/vim-lua', { 'for': 'lua' }

	" C++ 语法高亮增强，支持 11/14/17 标准
	Plug 'octol/vim-cpp-enhanced-highlight', { 'for': ['c', 'cpp'] }

	" 额外语法文件
	Plug 'justinmk/vim-syntax-extra', { 'for': ['c', 'bison', 'flex', 'cpp'] }

	" python 语法文件增强
	Plug 'vim-python/python-syntax', { 'for': ['python'] }

	" rust 语法增强
	Plug 'rust-lang/rust.vim', { 'for': 'rust' }

	" vim org-mode 
	Plug 'jceb/vim-orgmode', { 'for': 'org' }
endif


"----------------------------------------------------------------------
" airline
"----------------------------------------------------------------------
if index(g:bundle_group, 'airline') >= 0
	Plug 'vim-airline/vim-airline'
	Plug 'vim-airline/vim-airline-themes'
	let g:airline_left_sep = ''
	let g:airline_left_alt_sep = ''
	let g:airline_right_sep = ''
	let g:airline_right_alt_sep = ''
	let g:airline_powerline_fonts = 0
	let g:airline_exclude_preview = 1
	let g:airline_section_b = '%n'
	let g:airline_theme='deus'
	let g:airline#extensions#branch#enabled = 0
	let g:airline#extensions#syntastic#enabled = 0
	let g:airline#extensions#fugitiveline#enabled = 0
	let g:airline#extensions#csv#enabled = 0
	let g:airline#extensions#vimagit#enabled = 0
endif




"----------------------------------------------------------------------
" LanguageTool 语法检查
"----------------------------------------------------------------------
if index(g:bundle_group, 'grammer') >= 0
	Plug 'rhysd/vim-grammarous'
	noremap <space>rg :GrammarousCheck --lang=en-US --no-move-to-first-error --no-preview<cr>
	map <space>rr <Plug>(grammarous-open-info-window)
	map <space>rv <Plug>(grammarous-move-to-info-window)
	map <space>rs <Plug>(grammarous-reset)
	map <space>rx <Plug>(grammarous-close-info-window)
	map <space>rm <Plug>(grammarous-remove-error)
	map <space>rd <Plug>(grammarous-disable-rule)
	map <space>rn <Plug>(grammarous-move-to-next-error)
	map <space>rp <Plug>(grammarous-move-to-previous-error)
endif


"----------------------------------------------------------------------
" ale：动态语法检查
"----------------------------------------------------------------------
" if index(g:bundle_group, 'ale') >= 0
" 	Plug 'w0rp/ale'

" 	" 设定延迟和提示信息
" 	let g:ale_completion_delay = 500
" 	let g:ale_echo_delay = 20
" 	let g:ale_lint_delay = 500
" 	let g:ale_echo_msg_format = '[%linter%] %code: %%s'

" 	" 设定检测的时机：normal 模式文字改变，或者离开 insert模式
" 	" 禁用默认 INSERT 模式下改变文字也触发的设置，太频繁外，还会让补全窗闪烁
" 	let g:ale_lint_on_text_changed = 'normal'
" 	let g:ale_lint_on_insert_leave = 1

" 	" 在 linux/mac 下降低语法检查程序的进程优先级（不要卡到前台进程）
" 	if has('win32') == 0 && has('win64') == 0 && has('win32unix') == 0
" 		let g:ale_command_wrapper = 'nice -n5'
" 	endif

" 	" 允许 airline 集成
" 	let g:airline#extensions#ale#enabled = 1

" 	" 编辑不同文件类型需要的语法检查器
" 	let g:ale_linters = {
" 				\ 'c': ['gcc', 'cppcheck'], 
" 				\ 'cpp': ['gcc', 'cppcheck'], 
" 				\ 'python': ['flake8', 'pylint'], 
" 				\ 'lua': ['luac'], 
" 				\ 'go': ['go build', 'gofmt'],
" 				\ 'java': ['javac'],
" 				\ 'javascript': ['eslint'], 
" 				\ }


" 	" 获取 pylint, flake8 的配置文件，在 vim-init/tools/conf 下面
" 	function s:lintcfg(name)
" 		let conf = s:path('tools/conf/')
" 		let path1 = conf . a:name
" 		let path2 = expand('~/.vim/linter/'. a:name)
" 		if filereadable(path2)
" 			return path2
" 		endif
" 		return shellescape(filereadable(path2)? path2 : path1)
" 	endfunc

" 	" 设置 flake8/pylint 的参数
" 	let g:ale_python_flake8_options = '--conf='.s:lintcfg('flake8.conf')
" 	let g:ale_python_pylint_options = '--rcfile='.s:lintcfg('pylint.conf')
" 	let g:ale_python_pylint_options .= ' --disable=W'
" 	let g:ale_c_gcc_options = '-Wall -O2 -std=c99'
" 	let g:ale_cpp_gcc_options = '-Wall -O2 -std=c++14'
" 	let g:ale_c_cppcheck_options = ''
" 	let g:ale_cpp_cppcheck_options = ''

" 	let g:ale_linters.text = ['textlint', 'write-good', 'languagetool']

" 	" 如果没有 gcc 只有 clang 时（FreeBSD）
" 	if executable('gcc') == 0 && executable('clang')
" 		let g:ale_linters.c += ['clang']
" 		let g:ale_linters.cpp += ['clang']
" 	endif
" endif

"----------------------------------------------------------------------
" 结束插件安装
"----------------------------------------------------------------------
call plug#end()
