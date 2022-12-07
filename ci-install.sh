#!/usr/bin/env bash

# This is the boostrap to setup environment on ci/cd

set -eu
printf '\n'

BOLD="$(tput bold 2>/dev/null || printf '')"
GREY="$(tput setaf 0 2>/dev/null || printf '')"
UNDERLINE="$(tput smul 2>/dev/null || printf '')"
RED="$(tput setaf 1 2>/dev/null || printf '')"
GREEN="$(tput setaf 2 2>/dev/null || printf '')"
YELLOW="$(tput setaf 3 2>/dev/null || printf '')"
BLUE="$(tput setaf 4 2>/dev/null || printf '')"
MAGENTA="$(tput setaf 5 2>/dev/null || printf '')"
NO_COLOR="$(tput sgr0 2>/dev/null || printf '')"

info() {
  printf '%s\n' "${BOLD}${GREY}>${NO_COLOR} $*"
}

warn() {
  printf '%s\n' "${YELLOW}! $*${NO_COLOR}"
}

error() {
  printf '%s\n' "${RED}x $*${NO_COLOR}" >&2
}

completed() {
  printf '%s\n' "${GREEN}✓${NO_COLOR} $*"
}

has() {
  command -v "$1" 1>/dev/null 2>&1
}

usage() {
  printf "%s\n" \
    "ci-install.sh [option]"
}

main() {
  HAS_VOLTA="$(has pnpm)"
  HAS_PNPM="$(has pnpm)"

  if [[ -n "$HAS_VOLTA" ]]; then
    info "> Installing volta"
    curl -fsSL https://get.volta.sh | sh -
  fi

  if [[ -n "$HAS_PNPM" ]]; then
    info "> Installing pnpm"
    curl -fsSL https://get.pnpm.io/install.sh | sh -
  fi

  completed "==> DONE"
}

# parse command line options
while [ "$#" -gt 0 ]; do
  arg="$1"
  case "$arg" in
  -h | --help)
    usage
    exit 0
    ;;
  *)
    error "Unknown option: '$arg'"
    usage
    exit 1
    ;;
  esac
done

# execute
main
