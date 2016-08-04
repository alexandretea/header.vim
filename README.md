# header.vim
Forked from [vim-scripts/header.vim](https://github.com/vim-scripts/header.vim) to implement those features :
* different header template
* if the variable `g:header_author` is set, the author will be set with this variable's value instead of the os' user

___
## Original README
This is a mirror of http://www.vim.org/scripts/script.php?script_id=1142

When a new file is created the plugin inserts automatically a customizable header on the top -filetype, author, timestamp-. When the file it's no new -so it's already created- the plugin checks the 'last modified' field in line number five -if this exists- and then it updates its value. It's my first vim plugin and it's very plain -I beg pardon to vim's gurus for my daring!- I didn't find anything alike, so I had to write my own script. Any correction or modification will be welcome.
