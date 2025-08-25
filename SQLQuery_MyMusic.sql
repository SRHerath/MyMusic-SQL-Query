-- Top 10 artists ranked by total sales revenue
SELECT TOP 10 
    ar.Name AS ArtistName,
    SUM(il.UnitPrice * il.Quantity) AS TotalSales
FROM InvoiceLine_IT20226664 il
JOIN Track_IT20226664 t ON il.TrackId = t.TrackId
JOIN Album_IT20226664 al ON t.AlbumId = al.AlbumId
JOIN Artist_IT20226664 ar ON al.ArtistId = ar.ArtistId
GROUP BY ar.Name
ORDER BY TotalSales DESC;

-- Top 10 album ranked by total sales revenue
SELECT TOP 10 
    al.Title AS Album,
    SUM(il.UnitPrice * il.Quantity) AS TotalSales
FROM InvoiceLine_IT20226664 il
JOIN Track_IT20226664 t ON il.TrackId = t.TrackId
JOIN Album_IT20226664 al ON t.AlbumId = al.AlbumId
GROUP BY al.Title
ORDER BY TotalSales DESC;

-- Genres ranked by number of tracks sold
SELECT 
    g.Name AS GenreName,
    SUM(il.Quantity) AS TotalTracksSold
FROM InvoiceLine_IT20226664 il
JOIN Track_IT20226664 t ON il.TrackId = t.TrackId
JOIN Genre_IT20226664 g ON t.GenreId = g.GenreId
GROUP BY g.Name
ORDER BY TotalTracksSold DESC;

-- Customers who spent the most
SELECT TOP 10
    c.FirstName + ' ' + c.LastName AS CustomerName,
    SUM(i.Total) AS TotalSpent
FROM Customer_IT20226664 c
JOIN Invoice_IT20226664 i ON c.CustomerId = i.CustomerId
GROUP BY c.FirstName, c.LastName
ORDER BY TotalSpent DESC;

-- Top 10 countries that have most customers
SELECT TOP 10
    Country,
    Count(i.InvoiceId) AS MostCustomers
FROM Customer_IT20226664 c
JOIN Invoice_IT20226664 i ON c.CustomerId = i.CustomerId
GROUP BY c.Country
ORDER BY MostCustomers DESC;

-- Employees and their managers
SELECT 
    e.FirstName + ' ' + e.LastName AS Employee,
    m.FirstName + ' ' + m.LastName AS Manager
FROM Employee_IT20226664 e
LEFT JOIN Employee_IT20226664 m ON e.ReportsTo = m.EmployeeId
ORDER BY Manager, Employee;

-- Number of tracks per playlist
SELECT 
    p.Name AS PlaylistName,
    COUNT(pt.TrackId) AS TrackCount
FROM Playlist_IT20226664 p
JOIN PlaylistTrack_IT20226664 pt ON p.PlaylistId = pt.PlaylistId
GROUP BY p.Name
ORDER BY TrackCount DESC;

-- Number of tracks per album
SELECT 
    a.Title AS Album,
    COUNT(t.TrackId) AS TrackCount
FROM Album_IT20226664 a
JOIN Track_IT20226664 t ON a.AlbumId = t.AlbumId
GROUP BY a.Title
ORDER BY TrackCount DESC;

SELECT t.Name
From Track_IT20226664 t
WHERE t.AlbumId = 224;

-- Top 10 tracks based on revenue
SELECT TOP 10
    t.Name AS TrackName,
    ar.Name AS ArtistName,
    SUM(il.UnitPrice * il.Quantity) AS Revenue
FROM InvoiceLine_IT20226664 il
JOIN Track_IT20226664 t ON il.TrackId = t.TrackId
JOIN Album_IT20226664 al ON t.AlbumId = al.AlbumId
JOIN Artist_IT20226664 ar ON al.ArtistId = ar.ArtistId
GROUP BY t.Name, ar.Name
ORDER BY Revenue DESC;


-- Select Views
SELECT * FROM vw_TopArtistsBySales;
SELECT * FROM vw_GenrePopularity;
SELECT * FROM vw_TopCustomers;
SELECT * FROM vw_BestSellingTracks;

-- Run Stored Procedures
EXEC sp_GetTopArtistsBySales @TopN = 5;  
EXEC sp_GetCustomerSpendingByCountry;  
EXEC sp_GetTopTracksByGenre @GenreName = 'Rock', @TopN = 10;


