#!/bin/bash

RED="\e[31m%s\e[m"
GREEN="\e[32m%s\e[m"
YELLOW="\e[33m%s\e[m"
pad=$(printf "%0.1s" "="{1..29})

pad_print(){
  padlength=29
  string=${1}
  len=$(( (padlength-${#string})/2 ))
  midlen=$(( len+${#sting} ))
  printf "\n%*.*s" 0 $((len-1)) "$pad"
  printf " $RED " "${string}"
  printf "%*.*s\n" $midlen $((padlength-len-${#string}-1)) "$pad"
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
  # arr=( $(grep -LE "\s*fp\s*==\s*NULL\s*" $basename*.c) )
  arr=( $(grep -LE "==\s*NULL\s*" $basename*.c) )
  if [ ${#arr[@]} -gt 0 ]; then
    print_files arr[@] "Not NULL check"
    return 1
  else
    printf "\n$pad\n"
    printf " $YELLOW\n" "WARNING: NULL check is not completed"
    printf " $YELLOW\n" "         Please check by yourself"
    printf " $GREEN" "All files check NULL"
    printf "\n$pad\n"
    return 0
  fi
}

extract_filename(){
  src=${1}
  wrotefile=`pcregrep -o --no-filename "(?<=fopen\(\"|fopen\(\s\").*?(?=\",\"w\"\)|\",\s\"w\"\))" $src`
  if [ ${#wrotefile} -gt 0 ]; then
    echo "$wrotefile"
  else
    echo "tmp.dat"
  fi
}
