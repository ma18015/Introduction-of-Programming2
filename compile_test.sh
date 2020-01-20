#!/bin/bash
. ./util.sh --source-only

shpath=$PWD
cd $(dirname $0)
path=${1:-./src}
cd $path

# you can set file name as command line arg
# [ $# -ge 0 ] && tfile=$1 || tfile=""
tfile=${2:-""}

# below find command is so bad
# find . -not -iname "*.c" -type f -delete

n_file=`ls -1 $tfile*.c 2> /dev/null | wc -l`
if [ $n_file = 0 ]; then
  echo "There is no file starting with $tfile"
  exit 1
fi

# rm only exec files
efile=`ls $tfile* | grep -Ev "*.c"`
rm $efile

com_file=`ls $tfile*.c`

# download required files
wget http://www.math.sci.hiroshima-u.ac.jp/~m-mat/MT/MT2002/CODES/mt19937ar.sep.tgz -P $PWD/
tar zxvf mt19937ar.sep.tgz

fail=()
for cfile in $com_file
do
  filename=`basename $cfile .c`
  echo $filename
  gcc -lm "$PWD/$cfile" "mt19937ar.c" -o "$PWD/$filename" -Wall 2>> $shpath/gerr.log
  if [ $? -ne 0 ]; then
    fail+=( $cfile )
    echo -e "Compile filed." \
            "\n============================="
    continue
  fi
done


rm $PWD/mt19937ar.c\
   $PWD/mt19937ar.h\
   $PWD/mt19937ar.out\
   $PWD/mt19937ar.sep.tgz\
   $PWD/mtTest.c\
   $PWD/readme-mt.txt


n_efile=`ls $tfile* | grep -Ev "*.c" | wc -l`
echo -e "\n============================" \
        "\nSrc File      : $n_efile" \
        "\nExecute File  : $n_file" \
        "\nCompile Error : $(($n_file-$n_efile))" \
        "\n============================"

print_files fail[@] "Failed files"

