/*===================================================== Cursors ==================================================*/


/* 10.1 Procedure printing band IDs with their names */
CREATE PROCEDURE "dba"."showBands"()
BEGIN
	DECLARE i INTEGER;
    DECLARE bandId INTEGER;
    DECLARE bandName VARCHAR(30);
    DECLARE cursorVar DYNAMIC SCROLL CURSOR FOR 
        SELECT ID_BAND, Band_name FROM Band;

    SET i = 0;
    OPEN cursorVar;
    WHILE i < (SELECT count(ID_BAND) FROM Band)
    LOOP
        FETCH NEXT cursorVar INTO bandId, bandName;
        MESSAGE 'ID: ', + bandId, + ' Band name: ', + bandName TO CLIENT;
        
        SET i = i + 1;
    END LOOP;
    CLOSE cursorVar;
    DEALLOCATE cursorVar;
END


/* 10.2 Function returning number of planned concerts */
CREATE FUNCTION "DBA"."numberOfPlannedConcerts"( )
RETURNS INTEGER
DETERMINISTIC
BEGIN
	DECLARE numberOfConcerts INTEGER;
	DECLARE i INTEGER;
    DECLARE tourId INTEGER;
    DECLARE concertsInTour INTEGER;
    DECLARE cursorVar DYNAMIC SCROLL CURSOR FOR 
        /* selects number of concerts for each tour*/
        SELECT Tour.ID_TOUR, count(Concert.ID_CONCERT) as number_of_concerts
            FROM Tour
            JOIN Concert ON Tour.ID_TOUR = Concert.ID_TOUR
            GROUP BY Tour.ID_TOUR
            ORDER BY Tour.ID_TOUR ASC;
    SET numberOfConcerts = 0;

    SET i = 0;
    OPEN cursorVar;
    WHILE i < (SELECT count(Concerts.ID_TOUR) FROM (
                    /* counts number of tours in the Concerts table */
                    SELECT Tour.ID_TOUR, count(Concert.ID_CONCERT) as number_of_concerts
                        FROM Tour
                        JOIN Concert ON Tour.ID_TOUR = Concert.ID_TOUR
                        GROUP BY Tour.ID_TOUR ) AS Concerts )
    LOOP
        FETCH NEXT cursorVar INTO tourId, concertsInTour;
        SET numberOfConcerts = numberOfConcerts + concertsInTour;
        SET i = i + 1;
    END LOOP;
    CLOSE cursorVar;
    DEALLOCATE cursorVar;

	RETURN "numberOfConcerts";
END



/* Procedure printing producers with the tracks they worked on */
CREATE PROCEDURE "dba"."showProducersTracks"( )
BEGIN
	DECLARE i INTEGER;
    DECLARE producerId INTEGER;
    DECLARE actProducerId INTEGER;
    DECLARE producerName VARCHAR(30);
    DECLARE trackId INTEGER;
    DECLARE trackTitle VARCHAR(30);
    DECLARE cursorVar DYNAMIC SCROLL CURSOR FOR 
        /* selects producer's ID, Name and the tracks he/she's been working on */
        SELECT Producer.ID_PRODUCER, Name, Track.Title
            FROM Producer, (
                SELECT ID_PRODUCER, Track.Title
                FROM Album
                JOIN Track ON Album.ID_ALBUM = Track.ID_ALBUM
            ) AS Track
            WHERE Producer.ID_PRODUCER = Track.ID_PRODUCER
            ORDER BY Producer.ID_PRODUCER ASC;

    SET actProducerId = 0;

    SET i = 0;
    OPEN cursorVar;
    WHILE i < (SELECT count(ProducentTrack.Title) FROM (
        SELECT Producer.ID_PRODUCER, Name, Track.Title
            FROM Producer, (
                SELECT ID_PRODUCER, Track.Title
                FROM Album
                JOIN Track ON Album.ID_ALBUM = Track.ID_ALBUM
            ) AS Track
            WHERE Producer.ID_PRODUCER = Track.ID_PRODUCER
            ORDER BY Producer.ID_PRODUCER ASC) AS ProducentTrack)
    LOOP
        FETCH NEXT cursorVar INTO producerId, producerName, trackTitle;

        /*If we fetched the next producer, we print his name before his tracks */
        IF actProducerId != producerId THEN 
            BEGIN 
                MESSAGE 'Producent: ', + producerName TO CLIENT;
                SET actProducerId = producerId;
            END
        ENDIF;

        MESSAGE trackTitle TO CLIENT;
        
        SET i = i + 1;
    END LOOP;
    CLOSE cursorVar;
    DEALLOCATE cursorVar;
END