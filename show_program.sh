#!/bin/bash
. ./util.sh --source-only

shpath=$PWD
cd $(dirname $0)
path=${2:-./src}
cd $path

# you can set file name as command line arg
# [ $# -ge 0 ] && tfile=$1 || tfile="" # same as below code
tfile=${1:-""}

n_file=`ls -1 $tfile*.c 2>/dev/null | wc -l`
if [ $n_file = 0 ]; then
  echo "There is no file starting with $tfile"
  exit 1
fi

# rm only exec files
efile=`ls $tfile* | grep -Ev "*.c"`
n_efile=`ls -1 $tfile* 2>/dev/null | grep -Ev "*.c" | wc -l`
if [ $n_efile -gt 0 ]; then
  echo "-- removed --------------"
  echo $efile
  echo "-------------------------"
  echo ""
  rm $efile
fi

# rm only exec files
efile=`ls $tfile* | grep -Ev "*.c"`
rm $efile
# c files which will be compiled
com_file=`ls $tfile*.c`
# download required files
wget http://www.math.sci.hiroshima-u.ac.jp/~m-mat/MT/MT2002/CODES/mt19937ar.sep.tgz -P $PWD/
tar zxvf mt19937ar.sep.tgz

fail=()
for cfile in $tfile*.c
do
  filename=`basename $cfile .c`
  printf "\n%s\n" "$pad"
  echo $filename
  printf "%s\n" "$line"
  gcc -lm "$PWD/$cfile" "mt19937ar.c" -o "$PWD/$filename" -Wall 2>> $shpath/gerr.log
  if [ $? -ne 0 ]; then
    fail+=( $cfile )
    echo -e "Compile filed." \
            "\n============================="
    continue
  fi
  cat $PWD/$cfile
  printf "%s\n" "$pad"
done

rm $PWD/mt19937ar.c\
   $PWD/mt19937ar.h\
   $PWD/mt19937ar.out\
   $PWD/mt19937ar.sep.tgz\
   $PWD/mtTest.c\
   $PWD/readme-mt.txt

n_efile=`ls $tfile* | grep -Ev "*.c" | wc -l`
echo -e "\n========Compile check========" \
        "\nSrc File      : $n_file" \
        "\nExecute File  : $n_efile" \
        "\nCompile Error : $(($n_file-$n_efile))" \
        "\n============================="

print_files fail[@] "Failed files"

