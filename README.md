# Test Script for Introduction of Programming 2.

第一回などテストを作ってないものがあります． \
このテストはassert文が`printf`について対処できないため，assert文などを使ってテストしていません．単純にいくつかの入力に対しての出力を見れるだけなので実行結果は目で確認しなければなりません． \
一つの課題にだいたい3~5つのテストケースを用意しています．
何か追加したいテストケースがあったら各自で追加してください． \
また絶対にやったほうがいいなどのテストケースがある場合，プルリクやissueもしくは僕のメールアドレスに知らせてください．対処します．

他にうまいやり方や`printf`文に対処する方法など，何かアイデアのある人は教えてください...

テスト対象のプログラムのデフォルトの場所は`./src`です．
`download.sh`でダウンロードした場合は`./src`にダウンロードされます．ソースの場所を指定したい場合はテスト時に第一引数で指定できます． \
`show_program.sh`に関しては第一引数にどの課題かを指定しないといけないので，第二引数でソースの場所を指定できます．

* test script \
  課題チェックのためのスクリプト．単にいくつかのテストケースについて出力するだけ．なので目で確認しないといけないです．
* template \
  テストスクリプトのテンプレート．
* show_program.sh \
  第一引数で指定された課題のプログラムをすべて表示するスクリプト．プログラムの中身を確認しないといけないような課題などに使ってください．
  ```bash
  ./show_program.sh hatten10-1
  # with less
  ./show_program.sh hatten10-1 | less
  ```
* compile_test.sh \
  すべてのcファイルをコンパイルしてコンパイルが通るかどうかを確認するだけのスクリプト．ほとんど使い道はないです．
* download.sh \
  自分の班のソースをダウンロードするスクリプト．ダウンロードしたファイルは`./src`に保存されます．
  ```bash
  gnum=your_group_number pass=your_password id=your_student_id ./download.sh
  ```

---

I didn't make some test scripts. \
These scripts are not used assert or that kind of thing. \
Just run with some inputs and print ouputs, so you have to check the outputs with your own eyes. \
If you have any idea to solve this problem(especially how to deal with `printf`), plz let me know.

Defalt src path is `./src`, so plz put c files in src dir. \
Optionally, you can set your path to src by arg1 for all scripts below except for show\_program.sh. \
Only for show\_program.sh you can set path by arg2.
* test script \
  Run c file with some input cases and print outputs.
* template \
  Template for test script.
* show_program.sh \
  Display program whose name is set by arg1.
  ```bash
  ./show_program.sh hatten10-1
  # with less
  ./show_program.sh hatten10-1 | less
  ```
* compile_test.sh \
  Compile all program and check if compiling is passed.
* download.sh \
  To download your group src you just run this script like \
  `gnum=your_group_number pass=your_password id=your_student_id ./download.sh`

