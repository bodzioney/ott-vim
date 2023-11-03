" Ott language file for vim
" Author: Peter-Michael Osera
" posera[at]cis[dot]upenn[dot]edu

if exists("b:current_syntax")
    finish
endif

let s:save_iskeyword = &l:iskeyword

silent! syn include @tex syntax/tex.vim | silent! unlet b:current_syntax
syn cluster texMathMatchGroup add=ottHomInner
syn cluster texClusterMath    add=ottHomInner

silent! syn include @coq syntax/coq.vim | silent! unlet b:current_syntax
syn cluster coqTerm           add=ottHomInner
syn clear   coqError

silent! syn include @isa syntax/isabelle.vim | silent! unlet b:current_syntax
silent! syn include @ocaml syntax/ocaml.vim | silent! unlet b:current_syntax

let &l:iskeyword = s:save_iskeyword
unlet s:save_iskeyword
syn iskeyword clear


syn case match

syn match   ottPunctuation ",\|::=\|::\|<::\|_::\|<="
syn match   ottPunctuation "|" nextgroup=ottElements

syn match   ottComment "%.*$"
syn region  ottComment start=">>" end="<<" contains=ottComment

syn region  ottElements contained start="" end="\ze::" contains=ottDots,ottComp

syn region  ottHom      matchgroup=ottHomDelim start="{{" end="}}" keepend contains=ottHomName,ottHomInner
syn region  ottHom      matchgroup=ottHomDelim start="{{\*" end="\*}}" keepend contains=ottHomName,ottHomInner
syn keyword ottHomName  contained com nextgroup=ottComHom skipwhite skipempty
syn keyword ottHomName  contained tex tex-preamble tex-wrap-pre tex-wrap-post nextgroup=ottTexHom skipwhite skipempty
syn keyword ottHomName  contained coq nextgroup=ottCoqHom skipwhite skipempty
syn keyword ottHomName  contained isa nextgroup=ottIsaHom skipwhite skipempty
syn keyword ottHomName  contained hol
syn keyword ottHomName  contained ocaml nextgroup=ottOcamlHom skipwhite skipempty
syn keyword ottHomName  contained coq-equality lex repr-locally-nameless phantom texvar isavar holvar ocamlvar aux lem ihtexlong order isasyn isaprec lemwcf coq-universe coq-lib isa-auxfn-proof isa-subrule-proof isa-proof
syn match   ottComHom   contained "\_.*" contains=@tex
syn match   ottTexHom   contained "\_.*" contains=@texMathMatchGroup,@texClusterMath
syn match   ottCoqHom   contained "\_.*" contains=@coq,@coqTerm
syn match   ottIsaHom   contained "\_.*" contains=ottHomInner,@isa
syn match   ottOcamlHom contained "\_.*" contains=ottHomInner,@ocaml
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
