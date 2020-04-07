#!/bin/bash

set -e

project=${1%/}
repo=${2%/}
projectpath=${project//:/:\/}

container=leap:15.1


[ -n "${project}" ] || { >&2 echo "No project provided"; exit 1; }
[ -n "${repo}" ] || { >&2 echo "No repository provided"; exit 1; }

echo $projectpath $repo
for filename in scripts/templates/* ; do
    [ -e "$filename" ] || break
    mkdir -p $project/$repo
    m4 -D__wid=$wid -D__prj=$project -D__projectpath=$projectpath -D__repo=$repo -D__container=$container "$filename" > $project/$repo/$(basename $filename)
    [[ $filename != *.sh ]] || chmod +x $project/$repo/$(basename $filename)
done
