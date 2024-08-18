" Open current editor file externally
nnoremap gO :!open '%:p'<CR>


function Date()
	:r! date "+\%Y-\%m-\%d \%H:\%M"
endfunction
command Date call Date()


