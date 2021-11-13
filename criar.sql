PRAGMA foreign_keys = on;


DROP TABLE IF EXISTS ArtistMusicGenre;
DROP TABLE IF EXISTS ArtistPerformance;
DROP TABLE IF EXISTS SponsorType;
DROP TABLE IF EXISTS Ticket;
DROP TABLE IF EXISTS Performance;
DROP TABLE IF EXISTS Event;
DROP TABLE IF EXISTS Stage;
DROP TABLE IF EXISTS Client;
DROP TABLE IF EXISTS Artist;
DROP TABLE IF EXISTS Sponsor;
DROP TABLE IF EXISTS EventType;
DROP TABLE IF EXISTS MusicGenre;


CREATE TABLE MusicGenre (
    id      INTEGER,
    name    TEXT    UNIQUE
                    NOT NULL,

    CONSTRAINT MusicGenrePK PRIMARY KEY(id)
);


CREATE TABLE EventType (
    id          INTEGER,
    typeName    TEXT    NOT NULL 
                        UNIQUE,

    CONSTRAINT EventTypePK PRIMARY KEY (id)
);


CREATE TABLE Sponsor (
    id      INTEGER,
    name    TEXT    NOT NULL
                    UNIQUE,

    CONSTRAINT SponsorPK PRIMARY KEY (id)
);


CREATE TABLE Artist (
    id              INTEGER,
    artisticName    TEXT    NOT NULL,
    isGroup         INTEGER CHECK (isGroup = 0 OR isGroup = 1)
                            NOT NULL,

    CONSTRAINT ArtistPK PRIMARY KEY (id)                   
);


CREATE TABLE Client (
    id              INTEGER,
    name            TEXT    NOT NULL,
    tributaryNumber INTEGER CHECK(tributaryNumber > 99999999  AND tributaryNumber < 1000000000)
                            UNIQUE 
                            NOT NULL,

    CONSTRAINT ClientPK PRIMARY KEY (id)
);


CREATE TABLE Stage (
    id          INTEGER,
    name        TEXT    NOT NULL,
    capacity    INTEGER CHECK(capacity > 0),
    address     TEXT    NOT NULL,

    CONSTRAINT StagePK PRIMARY KEY (id),
    CONSTRAINT StageUK UNIQUE(name, address)
);


CREATE TABLE Event (
    id          INTEGER,
    name        TEXT    NOT NULL,
    startDate   DATE    NOT NULL,
    endDate     DATE    NOT NULL,
    minAge      INTEGER CHECK(minAge > 0),
    eventTypeID INTEGER REFERENCES EventType(id)
                        ON UPDATE CASCADE
                        ON DELETE RESTRICT
                        NOT NULL,

    CONSTRAINT EventUK UNIQUE(name, startDate),
    CONSTRAINT EventDate CHECK (strftime('%d-%m-%Y', startDate) <= strftime('%d-%m-%Y', endDate)),
    CONSTRAINT EventPK PRIMARY KEY (id)
);


CREATE TABLE Performance (
    id      INTEGER,
    pdate    DATE    NOT NULL,
    ptime    TIME    NOT NULL,
    eventID INTEGER REFERENCES Event(id)
                    ON UPDATE CASCADE
                    ON DELETE RESTRICT
                    NOT NULL,
    stageID INTEGER REFERENCES Stage(id)
                    ON UPDATE CASCADE
                    ON DELETE RESTRICT
                    NOT NULL,

    CONSTRAINT PerformancePK PRIMARY KEY(id),
    CONSTRAINT PerformanceUK UNIQUE(pdate, ptime, stageID)
);


CREATE TABLE Ticket (
    id          INTEGER,
    typeName    TEXT    NOT NULL,
    price       REAL    CHECK(price >= 0)
                        NOT NULL,
    startDate   DATE    NOT NULL,
    endDate     DATE    NOT NULL,
    eventID     INTEGER REFERENCES Event(id)
                        ON UPDATE CASCADE
                        ON DELETE RESTRICT
                        NOT NULL,
    clientID    INTEGER REFERENCES Client(id)
                        ON UPDATE CASCADE
                        ON DELETE RESTRICT
                        NOT NULL,
    
    CONSTRAINT TicketDate CHECK (startDate <= endDate),
    CONSTRAINT TicketPK PRIMARY KEY (id)
);


CREATE TABLE SponsorType (
    typeName    TEXT    NOT NULL,
    eventID     INTEGER REFERENCES Event(id)
                        ON UPDATE CASCADE
                        ON DELETE RESTRICT
                        NOT NULL,
    sponsorID   INTEGER REFERENCES Sponsor(id)
                        ON UPDATE CASCADE
                        ON DELETE RESTRICT 
                        NOT NULL,

    CONSTRAINT SponsorTypePK PRIMARY KEY(eventID, sponsorID)
);


CREATE TABLE ArtistPerformance (
    artistID        INTEGER     REFERENCES Artist(id)
                                ON UPDATE CASCADE
                                ON DELETE RESTRICT
                                NOT NULL,
    performanceID   INTEGER     REFERENCES Performance(id)
                                ON UPDATE CASCADE
                                ON DELETE RESTRICT
                                NOT NULL,

    CONSTRAINT ArtistPerformancePK PRIMARY KEY (artistID, performanceID)
);


CREATE TABLE ArtistMusicGenre (
    artistID        INTEGER     REFERENCES Artist(id)
                                ON UPDATE CASCADE
                                ON DELETE RESTRICT
                                NOT NULL,
    musicGenreID    INTEGER     REFERENCES MusicGenre(id)
                                ON UPDATE CASCADE
                                ON DELETE RESTRICT
                                NOT NULL,

    CONSTRAINT ArtistMusicGenrePK PRIMARY KEY (artistID, musicGenreID)
);