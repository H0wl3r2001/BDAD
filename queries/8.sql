.mode column
.headers on
.nullvalue NULL

DROP VIEW IF EXISTS ClientEvent;

CREATE VIEW ClientEvent
AS 
SELECT Client.name AS ClientName, Event.name AS EventName
FROM Ticket, Client, Event
EXCEPT
SELECT Client.name AS ClientName, Event.name AS EventName
FROM Ticket
JOIN Client ON Client.id = Ticket.clientID
JOIN Event ON Event.id = Ticket.eventID;


SELECT Client.name AS ClientName
FROM Client
WHERE ClientName NOT IN(
    SELECT ClientName
    FROM ClientEvent
);