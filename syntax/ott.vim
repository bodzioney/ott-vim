" Ott language file for vim
" Author: Peter-Michael Osera
" posera[at]cis[dot]upenn[dot]edu

if exists("b:current_syntax")
    finish
endif

let s:save_iskeyword = &l:iskeyword

if !empty(globpath(&rtp, 'syntax/tex.vim'))
  syn include @tex syntax/tex.vim
  unlet b:current_syntax
  syn cluster texMathMatchGroup add=ottHomInner
  syn cluster texClusterMath    add=ottHomInner
endif

if !empty(globpath(&rtp, 'syntax/coq.vim'))
  syn include @coq syntax/coq.vim
  unlet b:current_syntax
  syn cluster coqTerm           add=ottHomInner
  syn clear   coqError
endif

if !empty(globpath(&rtp, 'syntax/isabelle.vim'))
  syn include @isa syntax/isabelle.vim
  unlet b:current_syntax
endif

if !empty(globpath(&rtp, 'syntax/ocaml.vim'))
  syn include @ocaml syntax/ocaml.vim
  unlet b:current_syntax
endif

let &l:iskeyword = s:save_iskeyword
unlet s:save_iskeyword
syn iskeyword clear


syn case match

syn match   ottPunctuation ",\|::=\|::\|<::\|_::\|<="
syn match   ottPunctuation "|" nextgroup=ottElements

syn match   ottComment "%.*$"
syn region  ottComment start=">>" end="<<" contains=ottComment

syn region  ottElements contained start="" end="\ze::" contains=ottDots,ottComp

function s:define_hom(name, hom_name, contains)
  execute 'syn region ' . a:name . ' matchgroup=ottHomDelim start="{{\z(\*\?\)\_s*' . a:hom_name . '\ze\_[^A-Za-z-]" end="\z1}}" keepend contains=' . a:contains
endfunction

call s:define_hom('ottGeneralHom', '[A-Za-z-]*', '@ottHomInner')
call s:define_hom('ottComHom', 'com', '@tex')
call s:define_hom('ottTexHom', 'tex', '@tex,@texMathMatchGroup,@texClusterMath')
call s:define_hom('ottTexHom', '\%(tex-preamble\|tex-wrap-pre\|tex-wrap-post\)', '@tex')
call s:define_hom('ottCoqHom', 'coq', '@coq,@coqTerm')
call s:define_hom('ottIsaHom', 'isa', '@isa')
call s:define_hom('ottOcamlHom', 'ocaml', '@ocaml')

syn region  ottHomInner contained matchgroup=ottHomInnerDelim start="\[\[" end="\]\]" extend contains=ottComp,ottDots

syn region  ottBindspec            matchgroup=ottBindspecDelim start="(+" end="+)" contains=ottComment,ottDots,ottComp,ottBindspecKeyword,ottBindspecPunctuation
syn keyword ottBindspecKeyword     contained bind in names distinctnames union
syn match   ottBindspecPunctuation contained "=\|#\|(\|)\|{}"

syn match   ottDots      contained "\.\.\.\.\|\.\.\.\|\.\."
syn region  ottComp      contained matchgroup=ottCompDelim start="</" end="/>" contains=ottDots,ottCompDelim
syn match   ottCompDelim contained "//"
syn keyword ottCompDelim contained "IN"

syn region  ottRules       contained start="" end="\ze\<\(grammar\|embed\|homs\|metavar\|indexvar\|subrules\|contextrules\|substitutions\|freevars\|parsing\|defns\|begincoqsection\|endcoqsection\|coqvariable\|defn\|funs\|fun\)\>" contains=ottHom,ottLineLine,ottCommentLine
syn region  ottCommentLine contained start="^\s*\zs%" end="$"
syn region  ottLineLine    contained matchgroup=ottPunctuation start="^\s*\zs-----*" end="$"

syn keyword ottKeyword defn fun nextgroup=ottElements skipwhite skipempty
syn keyword ottKeyword by nextgroup=ottRules skipwhite skipempty
syn keyword ottKeyword embed homs metavar indexvar grammar subrules
syn keyword ottKeyword contextrules substitutions single multiple
syn keyword ottKeyword freevars parsing begincoqsection endcoqsection coqvariable
syn keyword ottKeyword left right non defns funs

hi def link ottPunctuation         Structure
hi def link ottDots                ottPunctuation
hi def link ottCompDelim           ottPunctuation
hi def link ottBindspecDelim       ottPunctuation
hi def link ottBindspecPunctuation ottPunctuation

hi def link ottComment     Comment
hi def link ottCommentLine ottComment

hi def link ottHomDelim      Macro
hi def link ottHomInnerDelim Macro

hi def link ottKeyword         Keyword
hi def link ottHomName         ottKeyword
hi def link ottBindspecKeyword ottKeyword

hi def link ottElements Normal
hi def link ottRules    Normal


let b:current_syntax = "ott"
