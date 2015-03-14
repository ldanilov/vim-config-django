""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NOTES
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" This will exclude some useless directories from Ctags - otherwise
" tags file can be GB's in size.
" ctags -R --exclude=node_modules --exclude=.meteor --exclude='packages/*/.build/'
"
" Also add `--python-kinds=-i` to the .ctags file to exlude the import
" statements.

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Pathogen configs
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call pathogen#infect()
call pathogen#helptags()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General configs
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set ruler
set tabstop=4
set shiftwidth=4
set expandtab
set list listchars=tab:▷⋅,trail:⋅,nbsp:⋅
set statusline=%F%m%r%h%w\ [TYPE=%Y\ %{&ff}]\ [%l/%L\ (%p%%)
set number

"""""""""""""""""""""""""""""""""""
syntax on
filetype plugin indent on
colorscheme molokai

"""""""""""""""""""""""""""""""""""
" Viewport Controls
" ie moving between split panes
map <silent>,h <C-w>h
map <silent>,j <C-w>j
map <silent>,k <C-w>k
map <silent>,l <C-w>l

"""""""""""""""""""""""""""""""""""
" Jump to the last position when reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g'\"" | endif
endif

"""""""""""""""""""""""""""""""""""
" display preview window to show tag for the word under the cursor
set updatetime=1500 " time it takes to update the preview, units:ms

au! CursorHold * nested call PreviewWord()
func PreviewWord()
  if &previewwindow          " don't do this in the preview window
    return
  endif
  let w = expand("<cword>")      " get the word under cursor
  if w =~ '\a'           " if the word contains a letter

    " Delete any existing highlight before showing another tag
    silent! wincmd P     " jump to preview window
    if &previewwindow    " if we really get there...
      match none         " delete existing highlight
      wincmd p           " back to old window
    endif

    " Try displaying a matching tag for the word under the cursor
    try
       exe "ptag " . w
    catch
      return
    endtry

    silent! wincmd P         " jump to preview window
    if &previewwindow        " if we really get there...
  if has("folding")
    silent! .foldopen        " don't want a closed fold
  endif
  call search("$", "b")      " to end of previous line
  let w = substitute(w, '\\', '\\\\', "")
  call search('\<\V' . w . '\>') " position cursor on match
  " Add a match highlight to the word at this position
      hi previewWord term=underline ctermbg=14 gui=undercurl guisp=#70F0F0
  exe 'match previewWord "\%' . line(".") . 'l\%' . col(".") . 'c\k*"'
      wincmd p           " back to old window
    endif
  endif
endfun

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin configs
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" nerd_tree config
let NERDTreeChDirMode=2
let NERDTreeIgnore=['\.vim$', '\~$', '\.pyc$', '\.swp$']
let NERDTreeSortOrder=['^__\.py$', '\/$', '*', '\.swp$',  '\~$']
let NERDTreeShowBookmarks=1
map <F3> :NERDTreeToggle<CR>

"""""""""""""""""""""""""""""""""""
" Syntax for multiple tag files are: set tags=/my/dir1/tags, /my/dir2/tags
set tags=tags;$HOME/.vim/tags/

"""""""""""""""""""""""""""""""""""
" TagList Plugin Configuration
let Tlist_Ctags_Cmd='/usr/local/bin/ctags'
let Tlist_GainFocus_On_ToggleOpen = 1
let Tlist_Close_On_Select = 1
let Tlist_Use_Right_Window = 1
let Tlist_File_Fold_Auto_Close = 1
map <F7> :TlistToggle<CR>

"""""""""""""""""""""""""""""""""""
nnoremap <leader>jd :YcmCompleter GoTo<CR>

"""""""""""""""""""""""""""""""""""
" Recommended settings for YouCompleteMe
let g:ycm_collect_identifiers_from_tags_files = 1 " Let YCM read tags from Ctags file
let g:ycm_use_ultisnips_completer = 1 " Default 1, just ensure
let g:ycm_seed_identifiers_with_syntax = 1 " Completion for programming language's keyword
let g:ycm_complete_in_comments = 1 " Completion in comments
let g:ycm_complete_in_strings = 1 " Completion in string

"""""""""""""""""""""""""""""""""""
" Recommended UltiSnips setings for YouCompleteMe
let g:UltiSnipsExpandTrigger       = "<c-j>"
let g:UltiSnipsJumpForwardTrigger  = "<c-j>"
let g:UltiSnipsJumpBackwardTrigger = "<c-p>"
let g:UltiSnipsListSnippets        = "<c-k>" "List possible snippets based on current file

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Python configs
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <buffer> <F9> :exec '!python' shellescape(@%, 1)<cr>

"""""""""""""""""""""""""""""""""""
au FileType py set autoindent
au FileType py set smartindent
au FileType py set textwidth=80 " PEP-8 Friendly

"""""""""""""""""""""""""""""""""""
" Mappings - to make file jumps between relative django files easier.
let g:last_relative_dir = ''
nnoremap \1 :call RelatedFile ("models.py")<cr>
nnoremap \2 :call RelatedFile ("views.py")<cr>
nnoremap \3 :call RelatedFile ("urls.py")<cr>
nnoremap \4 :call RelatedFile ("admin.py")<cr>
nnoremap \5 :call RelatedFile ("tests.py")<cr>
nnoremap \6 :call RelatedFile ( "templates/" )<cr>
nnoremap \7 :call RelatedFile ( "templatetags/" )<cr>
nnoremap \8 :call RelatedFile ( "management/" )<cr>
nnoremap \0 :e settings.py<cr>
nnoremap \9 :e urls.py<cr>

"""""""""""""""""""""""""""""""""""
fun! RelatedFile(file)
    "This is to check that the directory looks djangoish
    if filereadable(expand("%:h"). '/models.py') || isdirectory(expand("%:h") . "/templatetags/")
        exec "edit %:h/" . a:file
        let g:last_relative_dir = expand("%:h") . '/'
        return ''
    endif
    if g:last_relative_dir != ''
        exec "edit " . g:last_relative_dir . a:file
        return ''
    endif
    echo "Cant determine where relative file is : " . a:file
    return ''
endfun

fun SetAppDir()
    if filereadable(expand("%:h"). '/models.py') || isdirectory(expand("%:h") . "/templatetags/")
        let g:last_relative_dir = expand("%:h") . '/'
        return ''
    endif
endfun
autocmd BufEnter *.py call SetAppDir()

"""""""""""""""""""""""""""""""""""
" These are additional surroundings for django for the surround.vim plugin:
let b:surround_{char2nr("v")} = "{{ \r }}"
let b:surround_{char2nr("{")} = "{{ \r }}"
let b:surround_{char2nr("%")} = "{% \r %}"
let b:surround_{char2nr("b")} = "{% block \1block name: \1 %}\r{% endblock \1\1 %}"
let b:surround_{char2nr("i")} = "{% if \1condition: \1 %}\r{% endif %}"
let b:surround_{char2nr("w")} = "{% with \1with: \1 %}\r{% endwith %}"
let b:surround_{char2nr("f")} = "{% for \1for loop: \1 %}\r{% endfor %}"
let b:surround_{char2nr("c")} = "{% comment %}\r{% endcomment %}"

"""""""""""""""""""""""""""""""""""
" Python-only: execute ctags from the file given installed packages
map <F12> :!ctags -R --exclude=node_modules --exclude=.meteor --exclude='packages/*/.build/' -f ./tags `python -c "from distutils.sysconfig import get_python_lib; print get_python_lib()`<CR>

"""""""""""""""""""""""""""""""""""
" source: http://vim.wikia.com/wiki/Access_Python_Help
function! ShowPydoc(what)
  let bufname = a:what . ".pydoc"
  " check if the buffer exists already
  if bufexists(bufname)
    let winnr = bufwinnr(bufname)
    if winnr != -1
      " if the buffer is already displayed, switch to that window
      execute winnr "wincmd w"
    else
      " otherwise, open the buffer in a split
      execute "sbuffer" bufname
    endif
  else
    " create a new buffer, set the nofile buftype and don't display it in the
    " buffer list
    execute "split" fnameescape(bufname)
    setlocal buftype=nofile
    setlocal nobuflisted
    " read the output from pydoc
    execute "r !" . shellescape(s:pydoc_path, 1) . " " . shellescape(a:what, 1)
  endif
  " go to the first line of the document
  1
endfunction

nnoremap <buffer> K :<C-u>execute "!xterm -e 'pydoc " . expand("<cword>") . "'"<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Haxe/flixel related configuration
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" For flixel autocompletion to work properly
set autowrite

"""""""""""""""""""""""""""""""""""
" If you're using vim, to activate the language for the taglist plugin include
" the following in your .vimrc, and reload:
let tlist_haxe_settings='haxe;f:function;v:variable;c:class;i:interface;p:package'

"""""""""""""""""""""""""""""""""""
" Generate a ctags file for the current build target.
au FileType hx set VaxeStartCompletionServer
au FileType hx set VaxeCtags
