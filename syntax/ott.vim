" Ott language file for vim
" Author: Peter-Michael Osera
" posera[at]cis[dot]upenn[dot]edu

if exists("b:current_syntax")
    finish
endif

syn case match

silent! syn include @tex syntax/tex.vim
silent! syn include @coq syntax/coq.vim
silent! syn include @isa syntax/isa.vim
silent! syn include @hol syntax/hol.vim
silent! syn include @ocaml syntax/ocaml.vim

syn cluster texMathMatchGroup add=ottHomInner
syn cluster texClusterMath    add=ottHomInner

syn match   ottPunctuation ",\|::=\|::\|<::\|_::\|<="
syn match   ottPunctuation "|" nextgroup=ottElements

syn match   ottComment "%.*$"
syn region  ottComment start=">>" end="<<" contains=ottComment

syn region  ottElements contained start="" end="\ze::" contains=ottDots,ottComp

syn region  ottHom      matchgroup=ottHomDelim start="{{" end="}}" keepend contains=ottHomName,ottHomInner
syn region  ottHom      matchgroup=ottHomDelim start="{{\*" end="\*}}" keepend contains=ottHomName,ottHomInner
syn keyword ottHomName  contained tex tex-preamble tex-wrap-pre tex-wrap-post nextgroup=ottTexHom skipwhite skipempty
syn keyword ottHomName  contained coq nextgroup=ottCoqHom skipwhite skipempty
syn keyword ottHomName  contained isa nextgroup=ottIsaHom skipwhite skipempty
syn keyword ottHomName  contained hol nextgroup=ottHolHom skipwhite skipempty
syn keyword ottHomName  contained ocaml nextgroup=ottOcamlHom skipwhite skipempty
syn keyword ottHomName  contained coq-equality lex repr-locally-nameless phantom texvar isavar holvar ocamlvar aux lem ihtexlong order isasyn isaprec lemwcf coq-universe coq-lib isa-auxfn-proof isa-subrule-proof isa-proof com skipwhite skipempty
syn match   ottTexHom   contained ".*" contains=@texMathMatchGroup,@texClusterMath
syn match   ottCoqHom   contained ".*" contains=ottHomInner,@coq
syn match   ottIsaHom   contained ".*" contains=ottHomInner,@isa
syn match   ottHolHom   contained ".*" contains=ottHomInner,@hol
syn match   ottOcamlHom contained ".*" contains=ottHomInner,@ocaml
syn region  ottHomInner contained matchgroup=ottHomInnerDelim start="\[\[" end="\]\]" extend contains=ottComp,ottDots

syn region  ottBindspec            matchgroup=ottBindspecDelim start="(+" end="+)" contains=ottComment,ottDots,ottComp,ottBindspecKeyword,ottBindspecPunctuation
syn keyword ottBindspecKeyword     contained bind in names distinctnames union
syn match   ottBindspecPunctuation contained "=\|#\|(\|)\|{}"

syn match   ottDots      contained "\.\.\.\.\|\.\.\.\|\.\."
syn region  ottComp      contained matchgroup=ottCompDelim start="</" end="/>" keepend contains=ottDots,ottCompDelim
syn match   ottCompDelim contained "//"
syn keyword ottCompDelim contained "IN"

syn region  ottRules       matchgroup=ottKeyword start="\<by\>" end="\ze\<\(grammar\|embed\|homs\|metavar\|indexvar\|subrules\|contextrules\|substitutions\|freevars\|parsing\|defns\|begincoqsection\|endcoqsection\|coqvariable\|defn\|funs\|fun\)\>" end="\%$" contains=ottHom,ottLineLine,ottCommentLine
syn region  ottCommentLine contained start="^\s*\zs%" end="$"
syn region  ottLineLine    contained matchgroup=ottPunctuation start="^\s*\zs-----*" end="$"

syn keyword ottKeyword defn fun nextgroup=ottElements skipwhite skipempty
syn keyword ottKeyword embed homs metavar indexvar grammar subrules
syn keyword ottKeyword contextrules substitutions single multiple
syn keyword ottKeyword freevars parsing begincoqsection endcoqsection coqvariable
syn keyword ottKeyword left right non defns funs

hi def link ottPunctuation         Structure
hi def link ottDots                ottPunctuation
hi def link ottCompDelim           ottPunctuation
hi def link ottBindspecDelim       ottPunctuation
hi def link ottBindspecPunctuation ottPuncuation

hi def link ottComment     Comment
hi def link ottCommentLine ottComment

hi def link ottHomDelim      Macro
hi def link ottHomInnerDelim Macro

hi def link ottKeyword         Keyword
hi def link ottHomKeyword      ottKeyword
hi def link ottBindspecKeyword ottKeyword

hi def link ottElements Normal
hi def link ottRules    Normal


let b:current_syntax = "ott"
