exampleMateView
===============

example materialized view


*これはなに？
これは、Oracleのマテライズドビューの使用例です。

表領域
  my01
  my02
があることを想定しており、そこから始まります。

>bigtable1 0..1 - 1 inx
>          1..  - 1 bigdata2
>
>bigtable1は履歴管理している。
なテーブルで、bigdata2 の存在しないデータを
マテライズドビューで表示することを考えます。




*各ファイルの説明
1.01CreateTable.sh
  bigdata1,bigdata2,inx をつくります。
bigdata1 は、
更新回数(seq)をもっており、同一テーブルに過去の履歴も管理している想定です。
inxテーブル、bigdata1のデータの有効／無効を管理しており、FK inxでひも付きます。
bigdata2は、bigdata1と同じ行為に対し、付随情報を管理しています。こちらは、更新回数を持っていません。
ただし、削除案件がるため、場合によっては削除されます。


02insertExampleData.sh*
テストデータの作成です。
ruby で、insertSQLのテキストファイルを作成し、
SQLPlusに実行させます。
本当はactiveRecodeを使いたかったのですが。。うまく行かず。


03view.sh*
やりたいことは、bigdataの最新データに対し、bigdata2が存在していないデータを
何とかすることです。
PL/SQLのfunctionを使ってみて更新回数の最大値を求めるようにしましたが。。
ん。。といった感じ。
一層のことSQLで頑張ってみたけど。。ん。。

まぁ、そんな塩梅でまずは、viewを作って見ました。


04mateView.sh*
実際にマテライズドビューを作って見ました。
しかし。。。高速更新(差分更新)？を行うには、
サブクリエは使えない！！！
えー。。


05addTestData.sh*
追加データです。手抜きです。

90RefreshMV.sh*
マテライズドビューを完全再構築します。



oracle.env*
shell上でSQLを発行しやすくするためのなにかです。


