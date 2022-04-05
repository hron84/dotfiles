#!/bin/zsh

source "${HOME}/.zsh.d/plugin.zsh"

if [ ! -d "${HOME}/.rvm" ] ; then
    curl -fSskL get.rvm.io | bash -s stable
fi

unset RUBYOPT
eval "$(plug "${HOME}/.rvm" "scripts/rvm")"

if type rvm &>/dev/null; then
    [[ -z "${RPROMPT}" ]] && RPROMPT='$(ruby_prompt_info)'
fi
