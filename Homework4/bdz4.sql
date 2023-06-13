-- --1.	Вывести наименования товаров, у которых нет свойства, идентификатор которого задается параметром.
-- DECLARE @param int
-- SET @param = 2

-- SELECT Log.Goods.Good_id
-- FROM Log.Goods LEFT JOIN Log.Goods_Properties ON Log.Goods.Good_ID = Log.Goods_Properties.Good_ID
-- LEFT JOIN Log.Properties ON Log.Goods_Properties.Prop_ID = Log.Properties.Prop_ID
-- EXCEPT
-- SELECT Log.Goods.Good_id
-- FROM Log.Goods LEFT JOIN Log.Goods_Properties ON Log.Goods.Good_ID = Log.Goods_Properties.Good_ID
-- LEFT JOIN Log.Properties ON Log.Goods_Properties.Prop_ID = Log.Properties.Prop_ID
-- WHERE Log.Properties.Prop_ID = @param

-- --2.
-- SELECT TOP 5 Good_id
-- FROM Log.Goods_Properties
-- GROUP BY Good_ID
-- ORDER BY COUNT(Prop_ID) desc

-- --3.
-- DECLARE @param1 int
-- SET @param1 = 2

-- DECLARE @param2 int
-- SET @param2 = 3

-- SELECT T1.Good_name as Good_name1, T2.Good_name as Good_name2, T4.Value as Value1, T.Value as Value2, Property
-- FROM Log.Goods AS T1 LEFT JOIN Log.Goods_Properties AS T4 ON T1.Good_ID = T4.Good_ID
-- LEFT JOIN Log.Goods AS T2 ON T2.Good_id = @param2
-- LEFT JOIN Log.Goods_Properties AS T ON T2.Good_ID = T.Good_ID
-- LEFT JOIN Log.Properties AS T3 ON T.Prop_ID = T3.Prop_id AND T4.Prop_ID = T3.Prop_ID
-- WHERE T1.Good_id = @param1 

-- --4.
-- SELECT Log.Goods.Good_id
-- FROM Log.Goods LEFT JOIN Log.Goods_Properties ON Log.Goods.Good_id = Log.Goods_Properties.Good_ID
-- GROUP BY Log.Goods.Good_ID
-- HAVING COUNT(ISNULL(Prop_ID, 0)) < 5

-- --5.
-- DECLARE @goodid int 
-- SET @goodid = 1

-- DECLARE @time date 
-- SET @time = '20230427'

-- SELECT Prop_ID 
-- FROM Log.Goods_Properties_log 
-- WHERE Good_ID = @goodid AND Date_of_change < @time
-- GROUP BY Prop_ID
-- HAVING SUM(Action) != 0 

-- --7.
-- DECLARE @time1 date 
-- SET @time1 = '20230327'

-- SELECT distinct Good_ID
-- FROM Log.Goods_Properties_log AS T1
-- WHERE Date_of_change > @time1 AND Prop_ID NOT IN (SELECT T2.Prop_ID FROM Log.Goods_Properties_log AS T2 WHERE T2.Good_ID = T1.Good_ID AND Date_of_change < @time1)

-- --8.
-- DECLARE @time2 date 
-- SET @time2 = '20230327'

-- SELECT Good_ID 
-- FROM Log.Goods_Properties_log
-- EXCEPT
-- SELECT Good_ID 
-- FROM Log.Goods_Properties_log 
-- WHERE Date_of_change > @time2

-- --9.	Вывести товары и такие их свойства, которые имеются у товара на текущий момент, но не изменялись 
-- --(не добавлялись, не удалялись, не изменялись значения), начиная с даты, задаваемой параметром

-- DECLARE @time3 date 
-- SET @time3 = '20230327'

-- SELECT Good_ID, Prop_ID 
-- FROM Log.Goods_Properties_log 
-- GROUP BY Good_ID, Prop_ID
-- HAVING SUM(Action) != 0

-- EXCEPT 

-- SELECT Good_ID, Prop_ID 
-- FROM Log.Goods_Properties_log 
-- WHERE Date_of_change > @time3

-- --10.	Вывести товары, ВСЕ текущие свойства которых были добавлены до даты, задаваемой параметром, и не изменялись (не удалялись, не добавлялись, не изменялись значения) после этой даты. 
-- --Подумайте, в чём отличие от п.8 (подсказка: в п.10 говорится только про текущие свойства)

-- DECLARE @time4 date 
-- SET @time4 = '20230327'

-- SELECT Good_ID
-- FROM Log.Goods_Properties_log 
-- GROUP BY Good_ID, Prop_ID
-- HAVING SUM(Action) != 0 
-- EXCEPT
-- SELECT Good_ID
-- FROM Log.Goods_Properties_log 
-- WHERE Date_of_change > @time4

-- --11. 	Вывести товары и такие их свойства, которые изменялись до даты заданной параметром, но не изменялись после даты заданной параметром.

-- DECLARE @time5 date 
-- SET @time5 = '20230327'

-- SELECT Good_ID, Prop_ID
-- FROM Log.Goods_Properties_log 
-- WHERE Date_of_change < @time5
-- INTERSECT 
-- (SELECT Good_ID, Prop_ID
-- FROM Log.Goods_Properties_log 
-- EXCEPT 
-- SELECT Good_ID, Prop_ID
-- FROM Log.Goods_Properties_log 
-- WHERE Date_of_change > @time5 )

-- --12.	На каждую дату лога по каждому товару посчитайте количество свойств, которые имелись у товара на эту дату.

-- SELECT distinct Date_of_change, Good_ID, 
-- IIF(Action != -1, COUNT(Prop_ID) OVER(PARTITION BY Good_ID ORDER BY Date_of_change ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW), 
-- COUNT(Prop_ID) OVER(PARTITION BY Good_ID ORDER BY Date_of_change ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) - 1 )
-- FROM  Log.Goods_Properties_log
