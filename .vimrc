" Note: Skip initialization for vim-tiny or vim-small.
if 0 | endif
  if has('vim_starting')
    if &compatible
      set nocompatible               " Be iMproved
     endif
     " Required:
     set runtimepath+=~/.vim/bundle/neobundle.vim/
  endif
  " Required:
  call neobundle#begin(expand('~/.vim/bundle/'))
  " Let NeoBundle manage NeoBundle
  " Required:
  NeoBundleFetch 'Shougo/neobundle.vim'
  NeoBundle 'scrooloose/nerdtree'
  NeoBundle 'Townk/vim-autoclose'
  NeoBundle 'scrooloose/syntastic'
  NeoBundle 'Shougo/neocomplete'
  NeoBundle 'Shougo/neocomplcache'
  NeoBundle 'Shougo/neosnippet'
  NeoBundle 'Shougo/neosnippet-snippets'
  " ctagsのインストールが必須
  NeoBundle 'vim-scripts/taglist.vim'
  NeoBundle 'PDV--phpDocumentor-for-Vim'
  NeoBundle 'junegunn/vim-easy-align'
  NeoBundle 'plasticboy/vim-markdown'
  NeoBundle 'kannokanno/previm'
  NeoBundle 'tyru/open-browser.vim'
  NeoBundle 'szw/vim-tags'

  call neobundle#end()

  " Required:
  filetype plugin indent on
  " If there are uninstalled bundles found on startup,
  " this will conveniently prompt you to install them.
NeoBundleCheck

"=============
" 基本設定
syntax on
set ruler
set number
set tabstop=4
set autoindent
set expandtab
set shiftwidth=4
set encoding=utf-8
set fileencodings=utf-8
set noautoindent
set hlsearch
set backspace=indent,eol,start
set lcs=tab:>.,trail:_,extends:\
set list
highlight SpecialKey cterm=NONE ctermfg=7 guifg=7
highlight JpSpace cterm=underline ctermfg=7 guifg=7

"=============
" vim-tags
set tags=~/.vim/tags/makuake/.tags
let g:vim_tags_project_tags_command = "/usr/local/bin/ctags -f ~/.vim/tags/makuake/ -R . 2>/dev/null"
let g:vim_tags_gems_tags_command = "/usr/local/bin/ctags -R -f ~/.vim/tags/makuake/.Gemfile.lock.tags `bundle show --paths` 2>/dev/null"
set tags+=.tags
set tags+=.Gemfile.lock.tags

" tagsジャンプの時に複数ある時は一覧表示
nnoremap <C-]> g<C-]>



"=============
" syntastic
let g:syntastic_check_on_open = 1
let g:syntastic_enable_signs = 1
let g:syntastic_echo_current_error = 1
let g:syntastic_auto_loc_list = 2
let g:syntastic_enable_highlighting = 1
 " なんでか分からないけど php コマンドのオプションを上書かないと動かなかった
let g:syntastic_php_php_args = '-l'
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

"=============
"snippet
" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)


" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: "\<TAB>"
 
" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif

"=============
"neocomplete
if has('lua')
    NeoBundleLazy 'Shougo/neocomplete.vim', {
          \ 'depends' : 'Shougo/vimproc',
          \ 'autoload' : { 'insert' : 1,}
          \ }
endif
" neocomplete {{{
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_ignore_case = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#enable_auto_select = 1
let g:neocomplete#enable_enable_camel_case_completion = 0
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns._ = '\h\w*'
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"


"=============
"taglist設定
let Tlist_Ctags_Cmd = "/usr/bin/ctags"
let Tlist_Show_One_File = 1                   " 現在表示中のファイルのみのタグしか表示しない
let Tlist_Use_Right_Window = 1                " 右側にtag listのウインドうを表示する
let Tlist_Exit_OnlyWindow = 1                 " taglistのウインドウだけならVimを閉じる


"=============
"PDV設定
let g:pdv_cfg_Type = "mixed"
let g:pdv_cfg_Package = ""
let g:pdv_cfg_Version = "$id$"
let g:pdv_cfg_Author = "nakamura <tsuyoshin@gmail.com>"
let g:pdv_cfg_Copyright = ""
let g:pdv_cfg_License = ""
let g:pdv_cfg_ReturnVal = "void"
inoremap <C-D> <ESC>:call PhpDocSingle()<CR>i
nnoremap <C-D> :call PhpDocSingle()<CR>
vnoremap <C-D> :call PhpDocRange()<CR>



"=============
"vim-easy-align
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

"=============
" markdown
au BufRead,BufNewFile *.md set filetype=markdown

"=============
" eslint
let g:syntastic_javascript_checkers = ['eslint']
