#!/bin/sh

shpath=$PWD
cd $(dirname $0)
path=${1:-./src}
cd $path

# you can set file name as command line arg
# [ $# -ge 0 ] && tfile=$1 || tfile=""
tfile=${1:-""}

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

fail=()
for cfile in $tfile*.c
do
  filename=`basename $cfile .c`
  echo $filename
  gcc "$PWD/$cfile" -o "$PWD/$filename" 2>> $shpath/err.log
  if [ $? -ne 0 ]; then
    # fail("${fail[@]}" $cfile)
    fail+=( $cfile )
    echo -e "Compile filed." \
            "\n============================="
    continue
  fi
done

if [ ${#fail[@]} -gt 0 ]; then
  echo -e "\n\n========Failed files========="
  for failfile in ${fail[@]}; do
    echo ${failfile}
  done
  echo "============================="
fi

# n_efile=`find . -not -name "*.c" -type f | wc -l`
n_efile=`ls $tfile* | grep -Ev "*.c" | wc -l`
echo -e "\n============================" \
        "\nSrc File      : $n_efile" \
        "\nExecute File  : $n_file" \
        "\nCompile Error : $(($n_file-$n_efile))" \
        "\n============================"
