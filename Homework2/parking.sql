--BDZ_2 Denisheva Rushana 

-- --1.
-- SELECT Tariffs.TariffID, Tariff, MONTH(ValidityMonth) as MONTH, YEAR(ValidityMonth) AS YEAR,
-- COUNT(SubscrID) AS Num_of_Subscr, SUM(Cost) AS Cost
-- FROM Tariffs INNER JOIN Subscriptions ON Tariffs.TariffID = Subscriptions.TariffID
-- GROUP BY Tariffs.TariffID,Tariff, MONTH(ValidityMonth), YEAR(ValidityMonth)

-- 2.
-- SELECT ParkingData.ParkingNo, Parking.Num,
-- MONTH(DateTime_of_scan) AS Month, YEAR(DateTime_of_scan) AS Year , DATEPART(hour, DateTime_of_scan) AS hour,COUNT(RegNo)AS Num_of_Cars
-- FROM ParkingData INNER JOIN Parking ON ParkingData.ParkingNo = Parking.ParkingNo
-- GROUP BY ParkingData.ParkingNo, Parking.Num, MONTH(DateTime_of_scan), YEAR(DateTime_of_scan), DATEPART(hour, DateTime_of_scan)


-- --3.
-- SELECT T1.ParkingNo, T1.Num, COUNT(T2.ParkingNo) AS Rating
-- FROM
-- (SELECT ParkingData.ParkingNo, Parking.Num, COUNT(DISTINCT ISNULL(RegNo, 0)) AS Unique_RegNo
-- FROM Parking LEFT JOIN ParkingData ON ParkingData.ParkingNo = Parking.ParkingNo
-- GROUP BY ParkingData.ParkingNo, Parking.Num) AS T1 INNER JOIN  
-- (SELECT ParkingData.ParkingNo, Parking.Num, COUNT(DISTINCT ISNULL(RegNo, 0)) AS Unique_RegNo
-- FROM Parking LEFT JOIN ParkingData ON ParkingData.ParkingNo = Parking.ParkingNo
-- GROUP BY ParkingData.ParkingNo, Parking.Num) AS T2 ON T1.Unique_RegNo <= T2.Unique_RegNo
-- GROUP BY T1.ParkingNo, T1.Num

-- --4.
-- SELECT Clients.ClientID, ClientsPersNum , Date_of_doc, SUM(Total) AS Total_sum
-- FROM Clients LEFT JOIN Docs ON Clients.ClientID = Docs.ClientID
-- GROUP BY Clients.ClientID, ClientsPersNum, Date_of_doc
-- HAVING MONTH(Date_of_doc) = 11 AND YEAR(Date_of_doc) = 2022

-- --5.
-- SELECT Tariffs.TariffID, Tariff
-- FROM Tariffs INNER JOIN TariffData ON Tariffs.TariffID = TariffData.TariffID
-- INNER JOIN Subscriptions ON TariffData.TariffID = Subscriptions.TariffID
-- INNER JOIN Docs ON Subscriptions.DocID = Docs.DocID
-- EXCEPT
-- SELECT Tariffs.TariffID, Tariff
-- FROM Tariffs INNER JOIN TariffData ON Tariffs.TariffID = TariffData.TariffID
-- INNER JOIN Subscriptions ON TariffData.TariffID = Subscriptions.TariffID
-- INNER JOIN Docs ON Subscriptions.DocID = Docs.DocID
-- WHERE Date_of_doc > '20220901'

-- --6.
-- SELECT Clients.ClientID, CarId , ValidityMonth
-- FROM Clients INNER JOIN Docs ON Clients.ClientID = Docs.ClientID
-- INNER JOIN Subscriptions ON Docs.DocID = Subscriptions.DocID
-- WHERE ValidityMonth < '220901'
-- EXCEPT 
-- SELECT Clients.ClientID, CarId , ValidityMonth
-- FROM Clients INNER JOIN Docs ON Clients.ClientID = Docs.ClientID
-- INNER JOIN Subscriptions ON Docs.DocID = Subscriptions.DocID
-- WHERE ValidityMonth > '220901'

-- --7.
-- SELECT Areas.AreaID, Area, SUM(Num) AS Available, plans,  (CAST(plans as float) / CAST(SUM(Num) as float)) AS Load
-- FROM Areas INNER JOIN  Parking ON Areas.AreaID = Parking.AreaID,
-- (SELECT AreaID, COUNT(SubscrID) AS plans
-- FROM Docs INNER JOIN Subscriptions ON Subscriptions.DocID = Docs.DocID AND YEAR(ValidityMonth)=2022 AND MONTH(ValidityMonth)=11
-- INNER JOIN Tariffs ON Subscriptions.TariffID = Tariffs.TariffID
-- INNER JOIN TariffData ON TariffData.TariffID = Tariffs.TariffID
-- GROUP BY AreaID) AS T1 
-- WHERE T1.AreaID = Areas.AreaID
-- GROUP BY Areas.AreaID, Area, plans
-- ORDER BY Load desc

-- --8.
-- SELECT Cars.CarID,SubscrID,TariffData.TariffID, TariffData.AreaID, ParkingNo
-- -- CASE 
-- -- WHEN THEN "The car wasn't fixed"
-- -- WHEN  THEN "No subscription"
-- -- END AS Commentary
-- FROM Cars LEFT JOIN Subscriptions ON Cars.CarID = Subscriptions.CarID
-- LEFT JOIN TariffData ON Subscriptions.TariffID = TariffData.TariffID
-- LEFT JOIN Parking ON TariffData.AreaID = Parking.AreaID
-- -- FULL JOIN ParkingData ON Cars.RegNo= ParkingData.RegNo

-- --9.
-- DECLARE @param DATE 
-- SET @param = '220901'

-- SELECT RegNo, ParkingNo, CAST(@param AS date) as Date 
-- FROM ParkingData
-- WHERE CAST(DateTime_of_scan AS date) = CAST(@param AS date) 

-- --11.
-- DECLARE @param nvarchar(50)
-- SET @param = 'A090AA190'

-- IF(@param NOT IN (SELECT Regno FROM Cars WHERE Regno = @param))

-- BEGIN
-- SELECT 'No' AS Commentary
-- INSERT Cars
-- SELECT MAX(CarID) + 1, @param
-- FROM Cars
-- END

-- ELSE

-- BEGIN 
-- SELECT 'Ok' AS Commentary
-- END

-- --12.
-- DECLARE @Cl_ID int 
-- SET @Cl_ID = 2

-- DECLARE @C_ID int 
-- SET @C_ID = 2

-- DECLARE @month int 
-- SET @month = 2

-- SELECT 
-- IIF (SUM(CASE WHEN @Cl_ID = ClientID AND @C_ID = CarID AND @month = MONTH(ValidityMonth) THEN 1 ELSE 0 END) = 0, 'bought', 'has not bought') AS Answer
-- FROM Subscriptions INNER JOIN Docs ON Subscriptions.DocID = Docs.DocID

--13.
DECLARE @client int, @car int, @tariff int
DECLARE @mont date 
SET @client = 1
SET @car = 2
SET @tariff = 1
SET @mont = '221001'

INSERT Subscriptions
SELECT MAX(SubscrID) + 1, MAX(DocID) + 1, @car, @tariff, @mont, 
(SELECT CostPerMonth FROM Tariffs WHERE TariffID = @tariff)
FROM Subscriptions

INSERT Docs
SELECT MAX(Docs.DocID)+1, GETDATE(), @client,
(SELECT CostPerMonth FROM Tariffs WHERE TariffID = @tariff)
FROM Docs 

-- --14.
-- DECLARE @param int 
-- SET @param = 1

-- UPDATE Docs 
-- SET Total = (SELECT Sum(Total) FROM Docs GROUP BY DocID HAVING DocID = @param)
-- WHERE DocID = @param

-- --15.
-- DECLARE @T TABLE(ParkingNo int NOT NULL)
-- INSERT INTO @T VALUES
-- (1),(2),(6),(8) 

-- SELECT TOP 1 TariffID
-- FROM TariffData INNER JOIN Parking ON Parking.AreaID = TariffData.AreaID
-- WHERE ParkingNo in (SELECT ParkingNo 
--                     FROM @T)
-- GROUP BY TariffID
-- ORDER BY COUNT(ParkingNo) desc

