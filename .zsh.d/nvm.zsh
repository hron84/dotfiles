#!/bin/zsh

nvm_ver=v0.39.1
source "${HOME}/.zsh.d/plugin.zsh"

if [ ! -d "${HOME}/.nvm" ]; then
    curl -fsSkL "https://raw.githubusercontent.com/nvm-sh/nvm/${nvm_ver}/install.sh" | bash
fi

eval "$(plug "${HOME}/.nvm" "nvm.sh")"
