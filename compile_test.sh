#!/bin/sh

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

for cfile in $tfile*.c
do
    filename=`basename $cfile .c`
    echo $filename
    gcc "$PWD/$cfile" -o "$PWD/$filename"
done

# n_efile=`find . -not -name "*.c" -type f | wc -l`
n_efile=`ls $tfile* | grep -Ev "*.c" | wc -l`

echo -e "\n============================" \
        "\nSrc File      : $n_efile" \
        "\nExecute File  : $n_file" \
        "\nCompile Error : $(($n_file-$n_efile))" \
        "\n============================"