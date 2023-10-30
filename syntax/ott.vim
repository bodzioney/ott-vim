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

syntax cluster texMathMatchGroup add=ottVarInMorphism
syntax cluster texClusterMath add=ottVarInMorphism

syn match   ottPuncuation           "::=\|::\|<::\|---\+\|\.\.\.\.\|\.\.\.\|\.\.\| | \|</\|/>\|//"
syn match   ottComment              "%.*$"
syn region  ottMorphism             start="{{" end="}}" contains=ottVarInMorphism, ottKeywordInMorphism
syn region  ottVarInMorphism        contained start="\[\[" end="\]\]"
syn keyword ottKeywordInMorphism    contained coq-equality lex repr-locally-nameless phantom texvar isavar holvar ocamlvar aux lem ihtexlong order isasyn isaprec lemwcf coq-universe coq-lib isa-auxfn-proof isa-subrule-proof isa-proof com
syn region  ottTexMorphism          matchgroup=ottMorphism start="{{ *\(tex\|tex-preamble\|tex-wrap-pre\|tex-wrap-post\)" end="}}" contains=@texMathMatchGroup,@texClusterMath
syn region  ottCoqMorphism          matchgroup=ottMorphism start="{{ *coq" end="}}" contains=ottVarInMorphism,@coq
syn region  ottIsaMorphism          matchgroup=ottMorphism start="{{ *isa" end="}}" contains=ottVarInMorphism,@isa
syn region  ottHolMorphism          matchgroup=ottMorphism start="{{ *hol" end="}}" contains=ottVarInMorphism,@hol
syn region  ottOcamlMorphism        matchgroup=ottMorphism start="{{ *ocaml" end="}}" contains=ottVarInMorphism,@ocaml

syn keyword ottKeyword              embed homs metavar indexvar grammar subrules
syn keyword ottKeyword              contextrules substitutions single multiple
syn keyword ottKeyword              freevars defns defn funs right left parsing
syn keyword ottKeyword              names distinctnames union by IN
" These keywords are more common; seems like it's more prudent to not highlight them
" syn keyword ottKeyword              fun bind in non

hi def link ottPuncuation            Structure
hi def link ottComment               Comment
hi def link ottMorphism              Macro
hi def link ottVarInMorphism         Identifier
hi def link ottKeywordInMorphism     Keyword

hi def link ottRule                  Normal

hi def link ottKeyword               Keyword

let b:current_syntax = "ott"
