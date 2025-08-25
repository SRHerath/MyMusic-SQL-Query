-- View: Top Artists by Sales
CREATE VIEW vw_TopArtistsBySales AS
SELECT 
    ar.Name AS ArtistName,
    SUM(il.UnitPrice * il.Quantity) AS TotalSales
FROM InvoiceLine_IT20226664 il
JOIN Track_IT20226664 t ON il.TrackId = t.TrackId
JOIN Album_IT20226664 al ON t.AlbumId = al.AlbumId
JOIN Artist_IT20226664 ar ON al.ArtistId = ar.ArtistId
GROUP BY ar.Name;

-- View: Most Popular Genres
CREATE VIEW vw_GenrePopularity AS
SELECT 
    g.Name AS GenreName,
    SUM(il.Quantity) AS TotalTracksSold
FROM InvoiceLine_IT20226664 il
JOIN Track_IT20226664 t ON il.TrackId = t.TrackId
JOIN Genre_IT20226664 g ON t.GenreId = g.GenreId
GROUP BY g.Name;

-- View: Top Customers by Spending
CREATE VIEW vw_TopCustomers AS
SELECT 
    c.FirstName + ' ' + c.LastName AS CustomerName,
    SUM(i.Total) AS TotalSpent
FROM Customer_IT20226664 c
JOIN Invoice_IT20226664 i ON c.CustomerId = i.CustomerId
GROUP BY c.FirstName, c.LastName;

-- View: Best-Selling Tracks
CREATE VIEW vw_BestSellingTracks AS
SELECT 
    t.Name AS TrackName,
    ar.Name AS ArtistName,
    SUM(il.UnitPrice * il.Quantity) AS Revenue
FROM InvoiceLine_IT20226664 il
JOIN Track_IT20226664 t ON il.TrackId = t.TrackId
JOIN Album_IT20226664 al ON t.AlbumId = al.AlbumId
JOIN Artist_IT20226664 ar ON al.ArtistId = ar.ArtistId
GROUP BY t.Name, ar.Name;






