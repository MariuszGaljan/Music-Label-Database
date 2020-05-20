/* 9.1 Get salary of musician with ID_MUSICIAN = musicianId */
CREATE FUNCTION "DBA"."getSalary"( IN musicianId INTEGER )
RETURNS INTEGER
DETERMINISTIC
BEGIN
	DECLARE salary INTEGER;
    DECLARE musician INTEGER;
    SET musician = musicianId;
    SET salary = (SELECT Salary FROM Musician WHERE musician = Musician.ID_MUSICIAN);
	RETURN salary;
END


/* 9.1	Get average track duration */
CREATE FUNCTION "dba"."getAverageTrackDuration"()
RETURNS TIME
DETERMINISTIC
BEGIN
	DECLARE "duration" TIME;
	SET duration = (SELECT convert(duration, DATEADD(ms, AVG(DATEDIFF(ms, '00:00:00.000', Duration)), '00:00:00.000')) as Duration FROM Track);
	RETURN "duration";
END

/* Możemy ją poźniej wykorzystać w zapytaniu, zeby wyswietlic utwory dluzsze niz sredni duration trwania utworu */
SELECT ID_UTWORU, Tytul, Duration
    FROM Track
    WHERE Duration >= sredniCzasTrwaniaUtworu()



/* 9.2 Get id of the most expensive studio thats within the budget */
CREATE FUNCTION "dba"."studioInBudget"( IN budget INTEGER )
RETURNS INTEGER
DETERMINISTIC
BEGIN
	DECLARE "studioId" INTEGER;
	SET studioId = (SELECT ID_STUDIO
                        FROM (SELECT TOP 1 ID_STUDIO, Price_per_hour AS Price
                                FROM Studio
                                WHERE Price_per_hour < 100
                                ORDER BY Price DESC) AS StudioPrice );
    RETURN "studioId";
END



