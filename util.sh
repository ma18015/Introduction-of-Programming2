#!/bin/bash

RED="\e[31m%s\e[m"
GREEN="\e[32m%s\e[m"
YELLOW="\e[33m%s\e[m"
pad=$(printf "%0.1s" "="{1..40})
line=$(printf "%0.1s" "-"{1..40})

pad_print(){
  padlength=40
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
  arr=( $(grep -LE "\s*fp\s*==\s*NULL\s*" $basename*.c) )
  # arr=( $(cat $basename*.c | tr -d " " | grep -LE "==NULL" ) )
  # cat ./* | tr -d " *" | pcregrep -o --no-filename "(?<=FILE).*?(?=\;)"
  echo ${arr[@]}
  if [ ${#arr[@]} -gt 0 ]; then
    print_files arr[@] "Not NULL check"
    return 1
  else
    printf "\n$pad\n"
    printf " $YELLOW\n" "WARNING: NULL check is not completed"
    printf " $YELLOW\n\n" "         Please check by yourself"
    printf " $GREEN" "All files check NULL"
    printf "\n$pad\n"
    return 0
  fi
}

extract_filename(){
  src=${1}
  mode=${2}
  filename=`cat $src | tr -d " " | pcregrep -o --no-filename "(?<=fopen\(\").*?(?=\",\"$mode\"\))"`
  if [ ${#filename} -gt 0 ]; then
    echo "$filename"
  else
    echo "tmp.dat"
  fi
}

