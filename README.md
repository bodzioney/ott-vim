Ott-Vim
=======

Vim syntax highlighting for the Ott programming language design tool.

http://www.cl.cam.ac.uk/~pes20/ott

Example loading with lazy.vim:
```lua
  {
    'tsung-ju/ott-vim',
    init = function()
      vim.g.ott_tex_builder = 'pdflatex'
      vim.g.ott_pdf_viewer = 'open'
    end,
  },
```
