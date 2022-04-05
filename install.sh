#!/bin/bash

ME="$(readlink -f "$0")"
MYDIR="$(dirname "${ME}")"

# for file in $(find "${MYDIR}" -type f -not -name update.sh); do
while IFS= read -r -d '' file; do
  # shellcheck disable=SC2001
  relname="$(echo "${file}" | sed "s@${MYDIR}/@@")"
  if [ -e "${HOME}/${relname}" ]; then
    echo " * File '${relname}' is exists, replace? (Y/n)"
    read -r ans
    case "${ans}" in
      n|N)
        continue
        ;;
      *)
        rm -f "${HOME}/${relname}"
        ln -s "${file}" "${HOME}/${relname}"
        ;;
    esac
  fi
done < <(find "${MYDIR}" -type f -not -name $0 -not -name README.md -not -name LICENSE.md -not -path "${MYDIR}/.git/*" -print0)
