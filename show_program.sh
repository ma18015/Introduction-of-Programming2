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

fail=()
for cfile in $tfile*.c
do
  filename=`basename $cfile .c`
  printf "\n%s\n" "$pad"
  echo $filename
  printf "%s\n" "$line"
  gcc "$PWD/$cfile" -o "$PWD/$filename" 2>> $shpath/err.log
  if [ $? -ne 0 ]; then
    fail+=( $cfile )
    echo -e "Compile filed." \
            "\n============================="
    continue
  fi
  cat $PWD/$cfile
  printf "%s\n" "$pad"
done

n_efile=`ls $tfile* | grep -Ev "*.c" | wc -l`
echo -e "\n========Compile check========" \
        "\nSrc File      : $n_file" \
        "\nExecute File  : $n_efile" \
        "\nCompile Error : $(($n_file-$n_efile))" \
        "\n============================="

print_files fail[@] "Failed files"

