call plug#begin('~/.config/nvim/plugins')

" In the following load all the plugins that I am using

" For improved code folding
Plug 'tmhedberg/SimpylFold'

" buffer explorer
Plug 'jlanzarotta/bufexplorer'

" git support
" Plug 'tpope/vim-fugitive'
" Plug 'airblade/vim-gitgutter'

" Statusline support
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" have taboo tabline; enables custom tab labels
Plug 'gcmt/taboo.vim'

" File browsing
Plug 'scrooloose/nerdtree'

" Super searching
Plug 'kien/ctrlp.vim'

" Conquer of Completion
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neoclide/coc-python', {'do': 'yarn install --frozen-lockfile'}
" Plug 'neoclide/coc-json', {'do': 'yarn install --frozen-lockfile'}

" Plugin for R
Plug 'jalvesaq/Nvim-R'

" Plugin to allow deletion of buffers without closing window
" :Bdelete and :Bwipeout commands
" work like regular :bdelete and bwipeout
Plug 'moll/vim-bbye'

" Plugin for easier window resizing
Plug 'simeji/winresizer'

" Plugin for using REPL such as ipython
" Plug 'Vigemus/iron.nvim'
Plug 'hhoeflin/iron.nvim'

" a lot of additional color schemes
Plug 'rafi/awesome-vim-colorschemes'

" Markdown support
Plug 'tpope/vim-markdown'
Plug 'Chandlercjy/vim-markdown-edit-code-block'


" Tabular support (used by gabrielelana/vim-markdown)
Plug 'godlygeek/tabular'

" Support for auto-creating of python doctstrings and folding
Plug 'yhat/vim-docstring'
Plug 'heavenshell/vim-pydocstring'

" YAML handling
Plug 'mrk21/yaml-vim'

" Plugin to deal with whitespace
Plug 'ntpeters/vim-better-whitespace'
" All of your Plugins must be added before the following line

" Set the tmux status line to look line in vim
Plug 'edkolev/tmuxline.vim'

" Syntax highlighting for mustache
Plug 'mustache/vim-mustache-handlebars'

" fuzzy finder
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
call plug#end()            " required


" **************************************************************
" Functionality for Coc extensions
" **************************************************************
function! CocBuildUpdate()
  if has('nvim')
    let g:coc_global_extensions = [
          \ 'coc-css',
          \ 'coc-html',
          \ 'coc-json',
          \ 'coc-python',
          \ ]
    call coc#util#install_extension(g:coc_global_extensions)
  endif
endfunction

" call CocBuildUpdate()

" **************************************************************
" Settings for Python
" **************************************************************

" Set color scheme
color dracula

" leader keys
let mapleader = "\\"
let maplocalleader = "-"

" allow for buffers to be hidden, not unloaded when abandoned
set hidden

" ensure that after jumping cursor is alway a couple of lines away from top or
" bottom
set scrolloff=5

" ========================
" vim-better-whitespace
" ========================
nnoremap <leader>s :StripWhitespace<CR>

" ========================
" Tmux
" ========================
" Some settings to ensure that colors inside and outside of tmux are the same
set background=dark
set t_Co=256
set t_ut=""

" ========================
" Tagbar
" ========================
nnoremap <silent> <F8> :TagbarOpenAutoClose<CR>

" ========================
" Code folding
" ========================
" Enable folding
set foldmethod=indent
set foldlevel=99
" use spacebar for folding
nnoremap <space> za

" ========================
" Autocomplete
" ========================
" better autocomplete behavior
set wildmode=list:longest

" ========================
" Various
" ========================
" Line numbering
set nu

" Clear highlighting on escape in normal mode
nnoremap <silent> <esc> :noh<return><esc>
nnoremap <esc>^[ <esc>^[ "This unsets the "last search pattern" register by hitting return

" exit terminal mode by hitting escape
tnoremap <Esc> <C-\><C-n>

" reduce the time to timeout
set timeoutlen=500

" Command for tabs as 2 or 4
command! Tab2 exec 'set tabstop=2 shiftwidth=2 expandtab'
command! Tab4 exec 'set tabstop=4 shiftwidth=4 expandtab'

" ========================
" Bbye
" ========================
nnoremap <Leader>q :Bdelete<CR>

" ========================
" Airline
" ========================
let g:airline#extensions#tabline#enabled = 0 " disabling for now. this makes the next 2 lines obsolete
let g:airline#extensions#tabline#tab_nr_type = 1
let g:airline#extensions#taboo#enabled = 1 " for taboo settings see below
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
" hide the encodign the file is in
let g:airline_section_y = ''

function! WindowNumber(...)
    let builder = a:1
    let context = a:2
    call builder.add_section('airline_b', '%{tabpagewinnr(tabpagenr())}')
    return 0
endfunction

call airline#add_statusline_func('WindowNumber')
call airline#add_inactive_statusline_func('WindowNumber')

" ========================
" Taboo settings
" ========================
let g:taboo_tabline = 0
" Note that the tab number is automatically displayed by tabline
let g:taboo_tab_format = "%W %f%m"
let g:taboo_renamed_tab_format = "%W [%l]%m"

" ========================
" Window and tab switcher moving
" ========================
" moving between different windows by their number
let i = 1
while i <= 9
    execute 'nnoremap <silent> g' . i . ' :' . i . 'wincmd w<CR>'
    execute 'noremap <silent> <Leader>t' . i . ' ' . i . 'gt<CR>'
    let i = i + 1
endwhile

" =====================
" Enable window resizer
" =====================
" If you want to start window resize mode by `Ctrl+T`
let g:winresizer_start_key = '<C-T>'

" If you cancel and quit window resize mode by `z` (keycode 122)
let g:winresizer_keycode_cancel = 122

" ===============================
" Markdown support
" ===============================
let g:markdown_fenced_languages = ['html', 'python', 'bash=sh']
" the following is for vim-markdown-edit-code-block
autocmd FileType markdown nmap <buffer> <silent> <leader>e :MarkdownEditBlock<CR>

" ===============================
" Iron.nvim
" ===============================
luafile $HOME/.config/nvim/plugins.lua
nmap <silent> <localleader>s <Plug>(iron-send-motion)
vmap <silent> <localleader>s <Plug>(iron-send-motion)`>j

" ===============================
" nvim-r
" ===============================
" Open R buffers without fixed width and have them listed
let R_buffer_opts = "nowinfixwidth buflisted"
let R_assign=2

" ======================
" Coc.nvim
" ======================
"set nobackup
set nowritebackup

" Better display for messages
set cmdheight=1

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Change the autocompletion behaviour to not be triggered automatically
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <TAB>
  \ pumvisible() ? coc#_select_confirm() :
  \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
  \ <SID>check_back_space() ? "\<TAB>" :
  \ coc#refresh()


" inoremap <silent><expr> <TAB>
"              \ pumvisible() ? "\<C-n>" :
"              \ <SID>check_back_space() ? "\<TAB>" :
"              \ coc#refresh()
let g:coc_snippet_next = '<tab>'

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
" autocmd CursorHold * silent call CocAction('doHover')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)


augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Create mappings for function text object, requires document symbols feature of languageserver.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <C-d> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <C-d> <Plug>(coc-range-select)
xmap <silent> <C-d> <Plug>(coc-range-select)

" Use `:Format` to format current buffer
nmap <leader>f  :call CocAction('format')<CR>
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

" workspace folders
autocmd FileType python let b:coc_root_patterns = ['.env', '.git']

"""""""""""""""""""""""""""""""""""""""""""""""""""
" Colorcolumn
"""""""""""""""""""""""""""""""""""""""""""""""""""

" introduce color column at 88; the color should be light
" grey and only be active for python, r and shell scripts
autocmd FileType r,python,sh  setlocal cc=88

"""""""""""""""""""""""""""""""""""""""""""""""""
" Scrolling when line wrapped
"""""""""""""""""""""""""""""""""""""""""""""""""
noremap <silent> <Leader>w :call ToggleWrap()<CR>
function ToggleWrap()
  if &wrap
    echo "Wrap OFF"
    setlocal nowrap
    set virtualedit=all
    silent! nunmap <buffer> <Up>
    silent! nunmap <buffer> <Down>
    silent! nunmap <buffer> <Home>
    silent! nunmap <buffer> <End>
    silent! iunmap <buffer> <Up>
    silent! iunmap <buffer> <Down>
    silent! iunmap <buffer> <Home>
    silent! iunmap <buffer> <End>
  else
    echo "Wrap ON"
    setlocal wrap linebreak nolist
    set virtualedit=
    setlocal display+=lastline
    noremap  <buffer> <silent> <Up>   gk
    noremap  <buffer> <silent> <Down> gj
    noremap  <buffer> <silent> <Home> g<Home>
    noremap  <buffer> <silent> <End>  g<End>
    inoremap <buffer> <silent> <Up>   <C-o>gk
    inoremap <buffer> <silent> <Down> <C-o>gj
    inoremap <buffer> <silent> <Home> <C-o>g<Home>
    inoremap <buffer> <silent> <End>  <C-o>g<End>
  endif
endfunction
