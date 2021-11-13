.mode column
.headers on
.nullvalue NULL

SELECT e1.name AS EventName1, e1.id AS EventID1, e2.name AS EventName2, e2.id AS EventID2
FROM Event e1 
JOIN Event e2 ON e1.id > e2.id AND e1.startDate BETWEEN e2.startDate AND e2.endDate;