.mode column
.headers on
.nullvalue NULL

DROP VIEW IF EXISTS EventPerformanceStage;

CREATE VIEW EventPerformanceStage
AS
SELECT DISTINCT Event.name as EventName, Stage.name AS StageName, Stage.capacity AS Capacity
From Stage 
JOIN Performance ON Stage.id = Performance.stageID
JOIN Event ON Event.id = Performance.eventID
JOIN EventType ON Event.eventTypeID = EventType.id
WHERE EventType.typeName = 'Festival';


SELECT *
FROM EventPerformanceStage
WHERE NOT EXISTS(
    SELECT *
    FROM EventPerformanceStage AS EPS2
    WHERE EventPerformanceStage.capacity < EPS2.capacity AND EventPerformanceStage.EventName = EPS2.EventName
);