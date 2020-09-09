#!/bin/bash

while [[ "$#" -gt 0 ]]; do
    case $1 in
        -d|--deploy) deploy="$2"; shift ;;
        -u|--uglify) uglify=1 ;;
        *) echo "Unknown parameter passed: $1"; exit 1 ;;
    esac
    shift
done

echo "Should deploy? $deploy"
echo "Should uglify? $uglify"
