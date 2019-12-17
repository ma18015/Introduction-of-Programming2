#!/bin/bash

RED="\033[31m%s\033[m"
GREEN="\033[32m%s\033[m"
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

null_check(){
  basename=${1}
  arr=( $(grep -LE "\s*fp\s*==\s*NULL\s*" $basename*.c) )
  if [ ${#arr[@]} -gt 0 ]; then
    print_files arr[@] "Not NULL check"
    return 1
  else
    printf "\n$pad\n"
    printf $GREEN "All files check NULL"
    printf "\n$pad\n"
    return 0
  fi
}
