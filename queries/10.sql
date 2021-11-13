.mode column
.headers on
.nullvalue NULL

DROP VIEW IF EXISTS TicketEvent;

CREATE VIEW TicketEvent AS
SELECT DISTINCT Event.name AS EventName, SUM(Ticket.price) AS Income, Event.id
FROM Event 
JOIN Ticket on Event.id = Ticket.eventID
GROUP BY (Event.id);


SELECT (SELECT count(*)
        FROM TicketEvent AS TicketEvent1
        WHERE TicketEvent.Income < TicketEvent1.Income AND TicketEvent.id <> TicketEvent1.id) AS Ranking, EventName, Income
FROM TicketEvent
WHERE  Ranking = 0 OR Ranking = 1 OR Ranking = 2;