.mode column
.headers on
.nullvalue NULL

DROP VIEW IF EXISTS VPerformance;

CREATE VIEW VPerformance
AS
SELECT *
FROM ArtistPerformance
JOIN Artist ON Artist.id = ArtistPerformance.artistID
JOIN Performance ON Performance.id = ArtistPerformance.performanceID;


SELECT DISTINCT VP1.artisticName AS ArtisticName1, VP2.artisticName AS ArtisticName2
FROM VPerformance AS VP1
JOIN VPerformance AS VP2 ON VP1.artistID < VP2.artistID
WHERE VP1.pdate = VP2.pdate AND VP1.ptime = VP2.ptime;