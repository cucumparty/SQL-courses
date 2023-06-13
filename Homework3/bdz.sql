--Задача 1
-- У меня просто пропадает ребро (1, 3, 16) на первом же цикле, непонятно из-за чего и ничего дальше не получается. Вторая задача получается нормально.
--1)
-- DROP TABLE #Tree
-- DROP TABLE #FT 


-- CREATE TABLE #Tree (b int, e int, w int )
-- INSERT #Tree VALUES (1, 2, 1), (1, 3, 5), (2, 3, 16), (3, 4, 1), (3, 5, 1), (2, 6, 1), (3, 4, 1), (3, 5, 1)


-- CREATE TABLE #FT (b int, e int, w float) --вспомогательная таблица
-- INSERT #FT
-- 	SELECT b, e, w
-- 	FROM #Tree 
    
-- WHILE @@ROWCOUNT > 0  
-- BEGIN

-- 	INSERT #FT
-- 	SELECT NEW.b, NEW.e, NEW.w
-- 	FROM
-- 	(
-- 		SELECT T1.b, T2.e, T1.w * T2.w w
-- 		FROM #FT as T1 INNER JOIN #FT as T2 ON T1.e = T2.b
-- 	) as NEW LEFT JOIN #FT FT ON 
-- 		NEW.b = FT.b AND 
-- 		NEW.e = FT.e
-- 	WHERE FT.b is NULL
-- END

-- SELECT b, e, SUM(distinct w) as w
-- FROM #FT
-- WHERE b = 1 AND e NOT IN (SELECT b FROM #Tree)
-- GROUP BY b, e

-- DROP TABLE #Tree


-- --2)
-- DROP TABLE #graph
-- DROP TABLE #FT1

-- CREATE TABLE #graph (b int, e int, w int)
-- INSERT #graph VALUES (1, 2, 3), (1, 5, 2), (5, 7, 2), (5, 8, 4), (8, 6, 2), (8, 9, 1), (2, 3, 4), (3, 4, 3), (3, 6, 2)

-- CREATE TABLE #FT1 (b int, e int, w float) --вспомогательная таблица
-- INSERT #FT1
-- 	SELECT b, e, w
-- 	FROM #graph
    
-- WHILE @@ROWCOUNT > 0  
-- BEGIN

-- 	INSERT #FT1
-- 	SELECT NEW.b, NEW.e, NEW.w
-- 	FROM
-- 	(
-- 		SELECT T1.b, T2.e, T1.w * T2.w w
-- 		FROM #FT1 as T1 INNER JOIN #FT1 as T2 ON T1.e = T2.b
-- 	) as NEW LEFT JOIN #FT1 FT ON 
-- 		NEW.b = FT.b AND 
-- 		NEW.e = FT.e
-- 	WHERE FT.b is NULL
-- END

-- SELECT b, e, SUM(distinct w) as w
-- FROM #FT1
-- WHERE b = 1 AND e NOT IN (SELECT b FROM #graph)
-- GROUP BY b, e

-- DROP TABLE #graph
-- DROP TABLE #FT1

-- GO