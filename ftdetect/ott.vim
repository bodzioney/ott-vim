au BufRead,BufNewFile *.ott setf ott

" Define a function to run 'ott -i' and preview results
function! RunOttOnCurrentFile()
    let l:current_file = expand('%:p')
    let l:output = system('ott -i ' . shellescape(l:current_file))
    if v:shell_error
        echohl ErrorMsg | echom "Error running 'ott -i'" | echohl None
    else
        " Open a new preview buffer to show the results
        new
        setlocal buftype=nofile
        setlocal bufhidden=hide
        setlocal noswapfile
        " Insert the output into the buffer
        call setline(1, split(l:output, "\n"))
    endif
endfunction

" Map <leader>dc to the function in normal mode
nnoremap <leader>dc :call RunOttOnCurrentFile()<CR>
