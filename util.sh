#!/bin/bash

pad=$(printf '%0.1s' "="{1..29})
pad_print(){
  padlength=29
  string=${1}
  len=$(( (padlength-${#string})/2 ))
  midlen=$(( len+${#sting} ))
  printf "\n%*.*s" 0 $len "$pad"
  printf "%s" "$string"
  printf "%*.*s\n" $midlen $(($padlength-$len-${#string})) "$pad"
}

print_files(){
  arr=("${!1}")
  item="${2}"
  if [ ${#arr[@]} -gt 0 ]; then
    pad_print "${item}"
    for failfile in ${arr[@]}; do
      echo " ${failfile}"
    done
    printf "%s\n" "$pad"
  fi
}
