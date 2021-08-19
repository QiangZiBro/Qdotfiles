#!/bin/bash
# ref1:https://gist.github.com/hfossli/4368aa5a577742c3c9f9266ed214aa58
# ref2:https://stackoverflow.com/questions/192249/how-do-i-parse-command-line-arguments-in-bash

CLEAR='\033[0m'
RED='\033[0;31m'

function usage() {
  if [ -n "$1" ]; then
    echo -e "${RED}☺️ $1${CLEAR}\n"
  fi
  echo "Usage: $0 [-n number-of-people] [-s section-id] [-c cache-file]"
  echo "  -n, --number-of-people   The number of people"
  echo "  -s, --section-id         A sections unique id"
  echo "  -q, --quiet              Only print result"
  echo ""
  echo "Example: $0 --number-of-people 2 --section-id 1"
  exit 1
}

# parse params
while [[ "$#" > 0 ]]; do case $1 in
  -n | --number-of-people)
    NUMBER_OF_PEOPLE="$2"
    shift
    shift
    ;;
  -s | --section-id)
    SECTION_ID="$2"
    shift
    shift
    ;;
  -v | --verbose)
    VERBOSE=1
    shift
    ;;
  *)
    usage "Unknown parameter passed: $1"
    shift
    shift
    ;;
  esac done

# verify paams
if [ -z "$NUMBER_OF_PEOPLE" ]; then usage "Number of people is not set"; fi
if [ -z "$SECTION_ID" ]; then usage "Section id is not set."; fi
