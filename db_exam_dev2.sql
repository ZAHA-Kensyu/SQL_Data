--1 sales_old という名前のテーブルを作成
CREATE TABLE sales_old(
sales_id int primary key
,order_date date
,customer_id int
,amount decimal);

--2 sales_old データ登録してください。
INSERT INTO sales_old VALUES(6,'2018/09/02',2,20000)
,(7,'2018/09/02',1,5000)
,(8,'2018/09/02',3,6000)
,(9,'2018/09/05',1,3000);

--3 sales_oldテーブルのデータをsalesテーブルへ追加してください。
INSERT INTO sales SELECT * FROM sales_old;

--4 sales_oldテーブルを削除してください。
DROP TABLE sales_old;


--5 salesテーブルに対して、order_dateが'2018/10/01'より前のデータが分かる印をつけたカラム(カラム名はis_old)を取得してください。
--実行結果は、sales_id, order_id, is_oldのみをorder_dateの昇順に表示してください。
SELECT sales_id , order_data
,CASE
    WHEN order_data < '2018/10/01' THEN '〇'
    ELSE ''
END is_old
 FROM sales
 ORDER BY order_data;
 
--6 customerテーブルに対して、customer_idとcustomer_nameの値を結合した文字列のカラム(カラム名はcustomer_id_name)を取得してください。
--実行結果は、customer_id_nameのみをcustomer_idの昇順に表示してください。
SELECT customer_id || ':'|| customer_name customer_id_name 
FROM customer
ORDER BY customer_id;

--7 salesテーブルに対して、customer_idが1のレコードを取得してください。
--ただし、実行結果はorder_dateの降順に最大2件分表示してください。
SELECT * FROM sales
WHERE customer_id = 1
ORDER BY order_data DESC
LIMIT 2;

--発展-8
--salesテーブルに対して、order_dateの最小値と、order_dateがその値の時のamountの合計値(カラム名はsum_amount)を取得してください。
--(売上が発生した最初の日付と、その日の売上の合計金額を取得)
--サブクエリを使用し、上記の検索を1つのSQL文で実行してください。

SELECT min(order_data) , sum(amount) sum_amount
FROM sales
WHERE order_data = (SELECT min(order_data) FROM sales);

--9
--salesテーブルとcustomerテーブルを結合しcustomer_id、customer_nameごとのamountの平均値(カラム名はavg_amount)を取得してください。
--(顧客ごとの平均売上金額を取得する)
--ただし、amountの平均値は、小数点以下は切り捨てにしてください。
--実行結果は、customer_id, customer_name, avg_amountのみをcustomer_idの昇順に表示してください。

SELECT s.customer_id,c.customer_name, trunc(avg(amount),0)
FROM sales s
JOIN customer c
ON s.customer_id = c.customer_id
GROUP BY s.customer_id,c.customer_name
ORDER BY s.customer_id;

SELECT c.customer_id , c.customer_name , trunc(avg(s.amount),0)
FROM customer c
JOIN sales s
ON c.customer_id = s.customer_id
GROUP BY c.customer_id,c.customer_name
ORDER BY c.customer_id;

--10 salesテーブルに対して、order_dateが'2018/09/01'から'2018/09/30'の範囲で、amountが一番大きいレコードを表示してください。
--サブクエリを使用し、上記の検索を1つのSQL文で実行してください。
SELECT * FROM sales
WHERE sales_id = (    
    SELECT sales_id
    FROM sales
    WHERE order_data BETWEEN '2018/09/01' AND '2018/09/30'
    ORDER BY amount DESC
    LIMIT 1);



--2018/09/01'から'2018/09/30'の範囲でamountの降順に最大1件分のsales_idを取得のSQLテスト
SELECT *
FROM sales
WHERE order_data BETWEEN '2018/09/01' AND '2018/09/30'
ORDER BY amount DESC
LIMIT 1;
        

--テーブル確認用      
SELECT * FROM sales;
SELECT * FROM customer;
