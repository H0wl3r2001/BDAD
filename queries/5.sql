.mode column
.headers on
.nullvalue NULL

DROP VIEW IF EXISTS EventPerformance;

CREATE VIEW EventPerformance
AS 
SELECT Event.name AS EventName, Artist.artisticName AS ArtisticName, Artist.isGroup AS isGroup
FROM Event
JOIN Performance ON Event.id = Performance.eventID
JOIN ArtistPerformance ON Performance.id = ArtistPerformance.performanceID
JOIN Artist ON ArtistPerformance.artistID = Artist.id;


SELECT EventName, isGroup, sum(NumArtists) AS NumTotalArtists
FROM (
    SELECT EventName, isGroup, count(ArtisticName) AS NumArtists
    FROM EventPerformance
    GROUP BY EventName, isGroup
)
GROUP BY EventName, isGroup;
