:set noerrorbells  " turns off error noise
:set visualbell
:set tabstop=4     " Set the tabstop to 4 spaces
:set shiftwidth=4  " Shiftwidth should match tabstop
:set expandtab     " Convert tabs to <tabstop> number of spaces

:set backupdir=$HOME/tmp
:set directory=$HOME/tmp
                   " Use :set noexpandtab to disable
":set backspace=2
:set backspace=indent,eol,start
:fixdel                  
:set nowrap        " Do not wrap lines longer than the window
:set nowrapscan    " Do not wrap while searching
:set ruler         " Show the cursor position all the time
:set showmatch     " Show matching () {} etc...
:set smartindent   " vim will try to help you indent your code.
:set showmode      " shows mode
":set number        " Show line numbers
":set hlsearch      " Highlight what you're searching for
:set incsearch     " Do incremental seraching as you type
:set ignorecase
:set smartcase      "searches are case sensitive only when
                    "there is a capital letter


" Switch syntax highlighting on, when the terminal has colors
if &t_Co > 2 || has("gui_running")
    :syntax on
    " Change the highlight color for Comment and Special
    " to Cyan.  Blue is too dark for a black background.
    " uncomment below lines when using black background
"    :highlight Comment term=bold ctermfg=6 guifg=Cyan
"    :highlight Special term=bold ctermfg=6 guifg=Cyan
endif

" Transparent editing of gpg encrypted files.
" By Wouter Hanegraaff <wouter@blub.net>
augroup encrypted
    au!

    " First make sure nothing is written to ~/.viminfo while editing
    " an encrypted file.
    autocmd BufReadPre,FileReadPre      *.gpg set viminfo=
    " We don't want a swap file, as it writes unencrypted data to disk
    autocmd BufReadPre,FileReadPre      *.gpg set noswapfile
    " Switch to binary mode to read the encrypted file
    autocmd BufReadPre,FileReadPre      *.gpg set bin
    autocmd BufReadPre,FileReadPre      *.gpg let ch_save = &ch|set ch=2
    autocmd BufReadPost,FileReadPost    *.gpg '[,']!gpg --decrypt 2> /dev/null
    " Switch to normal mode for editing
    autocmd BufReadPost,FileReadPost    *.gpg set nobin
    autocmd BufReadPost,FileReadPost    *.gpg let &ch = ch_save|unlet ch_save
    autocmd BufReadPost,FileReadPost    *.gpg execute ":doautocmd BufReadPost " . expand("%:r")

    " Convert all text to encrypted text before writing
    autocmd BufWritePre,FileWritePre    *.gpg   '[,']!gpg --default-recipient-self -ae 2>/dev/null
    " Undo the encryption so we are back in the normal text, directly
    " after the file has been written.
    autocmd BufWritePost,FileWritePost    *.gpg   u
augroup END

"turn of expandtab for makefiles
:autocmd BufNewFile,BufRead [Mm]akefile* set noexpandtab
"show line numbers on source code
:autocmd BufNewFile,BufRead *.c set number
:autocmd BufNewFile,BufRead *.pl set number
:autocmd BufNewFile,BufRead *.cpp set number
:autocmd BufNewFile,BufRead *.c++ set number
:autocmd BufNewFile,BufRead *.java set number
:autocmd BufNewFile,BufRead *.sh set number
:autocmd BufNewFile,BufRead *.py set number
