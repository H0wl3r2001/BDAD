.mode column
.headers on
.nullvalue NULL

SELECT DISTINCT Client.name AS ClientName, count(*) AS NumConcerts
FROM Ticket
JOIN Client ON Client.id = Ticket.clientID
JOIN Event ON Event.id = Ticket.eventID
JOIN EventType ON EventType.id = Event.eventTypeID
WHERE EventType.typeName = 'Concerto' AND (Event.startDate LIKE '%2020' AND Event.endDate LIKE '%2020')
GROUP BY ClientName
HAVING NumConcerts = (
    SELECT count(*) AS TotalConcerts2020
    FROM EVENT
    JOIN EventType ON Event.eventTypeID = EventType.id
    WHERE EventType.typeName = 'Concerto' AND Event.startDate LIKE '%2020' AND Event.endDate LIKE '%2020'
    GROUP BY EventType.typeName
);


