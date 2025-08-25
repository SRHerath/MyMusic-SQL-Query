-- Procedure: Get Top N Artists by Sales
CREATE PROCEDURE sp_GetTopArtistsBySales 
    @TopN INT
AS
BEGIN
    SELECT TOP (@TopN)
        ar.Name AS ArtistName,
        SUM(il.UnitPrice * il.Quantity) AS TotalSales
    FROM InvoiceLine_IT20226664 il
    JOIN Track_IT20226664 t ON il.TrackId = t.TrackId
    JOIN Album_IT20226664 al ON t.AlbumId = al.AlbumId
    JOIN Artist_IT20226664 ar ON al.ArtistId = ar.ArtistId
    GROUP BY ar.Name
    ORDER BY TotalSales DESC;
END;

-- Procedure: Get Customer Spending by Country
CREATE PROCEDURE sp_GetCustomerSpendingByCountry 
AS
BEGIN
    SELECT 
        c.Country,
        SUM(i.Total) AS TotalSpending
    FROM Customer_IT20226664 c
    JOIN Invoice_IT20226664 i ON c.CustomerId = i.CustomerId
    GROUP BY c.Country
    ORDER BY TotalSpending DESC;
END;

-- Procedure: Get Top Selling Tracks by Genre
CREATE PROCEDURE sp_GetTopTracksByGenre 
    @GenreName NVARCHAR(100), 
    @TopN INT
AS
BEGIN
    SELECT TOP (@TopN)
        t.Name AS TrackName,
        ar.Name AS ArtistName,
        SUM(il.UnitPrice * il.Quantity) AS Revenue
    FROM InvoiceLine_IT20226664 il
    JOIN Track_IT20226664 t ON il.TrackId = t.TrackId
    JOIN Album_IT20226664 al ON t.AlbumId = al.AlbumId
    JOIN Artist_IT20226664 ar ON al.ArtistId = ar.ArtistId
    JOIN Genre_IT20226664 g ON t.GenreId = g.GenreId
    WHERE g.Name = @GenreName
    GROUP BY t.Name, ar.Name
    ORDER BY Revenue DESC;
END;

