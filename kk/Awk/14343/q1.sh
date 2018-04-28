#!/bin/bash

comment=0
string=0

while IFS= read -r filename;
do
    x=$(awk -f q1.awk "$filename")

    IFS=', ' read -r -a array <<< "$x"
    x1=${array[0]}
    x2=${array[1]}

    comment=$(($x1 + $comment))
    string=$(($x2 + $string))
done <<< "$(find $* -type f -iname '*.c' -print)"

echo "Total number of lines of comments: $comment"
echo "Total number of strings: $string"
