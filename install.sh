#!/bin/bash

ME="$(readlink -f "$0")"
MYDIR="$(dirname "${ME}")"

function ask() {
  local msg="$*"
  local ans

  if [ -t 0 ]; then
    echo " * ${msg}" >&2
  fi

  read -r ans
  echo "${ans}"
}

function _checksum() {
  file="$1"

  openssl md5 "${file}" | cut -d ' ' -f2
}

OMZ_REPO="git@github.com:hron84/oh-my-zsh.git"

if [ ! -f "${HOME}/.ssh/id_rsa" ]; then
  OMZ_REPO="https://github.com/hron84/oh-my-zsh.git"
fi

# Input handling messes up with while/read cycle
# shellcheck disable=SC2044
for file in $(find "${MYDIR}" -type f -not -name "$(basename "$0")" -not -name README.md -not -name LICENSE.md -not -path "${MYDIR}/.git/*"); do
  # We cannot use bash replace for cleanup because of directory separator
  # shellcheck disable=SC2001
  relname="$(echo "${file}" | sed "s@${MYDIR}/@@")"
  if [ -e "${HOME}/${relname}" ]; then
    if [ -f "${HOME}/${relname}" ] && [ "${HOME}/${relname}" -nt "${file}" ]; then
      echo " >> Skipped (newer is installed) ${relname}"
      continue
    fi

    if [ -f "${HOME}/${relname}" ] && [ "$(_checksum "${HOME}/${relname}")" != "$(_checksum "${file}")" ]; then
      ans="$(ask "File '${relname}' is exists and differs from original, replace? (Y/n)")"
      case "${ans}" in
        n|N)
          echo " >> Skipped ${relname}"
          continue
          ;;
        *)
          rm -f "${HOME}/${relname}"
          ;;
      esac
    fi
  fi

  mkdir -p "${HOME}/$(dirname "${relname}")"
  [ -e "${HOME}/${relname}" ] || ln -s "${file}" "${HOME}/${relname}"
done

if [ ! -d "${HOME}/.oh-my-zsh" ] ; then
  git clone "${OMZ_REPO}" "${HOME}/.oh-my-zsh"
fi
