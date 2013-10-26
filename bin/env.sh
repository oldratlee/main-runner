#!/bin/bash
# determine base directory; preserve where you're running from


name=$(uname | tr A-Z a-z)

case "${name}" in
cygwin*)
    for d in $BASE/../conf $(echo $BASE/../lib/*.jar) ; do
        CLASS_PATH+="$(cygpath -w "${d}");"
    done
    ;;
*)
    CLASS_PATH=$BASE/../conf:`echo $BASE/../lib/*.jar | tr " " :`
    ;;
esac 
