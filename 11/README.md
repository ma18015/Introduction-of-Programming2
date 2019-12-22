12/16 第11回
---

**fopenのNULL checkをしていない場合，再提出にする**

* kihon11-2
  * テストを完全に自動化しているので目で確認する必要がありません
  * fopenのNULL checkに関しても自動化しています\
    （fp==NULLのような記述にのみ対応しています．fp!=NULLのような記述には対応していません．\
    またif文の条件の中ではなく普通にプログラム中にfp==NULLと記述してある場合も正常なチェックができません．）

12/16 11th class
---

**Must check Null for fopen().**

* kihon11-2
  * Testing is automated, so you don't have to check outputs.
  * But test check if the program check fopen null.\
    (test can only check fp==NULL)

