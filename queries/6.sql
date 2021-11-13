.mode column
.headers on
.nullvalue NULL

SELECT EventName, MusicGenre, max(GenreCount) as MaxGenre
FROM (
    SELECT Event.id as EventID, Event.name as EventName, MusicGenre.name as MusicGenre, 
            count(MusicGenre.name) as GenreCount
    FROM MusicGenre 
    JOIN ArtistMusicGenre ON MusicGenre.id = ArtistMusicGenre.musicGenreID
    JOIN Artist ON Artist.id = ArtistMusicGenre.artistID
    JOIN ArtistPerformance ON Artist.id = ArtistPerformance.artistID
    JOIN Performance ON Performance.id = ArtistPerformance.performanceID
    JOIN Event ON Performance.eventID = Event.id
    GROUP BY MusicGenre, EventName
    ORDER BY EventName, GenreCount DESC)
GROUP BY EventName;