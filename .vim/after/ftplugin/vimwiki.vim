" https://groups.google.com/forum/#!topic/vimwiki/ChSY9b4WBbQ
fun! CompleteLinks(findstart, base)
    if a:findstart
        " locate the start of the word
        let line = getline('.')
        let start = col('.') - 1
        while start > 0 && line[start - 1] =~ '\a'
            let start -= 1
        endwhile
        return start
    else
        " find files matching with "a:base"
        let res = []
        for m in split(globpath('.', '**/*.md'), '\n')
            let n = fnamemodify(m, ':t:r')
            if n =~ '^' . a:base
                call add(res, n)
            endif
        endfor
        return res
    endif
endfun

function VimwikiMode()
	" Change working copy (for rg, fzf) when entering vimwiki
	lcd %:p:h

	set autoread " Auto update on external file changes

	" Auto Commit vimwiki pages https://superuser.com/questions/286290/is-there-any-way-to-hook-saving-in-vim-up-to-commiting-in-git
	" Also don't screw the screen: https://www.rockyourcode.com/til-how-to-execute-an-external-command-in-vim-and-reload-the-file/#whats-even-better
	"autocmd! BufWritePost * " Clear existing auto-commands

  	 " Inspired by https://gist.github.com/jondkinney/2040114
  	 " FUZZY FIND
  	 "nnoremap <C-f> :Rg<CR>

	"set spell spelllang=de,en
	"set spell

	" This line is causing display glitches on Linux terminals, so it's disabled for now.
	" https://stackoverflow.com/questions/20593268/vim-on-ubuntu-text-rendering-bug-repeating-and-disappearing-weirdly#25085808
	" set lines=50 columns=130

    	map <C-p> :call term_start("git-pull-helper", {'term_finish' : 'close'})<CR>
    	map <C-u> :call term_start("git-push-helper", {'term_finish' : 'close'})<CR>

	map <Leader>wp  :VimwikiDiaryPrevDay<CR>
    map <Leader>wn  :VimwikiDiaryNextDay<CR>
    set shiftwidth=2
    set expandtab


	set completefunc=CompleteLinks
	let g:vimwiki_table_mappings = 0
	nnoremap <C-Space> i
	inoremap <C-Space> <c-x><c-u>

endfunction


call VimwikiMode()


hi folded ctermbg=NONE


source ~/.vim/after/ftplugin/markdown.vim

" List linter prefers this
set shiftwidth=3

