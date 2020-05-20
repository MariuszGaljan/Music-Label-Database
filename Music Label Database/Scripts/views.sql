/*===================================================== Views ===================================================*/

/* 7.1	View of studios with a price per hour smaller than 100$ */
CREATE VIEW Cheap_studios AS
    SELECT Studio_name 
        FROM Studio
        WHERE Price_per_hour < 100


/* 7.2	View of bands and the number of concerts they are playing, sorted by the number of concerts descending */
CREATE VIEW Band_concerts AS
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


/* 7.3	View of number of concerts per tour */
CREATE VIEW Concert_of_tour AS
    SELECT Tour.ID_TOUR, count(Concert.ID_CONCERT) as Number_of_concerts
    FROM Tour
    JOIN Concert ON Tour.ID_TOUR = Concert.ID_TOUR
    GROUP BY Tour.ID_TOUR
    ORDER BY Tour.ID_TOUR ASC 
