/*11.1 Insert trigger checking, if the start date of a contract is later than the end date */
CREATE TRIGGER "checkDates" BEFORE INSERT
ORDER 1 ON "dba"."Contract"
REFERENCING NEW AS newContract
FOR EACH ROW
BEGIN
    IF 	newContract.End_date < newContract.Start_date THEN 
        RAISERROR 30001 'Start date of a contract can''t be later than the end date';
    ENDIF;
END


/* 11.2 Insert trigger updating Album.Number_of_tracks field on adding a new track */
CREATE TRIGGER "addTrack" AFTER INSERT
ORDER 1 ON "dba"."Track"
REFERENCING NEW AS newTrack
FOR EACH ROW
BEGIN
    DECLARE numberOfTracks INTEGER;
    
    SET numberOfTracks = (SELECT Number_of_tracks FROM Album WHERE ID_ALBUM = newTrack.ID_ALBUM);
    MESSAGE 'Current number of tracks: ', + numberOfTracks TO CLIENT;
    
    SET numberOfTracks = numberOfTracks + 1;
    UPDATE Album
        SET Number_of_tracks = numberOfTracks
        WHERE ID_ALBUM = newTrack.ID_ALBUM;

    MESSAGE 'Updated number of tracks: ', + numberOfTracks TO CLIENT;
END


/* 11.3 Delete trigger deleting concerts from tour when deleting a tour */
CREATE TRIGGER "deleteConcertsFromTour" BEFORE DELETE
ORDER 1 ON "dba"."Tour"
REFERENCING OLD AS tour
FOR EACH ROW
BEGIN
	DELETE FROM Concert WHERE Concert.ID_TOUR = tour.ID_TOUR;
    MESSAGE 'Deleted concerts from tour with ID ', + tour.ID_TOUR TO CLIENT;
END
