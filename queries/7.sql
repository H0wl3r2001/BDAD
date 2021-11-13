.mode column
.headers on
.nullvalue NULL

SELECT EventName, Date, Time, MusicGenre, max(GenreCount) as MaxGenre 
FROM (
    SELECT Event.name AS EventName,  MusicGenre.name AS MusicGenre, Performance.pdate AS Date, 
            strftime('%H', Performance.ptime) AS Time, count(MusicGenre.name) AS GenreCount
    FROM MusicGenre 
    JOIN ArtistMusicGenre ON MusicGenre.id = ArtistMusicGenre.musicGenreID
    JOIN Artist ON Artist.id = ArtistMusicGenre.artistID
    JOIN ArtistPerformance ON Artist.id = ArtistPerformance.artistID
    JOIN Performance ON Performance.id = ArtistPerformance.performanceID
    JOIN Event ON Performance.eventID = Event.id
    GROUP BY EventName, MusicGenre, Date, Time)
GROUP BY EventName, Date, Time
ORDER BY EventName, Date, Time, MusicGenre ASC;