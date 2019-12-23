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
  midlen=$(( len+${#sting}-1 ))
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

null_check(){
  src=("${!1}")
  no_null_check=()

  for cfile in ${src[@]}; do
    vars=(`cat ${cfile} | tr -d " *" | pcregrep -o "(?<=FILE).*?(?=\;)" | tr "," " "`)
    # delete // comment out and spaces
    code=`cat ${cfile} | tr -d " " | grep -v "^\s*//"`
    # delete /**/ comment out
    code=`echo ${code} | sed -e "s/\/\*.*\*\// /"`

    for var in ${vars[@]}; do
      cond="${var}=fopen("
      # nc="if(${var}==NULL)"
      nc1="${var}==NULL"
      # nc2="${var}!=NULL"
      # nc3="(${var}=fopen(.*))==NULL"
      if [[ ${code} == *${cond}* ]]; then
        if [[ ${code} != *${nc1}* ]]; then
        # if ! { [[ ${code} != *${nc1}* ]] || [[ ${code} != *${nc2}* ]]; }; then
          no_null_check+=(`basename ${cfile}`)
          break
        fi
      fi
    done
  done

  if [ ${#no_null_check[@]} -gt 0 ]; then
    print_files no_null_check[@] "Not NULL check"
    return 1
  else
    printf "\n$pad\n"
    printf " $GREEN" "All files check NULL"
    printf "\n$pad\n"
    return 0
  fi
}

