--БДЗ 1 (Матрицы)

/* 1. 4 атрибута :номер матрицы, столбец матрицы, столбец матрицы и значение в этой ячейке матрицы.
Очевидно, находится в 1НФ, так как нет одинаковых кортежей, кортежи не упорядочены, атрибуты не упорядочены и различаются по наименованию, все значения атрибутов атомарны.
Очевидно, находится в 2НФ, так как каждый некючевой атрибут(он всего один) зависит полностью от первичного ключа.
И так как, нет никаких транзитивный зависимостей неключевых атрибутов от какого-либо ключа( неключевых вообще всего один), то БД находится и в 3НФ.
*/


-- --2.
-- DECLARE @param as INT
-- SET @param = 1

-- SELECT col_id, row_id, val 
-- FROM Matrix
-- WHERE M_id = @param

-- --3.
-- DECLARE @param as INT
-- SET @param = 1

-- SELECT col_id as row_id, row_id as col_id, val 
-- FROM Matrix
-- WHERE M_id = @param

-- --4.
-- DECLARE @param_1 as INT, @param_2 as FLOAT
-- SET @param_1 = 1
-- SET @param_2 = 2

-- SELECT col_id , row_id , val * @param_2 as val
-- FROM Matrix
-- WHERE M_id = @param_1

-- --5.
-- DECLARE @param as INT
-- SET @param = 2


-- SELECT 
--     CASE
--         WHEN MAX(row_id) = 1 THEN 'yes'
--         WHEN MAX(col_id) = 1 THEN 'yes'
--         ELSE 'no'
--     END AS Vector

-- FROM Matrix
-- WHERE M_id = @param

-- --6.
-- DECLARE @param as INT
-- SET @param = 3

-- SELECT
--     CASE 
--         WHEN MAX(row_id) = MAX(col_id) THEN 'yes'
--         ELSE 'no'
--     END AS Quadrat 

-- FROM Matrix
-- WHERE M_id = @param

-- --7.
--Посчитаем колво строк из матрицы и транспонированной ей, в которых позиции (i, j) совпадают,
--а значение нет. Если ноль, то симметричная.

-- DECLARE @param as INT
-- SET @param = 2

-- SELECT 
--     CASE 
--         WHEN COUNT(*) = 0 THEN 'yes'
--         ELSE 'no'
--     END AS Symmetry

-- FROM
-- (SELECT M_id, col_id, row_id, val 
-- FROM Matrix 
-- WHERE M_id = @param) AS M1, (SELECT M_id, col_id as row_id, row_id as col_id, val 
-- FROM Matrix 
-- WHERE M_id = @param) AS M2
-- WHERE M1.row_id = M2.row_id AND M1.col_id = M2.col_id AND M1.val <> M2.val

-- --8.
-- DECLARE @param as INT
-- SET @param = 2


-- --Исходная матрица 
-- SELECT *
-- FROM Matrix
-- WHERE M_id = @param
-- ORDER BY row_id ASC, col_id ASC;

-- SELECT M_id, col_id / 2 as col_id, (row_id / 2 + 1) as row_id, val
-- FROM Matrix
-- WHERE M_id = @param AND (col_id % 2) = 0 AND (row_id % 2) = 1
-- ORDER BY col_id ASC, row_id ASC


-- --9.
-- DECLARE @param as INT
-- SET @param = 2

-- DECLARE @D TABLE
-- (
--     col_id INT NOT NULL, 
--     row_id INT NOT NULL,
--     val float, 
--     PRIMARY KEY(row_id, col_id)
-- )

-- INSERT INTO @D VALUES 
-- (1, 1, 1),
-- (1, 2, 2),
-- (2, 1, 3),
-- (2, 2, 3),
-- (3, 1, 3),
-- (3, 2, 1)

-- SELECT DISTINCT T1.col_id, T1.row_id, T1.val 
-- FROM Matrix AS T1, @D as T2, @D as T3
-- WHERE M_id = @param AND T2.row_id = 1 AND T3.row_id = 2 AND T2.col_id = T3.col_id AND
-- T1.row_id = T2.val AND T1.col_id = T3.val

-- SELECT col_id, row_id, val 
-- FROM Matrix
-- WHERE M_id = @param    

-- --10.
-- DECLARE @param_1 as INT
-- SET @param_1 = 1
-- DECLARE @param_2 as INT
-- SET @param_2 = 2

-- SELECT 
--     CASE 
--     WHEN MAX(M1.col_id) = MAX(M2.col_id) AND MAX(M1.row_id) = MAX(M2.row_id) THEN 'yes'
--     ELSE 'no'
--     END AS Sum
-- FROM 
-- (SELECT M_id, col_id, row_id, val 
-- FROM Matrix 
-- WHERE M_id = @param_1) AS M1, (SELECT M_id, col_id , row_id , val 
-- FROM Matrix 
-- WHERE M_id = @param_2) AS M2

-- --11.
-- DECLARE @param_1 as INT
-- SET @param_1 = 1
-- DECLARE @param_2 as INT
-- SET @param_2 = 3

-- BEGIN TRY  
    
-- 	DECLARE @flag BIT
-- 	SET @flag = (SELECT		
-- 	CASE
-- 	WHEN MAX(M1.row_id) = MAX(M2.row_id) AND MAX(M1.col_id) = MAX(M2.col_id) THEN 1
-- 	ELSE 0
-- 	END
-- 	FROM 
-- 	(SELECT *
-- 	FROM Matrix
-- 	WHERE M_id = @param_1) AS M1,
-- 	(SELECT *
-- 	FROM Matrix
-- 	WHERE M_id = @param_2) AS M2);

-- 	IF @flag = 0
-- 		THROW 99000, 'Матрицы невозможно сложить', 1;

-- 	SELECT M1.row_id AS row_id, M1.col_id AS col_id, (M1.val + M2.val) AS val
-- 	FROM 
-- 	(SELECT *
-- 	FROM Matrix
-- 	WHERE M_id = @param_1) AS M1,
-- 	(SELECT *
-- 	FROM Matrix
-- 	WHERE M_id = @param_2) AS M2
-- 	WHERE M1.row_id = M2.row_id AND M1.col_id = M2.col_id
-- 	ORDER BY row_id ASC, col_id ASC;

-- END TRY  
-- BEGIN CATCH 

--     SELECT
--         ERROR_MESSAGE() AS Ошибка;  

-- END CATCH; 

-- --12.
-- DECLARE @param_1 as INT
-- SET @param_1 = 1
-- DECLARE @param_2 as INT
-- SET @param_2 = 4

-- SELECT 
--     CASE 
--     WHEN MAX(M1.col_id) = MAX(M2.row_id) THEN 'yes'
--     ELSE 'no'
--     END AS Mult
-- FROM 
-- (SELECT M_id, col_id, row_id, val 
-- FROM Matrix 
-- WHERE M_id = @param_1) AS M1, (SELECT M_id, col_id , row_id , val 
-- FROM Matrix 
-- WHERE M_id = @param_2) AS M2

-- --13.
-- DECLARE @param_1 as INT
-- SET @param_1 = 1
-- DECLARE @param_2 as INT
-- SET @param_2 = 2

-- BEGIN TRY  
    
-- 	DECLARE @flag BIT
-- 	SET @flag = (
-- 	SELECT
-- 	CASE 
-- 	WHEN MAX(M1.col_id) = MAX(M2.row_id) THEN 1
-- 	ELSE 0
-- 	END
-- 	FROM (SELECT *
-- 	FROM Matrix
-- 	WHERE M_id = @param_1) AS M1,
-- 	(SELECT *
-- 	FROM Matrix
-- 	WHERE M_id = @param_2) AS M2);

-- 	IF @flag = 0
-- 		THROW 99000, 'Матрицы невозможно перемножить', 1;

-- 	SELECT M1.row_id AS row_id, M2.col_id AS col_id, SUM(M1.val * M2.val) AS val
-- 	FROM 
-- 	(SELECT *
-- 	FROM Matrix
-- 	WHERE M_id = @param_1) AS M1,
-- 	(SELECT *
-- 	FROM Matrix
-- 	WHERE M_id = @param_2) AS M2
-- 	WHERE M1.col_id = M2.row_id
-- 	GROUP BY M1.row_id, M2.col_id
-- 	ORDER BY row_id ASC, col_id ASC;

-- END TRY  
-- BEGIN CATCH 

--     SELECT
--         ERROR_MESSAGE() AS Ошибка;  

-- END CATCH; 

-- --14.
-- DECLARE @param as INT
-- SET @param = 4

-- DECLARE @A TABLE
-- (
--     col_id INT NOT NULL, 
--     row_id INT NOT NULL,
--     val float, 
--     PRIMARY KEY(row_id, col_id)
-- )

-- INSERT INTO @A VALUES 
-- (1, 1, 1),
-- (1, 2, 0),
-- (2, 1, 0),
-- (2, 2, -1)

-- BEGIN TRY  
    
-- 	DECLARE @flag BIT
-- 	SET @flag = (
-- 	SELECT
-- 	CASE 
-- 	WHEN MAX(M1.row_id) = MAX(M2.row_id) THEN 1
-- 	ELSE 0
-- 	END
-- 	FROM (SELECT *
-- 	FROM Matrix
--     WHERE M_id = @param) AS M1,
-- 	(SELECT *
-- 	FROM @A) AS M2);

-- 	IF @flag = 0
-- 		THROW 99000, 'Размеры матриц A и B не удовлетворяют необходимым 
-- 		условиям', 1;

-- 	SELECT M1.row_id AS row_id, M2.col_id AS col_id, SUM(M1.val * M2.val) AS val
-- 	FROM
-- 	(SELECT col_id AS row_id, row_id AS col_id, val
-- 	FROM Matrix
--     WHERE M_id = @param) AS M1,
-- 	(SELECT *
-- 	FROM @A) AS M2
-- 	WHERE M1.col_id = M2.row_id
-- 	GROUP BY M1.row_id, M2.col_id
-- 	ORDER BY row_id ASC, col_id ASC;

-- END TRY  
-- BEGIN CATCH 

--     SELECT
--         ERROR_MESSAGE() AS Ошибка;  

-- END CATCH; 

-- --15.
-- DECLARE @param_1 as INT
-- SET @param_1 = 1
-- DECLARE @param_2 as INT
-- SET @param_2 = 3

-- BEGIN TRY

-- DECLARE @flag BIT
-- SET @flag = (SELECT
--     CASE 
--     WHEN MAX(T1.col_id) = MAX(T2.col_id) AND MAX(T1.row_id) = MAX(T2.row_id) THEN 1
--     ELSE 0
--     END
--     FROM 
--     (SELECT *
-- 	FROM Matrix
-- 	WHERE M_id = @param_1) AS T1,
-- 	(SELECT *
-- 	FROM Matrix
-- 	WHERE M_id = @param_2) AS T2);

-- IF @flag = 0 
-- THROW 99000,'Матрицы невозможно вычесть друг из друга', 1;

-- SELECT T1.col_id, T1.row_id, T1.val - T2.val as val 
-- FROM Matrix as T1, Matrix as T2
-- WHERE T1.M_id = @param_1 AND T2.M_id = @param_2 AND T1.col_id = T2.col_id AND T1.row_id = T2.row_id;

-- END TRY

-- BEGIN CATCH

-- SELECT
--         ERROR_MESSAGE() AS Ошибка;  

-- END CATCH;

