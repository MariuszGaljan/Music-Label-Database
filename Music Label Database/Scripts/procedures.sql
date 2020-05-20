/* ================================================ Procedures ===================================================== */

/* Procedure adding to the database a band that is not present in the database */
CREATE PROCEDURE "dba"."addBand"
(IN bandId INTEGER , IN bandName VARCHAR(30) )
BEGIN
    IF NOT EXISTS (SELECT Band_name FROM Band WHERE Band_name = bandName) THEN
        BEGIN
            INSERT INTO Band VALUES
                (bandId, bandName);
        END 
    ELSE 
        BEGIN 
            RAISERROR 99999 'Band already exists'
        END 
    ENDIF;
END


/* 8.2	Procedure deleting a record of ID_CONCERT field equal to concertId from Concert table */
CREATE PROCEDURE "dba"."deleteConcert"( IN concertId INTEGER )
BEGIN
	IF NOT EXISTS (SELECT ID_CONCERT FROM Concert WHERE ID_CONCERT = concertId) THEN 
        BEGIN 
            RAISERROR 99999 'No record found'
        END
    ELSE 
        BEGIN 
            DELETE FROM Concert WHERE DBA.Concert.ID_CONCERT = concertId
        END
    ENDIF 
END


/* 8.3	Procedure deleting a record of ID_TOUR field equal to tourId from Tour table
        and concert from that tour from the Concert table */
CREATE PROCEDURE "dba"."deleteTour"( IN tourId INTEGER )
BEGIN 
    IF NOT EXISTS (SELECT ID_TOUR FROM Tour WHERE ID_TOUR = tourId) THEN 
        BEGIN 
            RAISERROR 99999 'No record found'
        END
    ELSE 
        BEGIN 
            DELETE FROM Concert WHERE DBA.Concert.ID_TOUR = tourId;
            DELETE FROM Tour WHERE DBA.Tour.ID_TOUR = tourId;
        END
    ENDIF 
END