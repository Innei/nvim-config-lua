" Author:   Innei
" Github:   https://github.com/innei
" License:  MIT


" only for vscode-vim
scriptencoding utf-8

" ===
" === Basic Mappings
" ===
let mapleader=" "
noremap ; :
noremap r <C-r>
nnoremap 0 ^
nnoremap ) g_



" Indentation
nnoremap < <<
nnoremap > >>
xnoremap < <gv
xnoremap > >gv

" ===
" === Cursor Movement
" ===
nnoremap . <C-I>
nnoremap , <C-O>

map ! %
nnoremap <C-a> <nop>
nnoremap <C-x> <nop>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-h> <Left>
inoremap <C-l> <Right>

cnoremap <C-j> <Down>
cnoremap <C-k> <Up>
cnoremap <C-h> <Left>
cnoremap <C-l> <Right>


" number increment and decrement
nnoremap = <C-a>
nnoremap - <C-x>

" rename a word
nnoremap cw ciw

" ===
" === Buffer manage
" ===
if exists('g:vscode')
  nnoremap gB :tabp<CR>
  nnoremap gb :tabn<CR>
  nnoremap [b :tabp<CR>
  nnoremap ]b :tabn<CR>
  nnoremap tb :tabnew<CR>
endif

" Press ` to change case (instead of ~)
noremap ` ~<left>

