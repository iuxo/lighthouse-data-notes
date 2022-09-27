/* SQL Exercise
====================================================================
We will be working with database chinook.db
You can download it here: https://drive.google.com/file/d/0Bz9_0VdXvv9bWUtqM0NBYzhKZ3c/view?usp=sharing&resourcekey=0-7zGUhDz0APEfX58SA8UKog

 The Chinook Database is about an imaginary video and music store. Each track is stored using one of the digital formats and has a genre. The store has also some playlists, where a single track can be part of several playlists. Orders are recorded for customers, but are called invoices. Every customer is assigned a support employee, and Employees report to other employees.
*/


-- MAKE YOURSELF FAIMLIAR WITH THE DATABASE AND TABLES HERE





--==================================================================
/* TASK I
Which artists did not make any albums at all? Include their names in your answer.
*/

-- SELECT Name
    -- FROM artists WHERE ArtistId NOT IN 
    -- (SELECT DISTINCT ArtistId
    -- FROM albums);


/* TASK II
Which artists recorded any tracks of the Latin genre?
*/
-- SELECT Name, Composer, GenreId
    -- FROM tracks WHERE GenreId='7';


/* TASK III
Which video track has the longest length?
*/

-- SELECT name, Milliseconds
    -- FROM tracks WHERE MediaTypeId='3'
    -- LIMIT 1;

/* TASK IV
Find the names of customers who live in the same city as the top employee (The one not managed by anyone).
*/
-- SELECT FirstName, LastName, City
    -- FROM customers 
    -- WHERE City=(SELECT CITY FROM employees WHERE ReportsTo IS NULL);


/* TASK V
Find the managers of employees supporting Brazilian customers.
*/

-- SELECT SupportRepId FROM customers;
-- SELECT EmployeeId, FirstName, ReportsTo FROM employees;

-- SELECT manager.EmployeeId AS 'manager ID', manager.FirstName AS manager, 
--     emp.EmployeeId AS 'employee ID', emp.FirstName AS employee FROM customers
--     LEFT OUTER JOIN employees emp
--     ON SupportRepId = emp.EmployeeId
--     LEFT OUTER JOIN employees manager
--     ON emp.ReportsTo = manager.EmployeeId
--     WHERE customers.Country = 'Brazil';


/* TASK VI
Which playlists have no Latin tracks?
*/
-- SELECT * FROM playlists;
-- SELECT * FROM playlist_track;
-- SELECT DISTINCT playlists.PlaylistId, playlists.name
--     FROM playlists 
--     LEFT OUTER JOIN playlist_track
--     ON playlists.PlaylistId = playlist_track. PlaylistId
--     LEFT OUTER JOIN tracks
--     ON playlist_track.TrackId = tracks.TrackId
--     WHERE GenreId <> '7';