.mode column
.headers on
.nullvalue NULL

SELECT EventName, TicketType, max(NumTickets) AS MaxNum
FROM (
    SELECT Event.name AS EventName, Ticket.typeName as TicketType, count(*) as NumTickets
    FROM Ticket
    JOIN Event ON Event.id = Ticket.EventID
    GROUP BY EventName, TicketType
)
GROUP BY EventName;

