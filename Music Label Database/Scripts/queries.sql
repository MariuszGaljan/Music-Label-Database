/*============================================= Easy Queries =========================================================*/

/* 6.1 show studios where the price per hour is smaller than 100$ */
SELECT Studio_name
    FROM Studio
    WHERE Price_per_hour < 100

/* 6.2 show Led Zeppelin tours */
SELECT ID_TOUR
    FROM TOUR
    WHERE ID_BAND = 1

/* 6.3 show tracks longer than 5 minutes */
SELECT Title
    FROM Track
    WHERE Duration >= '00:05'



/*============================================= Medium Queries ======================================================*/


/* 6.4 show musician names and the bands the play in. */
SELECT ID_MUSICIAN, Band.Band_name, Name
    FROM Musician
    JOIN Band ON  Band.ID_BAND = Musician.ID_BAND

/* 6.5 show average track duration from each album with album name and its ID */
SELECT Album.ID_ALBUM, Album.Album_name, convert(time, DATEADD(ms, AVG(DATEDIFF(ms, '00:00:00.000', Duration)), '00:00:00.000')) as Duration
    FROM Track
    JOIN Album ON Album.ID_ALBUM = Track.ID_ALBUM
    GROUP BY Album.ID_ALBUM, Album_name

/* 6.6 show the number of concerts a tour consists of */
SELECT Tour.ID_TOUR, count(Concert.ID_CONCERT) as Number_of_concerts
    FROM Tour
    JOIN Concert ON Tour.ID_TOUR = Concert.ID_TOUR
    GROUP BY Tour.ID_TOUR
    ORDER BY Tour.ID_TOUR ASC 



/*============================================== Hard qeuries ========================================================*/



/* 6.7 show names of bands with more than 5 tracks together with the numbers of those tracks */
SELECT Band.ID_BAND, Band_name, count(Track.ID_BAND) AS number_of_tracks
    FROM Band
    JOIN Track ON Track.ID_BAND = Band.ID_BAND
    WHERE Band.ID_BAND IN (
        SELECT ID_BAND
            FROM Track
            GROUP BY ID_BAND
            HAVING  count(*) > 5
    )
    GROUP BY Band.ID_BAND, Band_name;


/* 6.8 show producer IDs, their names and tracks they worked on  */
SELECT Producer.ID_PRODUCER, Name, Track.Title
    FROM Producer, (
        SELECT ID_PRODUCER, Track.Title
            FROM Album
            JOIN Track ON Album.ID_ALBUM = Track.ID_ALBUM
    ) AS Track
    WHERE Producer.ID_PRODUCER = Track.ID_PRODUCER
    ORDER BY Producer.ID_PRODUCER ASC



/* 6.9 show bands and the number of their concerts, sorted by the concerts_number descending */
SELECT Band.Band_name, sum(Concerts.Number_of_concerts) AS Concerts
    FROM Band, (
        SELECT Tour.ID_BAND, Tour.ID_TOUR, count(Concert.ID_CONCERT) as Number_of_concerts
            FROM Tour
            JOIN Concert ON Tour.ID_TOUR = Concert.ID_TOUR
            GROUP BY Tour.ID_TOUR, Tour.ID_BAND
            ORDER BY Tour.ID_TOUR ASC 
    ) AS Concerts
    WHERE Band.ID_BAND = Concerts.ID_BAND
    GROUP BY Band.Band_name
    ORDER BY Concerts DESC 



