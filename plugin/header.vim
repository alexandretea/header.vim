" Vim File
" AUTHOR:   Agapo (fpmarias@google.com)
" FILE:     /usr/share/vim/vim70/plugin/header.vim
" CREATED:  21:06:35 05/10/2004
" MODIFIED: 2013-05-16 14:22:11
" TITLE:    header.vim
" VERSION:  0.1.3
" SUMMARY:  When a new file is created a header is added on the top too.
"           If the file already exists, the pluging update the field 'date of
"           the last modification'.
" INSTALL:  Easy! Copy the file to vim's plugin directory (global or personal)
"           and run vim.


" FUNCTION:
" Detect filetype looking at its extension.
" VARIABLES:
" comment = Comment symbol associated with the filetype.
" type = Path to interpreter associated with file or a generic title
" when the file is not a script executable.


function s:filetype()

  let s:file = expand("<afile>:t")
  let l:ft = &ft
  if l:ft ==# 'sh'
      let s:comment = "#"
      let s:type = s:comment . "!/usr/bin/env bash"
  elseif l:ft ==# 'python'
      let s:comment = "#"
      let s:type = s:comment . "!/usr/bin/env python"
  elseif l:ft ==# 'perl'
      let s:comment = "#"
      let s:type = s:comment . "!/usr/bin/env perl"
  elseif l:ft ==# 'vim'
      let s:comment = "\""
      let s:type = s:comment . " Vim File"
  elseif l:ft ==# 'c' || l:ft ==# 'cpp'
      let s:comment = "\/\/"
      let s:type = s:comment . " C/C++ File"
  elseif l:ft==# 'rst'
      let s:comment = ".."
      let s:type = s:comment . " reStructuredText "
  elseif l:ft==# 'php'
      let s:comment = "\/\/"
      let s:type = s:comment . " Php File "
  elseif l:ft ==# 'javascript'
      let s:comment = "\/\/"
      let s:type = s:comment . " Javascript File"
  else
    let s:comment = "#"
    let s:type = s:comment . " Text File"
  endif
  unlet s:file

endfunction


" FUNCTION:
" Insert the header when we create a new file.
" VARIABLES:
" author = User who create the file.
" file = Path to the file.
" created = Date of the file creation.
" modified = Date of the last modification.

function s:insert()

  call s:filetype()

  if exists("g:header_author")
      let s:_author = g:header_author
  else
      let s:_author = system("id -un | tr -d '\n'")
  endif

  let s:author = s:comment .    " Author:   " . s:_author
  let s:file = s:comment .      " File:     "
              \ . expand("%:p:h") . "/" . expand("%:t")
  let s:role = s:comment .      " Purpose:  TODO (a one-line explanation)"
  let s:created = s:comment .   " Created:  " . strftime("%Y-%m-%d %H:%M:%S")
  let s:modified = s:comment .  " Modified: " . strftime("%Y-%m-%d %H:%M:%S")

  call append(0, s:type)
  call append(1, "")
  call append(2, s:author)
  call append(3, s:file)
  call append(4, s:role)
  call append(5, s:created)
  call append(6, s:modified)

  unlet s:comment
  unlet s:type
  unlet s:author
  unlet s:file
  unlet s:role
  unlet s:created
  unlet s:modified

endfunction


" FUNCTION:
" Update the date of last modification.
" Check the line number 6 looking for the pattern.

function s:update ()

  call s:filetype ()

  let s:pattern = s:comment . " Modified: [0-9]"
  let s:line = getline(7)

  if match (s:line, s:pattern) != -1
    let s:modified = s:comment . " Modified: " . strftime("%Y-%m-%d %H:%M:%S")
    call setline(7, s:modified)
    unlet s:modified
  endif

  unlet s:comment
  unlet s:pattern
  unlet s:line

endfunction


autocmd BufNewFile * call s:insert()
autocmd BufWritePre * call s:update()

command HeaderInsert call s:insert()
