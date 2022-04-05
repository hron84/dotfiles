#!/bin/bash

ME="$(readlink -f "$0")"
MYDIR="$(dirname "${ME}")"

# Input handling messes up with while/read cycle
# shellcheck disable=SC2044
for file in $(find "${MYDIR}" -type f -not -name "$(basename "$0")" -not -name README.md -not -name LICENSE.md -not -path "${MYDIR}/.git/*"); do
  # shellcheck disable=SC2001
  relname="$(echo "${file}" | sed "s@${MYDIR}/@@")"
  if [ -e "${HOME}/${relname}" ]; then
    echo " * File '${relname}' is exists, replace? (Y/n)"
    read -r ans
    case "${ans}" in
      n|N)
        echo ' >> Skipped'
        continue
        ;;
      *)
        rm -f "${HOME}/${relname}"
        ;;
    esac
  fi

  mkdir -p "${HOME}/$(dirname "${relname}")"
  ln -s "${file}" "${HOME}/${relname}"
done

if [ ! -d "${HOME}/.oh-my-zsh" ] ; then
  git clone git@github.com:hron84/oh-my-zsh.git "${HOME}/.oh-my-zsh"
fi
