#!/usr/bin/env zsh

[[ ! -r "$HOME"/.opam/opam-init/init.zsh ]] || source "$HOME"/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null
eval "$(direnv hook zsh)"
