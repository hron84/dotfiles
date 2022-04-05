#!/bin/zsh

source "${HOME}/.zsh.d/plugin.zsh"

if [ ! -d "${HOME}/.sdkman" ]; then
    curl -fsSkL "https://get.sdkman.io" | bash
fi

eval "$(plug "${HOME}/.sdkman" "bin/sdkman-init.sh")"
[[ -z "${SDKMAN_DIR}" ]] && export SDKMAN_DIR="${HOME}/.sdkman"

