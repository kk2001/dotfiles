" VIM Configuration File
" Description: Optimized for C/C++ development, but useful also for other things.
" Author: guanghui qu 
"

call pathogen#runtime_append_all_bundles()
call pathogen#helptags()


" set UTF-8 encoding
set enc=utf-8
set fenc=utf-8
set termencoding=utf-8
" disable vi compatibility (emulation of old bugs)
set nocompatible
" use indentation of previous line
set autoindent
" use intelligent indentation for C
set smartindent
" configure tabwidth and insert spaces instead of tabs
set tabstop=4        " tab width is 4 spaces
set shiftwidth=4     " indent also with 4 spaces
set expandtab        " expand tabs to spaces
" wrap lines at 120 chars. 80 is somewaht antiquated with nowadays displays.
set textwidth=120
" turn syntax highlighting on
set t_Co=256
syntax on
" colorscheme wombat256 
" turn line numbers on
set number
" highlight matching braces
set showmatch
" intelligent comments
set comments=sl:/*,mb:\ *,elx:\ */
" use intelligent file completion like in the bash
set wildmode=longest:full
set wildmenu

" vim-git plugin
set laststatus=2
set statusline=%{GitBranch()}

" Install OmniCppComplete like described on http://vim.wikia.com/wiki/C++_code_completion
" This offers intelligent C++ completion when typing '.' '->' or <C-o>
" Load standard tag files
set tags+=./tags
set tags+=~/.vim/tags/cpp
let g:ProjTags = ["~/OpenSourceGitRepository/cocos2d-html5"]
let g:ProjTags += [["~/OpenSourceGitRepository/cocos2d-html5","~/vimTags/c2dhtml5","~/vimTags/jsbox2d","~/vimTags/jscocoaDenshion"]]
let g:ProjTags += [["~/OpenSourceGitRepository/cocos2d-x","~/vimTags/cocos2dx/tags","~/vimTags/b2dTags","~/vimTags/cocoDensionTags"]]

" set tags+=~/vimTags/cocos2dx/tags
" set tags+=~/.vim/tags/cocoDensionTags
" set tags+=~/.vim/tags/b2dTags
" set tags+=~/.vim/c2dxexTags
" set tags+=~/.vim/c2dhtml5
" set tags+=~/.vim/jsbox2d
" set tags+=~/.vim/jscocoaDenshion

" Install DoxygenToolkit from http://www.vim.org/scripts/script.php?script_id=987
let g:DoxygenToolkit_briefTag_pre=""
let g:DoxygenToolkit_paramTag_pre="@param "
let g:DoxygenToolkit_returnTag="@return "
let g:DoxygenToolkit_blockHeader="--------------------------------------------------------------------------"
let g:DoxygenToolkit_blockFooter="----------------------------------------------------------------------------"
let g:DoxygenToolkit_authorName="guanghui.qu <guanghui8827@126.com>"
let g:DoxygenToolkit_licenseTag="MIT License"

" template functionality
function! CreateHeaderFile()
    silent! 0r ~/.vim/skel/templ.h
    silent! exe "%s/%INCLUDEPROTECTION%/__".toupper(expand("<afile>:r"))."_H__/g"
endfunction

function! CreateCSourceFile()
    if expand("<afile>") == "main.c"
        return
    endif
    silent! 0r ~/.vim/skel/templ.cpp
    " :r removes file extension
    silent! exe "%s/%FILE%/".expand("<afile>:r").".h/g"
endfunction

autocmd BufNewFile *.cpp call CreateCSourceFile()
autocmd BufNewFile *.h call CreateHeaderFile()

"--- OmniCppComplete ---
" -- required --
set nocp " non vi compatible mode
filetype plugin on " enable plugins
" -- optional --
" auto close options when exiting insert mode
autocmd InsertLeave * if pumvisible() == 0|pclose|endif
" set completeopt=menu,menuone
" -- configs --
let OmniCpp_MayCompleteDot = 1 " autocomplete with .
let OmniCpp_MayCompleteArrow = 1 " autocomplete with ->
let OmniCpp_MayCompleteScope = 1 " autocomplete with ::
let OmniCpp_SelectFirstItem = 0 " select first item (but don't insert)
let OmniCpp_NamespaceSearch = 2 " search namespaces in this and included files
let OmniCpp_ShowPrototypeInAbbr = 1 " show function prototype (i.e. parameters) in popup window
" -- ctags --

"--vim-pathogen
call pathogen#infect()
syntax on
filetype plugin indent on

autocmd vimenter * NERDTree
"--tcomment plugin,comment a line
map <leader>c <c-_><c-_>
"---a.vim plugin
nmap <buffer> <silent> <leader> ,PP
"go back and forth from header file and source file
nmap <silent> <Leader>h :FSHere<cr>
"open a tree view
nmap <silent> <leader>n :NERDTreeToggle <CR>
"open a tag list ivew
nmap <silent> <leader>tl :TlistToggle <CR>
"generate ctags at current directory
nmap <silent> <leader>g  :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q ./ <CR>
"go to function definition
map  <leader>f <c-]>
"go back to prev function
map <leader>b <c-t>
"indent back
nmap <S-Tab> <<
"create doxygen comment
map <leader>d :Dox<CR>

"automatically save foldings in vim
au BufWinLeave * silent! mkview
au BufWinEnter * silent! loadview

"map markdown to html
nmap <leader>md :%!/usr/local/bin/Markdown.pl --html4tags <cr>


" :hi CursorLine   cterm=NONE ctermbg=lightyellow ctermfg=black guibg=lightyellow guifg=black
" :hi CursorColumn cterm=NONE ctermbg=yellow ctermfg=black guibg=yellow guifg=black
:nnoremap <Leader>1 :set cursorline! cursorcolumn!<CR>

"set javascript auto completion
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS

"map windows command
nmap ,j <c-w>j
nmap ,k <c-w>k
nmap ,h <c-w>h
nmap ,l <c-w>l
" nmap ,o <c-w>o
nmap ,c <c-w>c
nmap ,<tab> <c-w><c-w>

"config syntastic check syntax when file open
let g:syntastic_check_on_open=1

"windows down
nmap ,d <c-D>
nmap ,u <c-U>

"disable navigation throgh arrow key
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

nmap ,p :CtrlP <cr>

"set colorscheme
if has('gui_running')
    syntax enable
    set background=dark
    colorscheme solarized
else
    colorscheme wombat256 
endif

"config for Buffergator plugin map"
nmap <silent>,b :BuffergatorToggle <cr>
"config for ZoomWin plugin map
nmap <silent>,o :ZoomWin <cr>
