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


" Set default executables for LaTeX builder and PDF viewer
let g:ott_tex_builder = vim.g.ott_tex_builder or 'pdflatex'
let g:ott_pdf_viewer = vim.g.ott_pdf_viewer or 'open'

" Define a function to generate, build, and preview the .tex file
function! PreviewOttTex()
    let l:current_file = expand('%:p')
    let l:tex_file = substitute(l:current_file, '\.\w\+$', '.tex', '')

    " Run 'ott -i' to generate the .tex file
    let l:output = system('ott -i ' . shellescape(l:current_file) . ' -o ' . shellescape(l:tex_file . '.tex'))
    if v:shell_error
        echohl ErrorMsg | echom "Error running 'ott -i'" | echohl None
        return
    endif

    " Compile the .tex file with the configured LaTeX builder
    let l:compile_output = system(g:ott_tex_builder . ' ' . shellescape(l:tex_file . '.tex'))
    if v:shell_error
        echohl ErrorMsg | echom "Error building LaTeX file" | echohl None
        return
    endif

    " Open the generated PDF with the configured PDF viewer
    execute 'silent !' . g:ott_pdf_viewer . ' ' . shellescape(l:tex_file . '.pdf') . ' &'
endfunction

" Map <leader>dp to the function in normal mode
nnoremap <leader>dp :call PreviewOttTex()<CR>
