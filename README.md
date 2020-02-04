# diary tempalte with interpreter

これは対話ベースで日誌を書くシステムである．
好きなエディタ (vim or emacs) で日誌を書き，
日誌を書いた回数や合計滞在時間を確認することができる．
対話ベースで，日誌を書く年月日が正しいかどうかを確認する．

## diary file format
1. year-month-day-week
2. hour:min (start time)
3. hour:min (fin   time)
4. day count
5. -- comment
6. --

# system

./year/month/day という管理になっている．
基本的にその日のファイルはその日にしか編集できない．
最近編集した day ファイルは .now リンクファイルに張られており，
次の日は，.now リンクファイルをベースに day count をインクリメントする．

# usage

1. ./diary.sh
2. 表示された日が正しいか答える ( y/n
3. もし，no と答えた場合は，昨日の日付として登録される
4. この日の日誌ファイルを作成していいか答える ( return or ^C
5. もし，その年，月のディレクトリがない場合は作ってよいか聞かれる ( return or ^C
6. その日の日誌を編集する
7. 明日になったら，1 へ戻る
