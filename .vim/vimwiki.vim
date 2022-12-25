let g:vimwiki_list = [{
	\ 'path': "$HOME/Developer/vimwiki/",
	\ 'ext':'.md',
	\ 'syntax':'markdown',
	\ 'diary_rel_path': "/",
	\ 'diary_index': "diaryindex"
	\ }]
let g:vimwiki_markdown_link_ext = 1

" Allow other markdown files to be non-vimwiki files
let g:vimwiki_global_ext = 0

let g:vimwiki_listsyms = ' ○◐●✓'

let g:vimwiki_folding = 'custom'


" Attention: Executed multiple times!



autocmd VimEnter * if argv() ==# ['wiki'] | execute 'VimwikiIndex' | endif

