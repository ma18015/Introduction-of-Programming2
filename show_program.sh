#!/bin/sh

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

for cfile in $tfile*.c
do
  echo "============================"
  filename=`basename $cfile .c`
  echo $filename
  echo "----------------------------"
  gcc "$PWD/$cfile" -o "$PWD/$filename"
  echo "----------------------------"
  cat $PWD/$cfile
  echo -e "============================\n"
done

n_efile=`ls $tfile* | grep -Ev "*.c" | wc -l`

echo -e "========compile check========" \
        "\nSrc File      : $n_file" \
        "\nExecute File  : $n_efile" \
        "\nCompile Error : $(($n_file-$n_efile))" \
        "\n============================="
