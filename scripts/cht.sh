#!/usr/bin/env bash
languages=`echo "python php cpp javascript nodejs css" | tr ' ' '\n'`
core_utils=`echo "xargs find mv sed awk" | tr ' ' '\n'` 

selected=`printf "$languages" | fzf`
read -p "query: " query

curl cht.sh/$selected/`echo $query | tr ' ' '+'`

#if printf $languages | grep -qs $selected; then
#		curl cht.sh/$selected/`echo $query | tr ' ' '+'`
#else
#    curl cht.sh/$selected~$query
#fi
