--1 sales_old �Ƃ������O�̃e�[�u�����쐬
CREATE TABLE sales_old(
sales_id int primary key
,order_date date
,customer_id int
,amount decimal);

--2 sales_old �f�[�^�o�^���Ă��������B
INSERT INTO sales_old VALUES(6,'2018/09/02',2,20000)
,(7,'2018/09/02',1,5000)
,(8,'2018/09/02',3,6000)
,(9,'2018/09/05',1,3000);

--3 sales_old�e�[�u���̃f�[�^��sales�e�[�u���֒ǉ����Ă��������B
INSERT INTO sales SELECT * FROM sales_old;

--4 sales_old�e�[�u�����폜���Ă��������B
DROP TABLE sales_old;


--5 sales�e�[�u���ɑ΂��āAorder_date��'2018/10/01'���O�̃f�[�^���������������J����(�J��������is_old)���擾���Ă��������B
--���s���ʂ́Asales_id, order_id, is_old�݂̂�order_date�̏����ɕ\�����Ă��������B
SELECT sales_id , order_data
,CASE
    WHEN order_data < '2018/10/01' THEN '�Z'
    ELSE ''
END is_old
 FROM sales
 ORDER BY order_data;
 
--6 customer�e�[�u���ɑ΂��āAcustomer_id��customer_name�̒l����������������̃J����(�J��������customer_id_name)���擾���Ă��������B
--���s���ʂ́Acustomer_id_name�݂̂�customer_id�̏����ɕ\�����Ă��������B
SELECT customer_id || ':'|| customer_name customer_id_name 
FROM customer
ORDER BY customer_id;

--7 sales�e�[�u���ɑ΂��āAcustomer_id��1�̃��R�[�h���擾���Ă��������B
--�������A���s���ʂ�order_date�̍~���ɍő�2�����\�����Ă��������B
SELECT * FROM sales
WHERE customer_id = 1
ORDER BY order_data DESC
LIMIT 2;

--���W-8
--sales�e�[�u���ɑ΂��āAorder_date�̍ŏ��l�ƁAorder_date�����̒l�̎���amount�̍��v�l(�J��������sum_amount)���擾���Ă��������B
--(���オ���������ŏ��̓��t�ƁA���̓��̔���̍��v���z���擾)
--�T�u�N�G�����g�p���A��L�̌�����1��SQL���Ŏ��s���Ă��������B

SELECT min(order_data) , sum(amount) sum_amount
FROM sales
WHERE order_data = (SELECT min(order_data) FROM sales);

--9
--sales�e�[�u����customer�e�[�u����������customer_id�Acustomer_name���Ƃ�amount�̕��ϒl(�J��������avg_amount)���擾���Ă��������B
--(�ڋq���Ƃ̕��ϔ�����z���擾����)
--�������Aamount�̕��ϒl�́A�����_�ȉ��͐؂�̂Ăɂ��Ă��������B
--���s���ʂ́Acustomer_id, customer_name, avg_amount�݂̂�customer_id�̏����ɕ\�����Ă��������B

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

--10 sales�e�[�u���ɑ΂��āAorder_date��'2018/09/01'����'2018/09/30'�͈̔͂ŁAamount����ԑ傫�����R�[�h��\�����Ă��������B
--�T�u�N�G�����g�p���A��L�̌�����1��SQL���Ŏ��s���Ă��������B
SELECT * FROM sales
WHERE sales_id = (    
    SELECT sales_id
    FROM sales
    WHERE order_data BETWEEN '2018/09/01' AND '2018/09/30'
    ORDER BY amount DESC
    LIMIT 1);



--2018/09/01'����'2018/09/30'�͈̔͂�amount�̍~���ɍő�1������sales_id���擾��SQL�e�X�g
SELECT *
FROM sales
WHERE order_data BETWEEN '2018/09/01' AND '2018/09/30'
ORDER BY amount DESC
LIMIT 1;
        

--�e�[�u���m�F�p      
SELECT * FROM sales;
SELECT * FROM customer;
