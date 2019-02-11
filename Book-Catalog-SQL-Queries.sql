--Delete Statements. To maintain the data integrity of the database, we are only allowing users to delete books. Deleting a book will also remove any author, genre, and publisher affiliations from their respective tables (M-M deletion)

DELETE FROM Book WHERE Title = :titleInput
DELETE FROM Book_Authors WHERE BID = (SELECT ID FROM Book where Title = :titleInput)
DELETE FROM Book_Genre WHERE BID = (SELECT ID FROM Book where Title = :titleInput)
DELELTE FROM Book_Publisher WHERE BID = (SELECT ID FROM Book where Title = :titleInput)


--Insert Queries. Takes data from text input and inserts the values into the appropriate tables. THe author, genre, and publisher input queries ensure that there is not duplicate data. Also updates the relationship tables. 


INSERT INTO Book(Title) VALUES (:titleInput)

INSERT INTO Author(fname, lname) VALUES (:fnameInput, :lnameInput)
WHERE NOT EXISTS (SELECT ID from Author WHERE fname = :fnameInput AND lname = :lnameInput)
LIMIT 1
INSERT INTO Genres(Name) VALUES (:genNameInput)
WHERE NOT EXISTS (SELECT ID from Genres WHERE Name = :genNameInput)
LIMIT 1

INSERT INTO Publisher(Name) VALUES (:pubNameInput)
WHERE NOT EXISTS (SELECT ID from Publisher WHERE Name = :pubNameInput)
LIMIT 1


INSERT INTO Book_Authors (BID,AID) VALUES (( select ID from Book where Title = :titleInput),(SELECT ID from Author where fname = :fnameInput AND lname = :lnameInput))


INSERT INTO Book_Genre (BID,GID) VALUES (( select ID from Book where Title = :titleInput),(SELECT ID from Genres where Name = :genNameInput))

INSERT INTO Book_Publisher (BID,AID) VALUES (( select ID from Book where Title = :titleInput),(SELECT ID from Publisher where Name = :pubNameInput))

--Search based on Author Name


SELECT Book.Title, Author.lname, Author.fname, Publisher.Name, Genres.Name
FROM Book b 
JOIN Book_Author ba ON b.ID = ba.BID
JOIN Author a ON ba.AID = a.ID
JOIN Book_Publisher bp ON b.ID = bp.BID
JOIN Publisher p ON bp.PID = p.ID
JOIN Book_Genre bg ON b.ID = bg.BID
JOIN Genre g on bg.GID = g.ID

WHERE Author.fname = :FnameInput AND Author.lname = :LnameInput
ORDER BY Author.lname

--Search based on Book Title. Returns all info associated with the desired book title.
SELECT Book.Title, Author.lname, Author.fname, Publisher.Name, Genres.Name
FROM Book b 
JOIN Book_Author ba ON b.ID = ba.BID
JOIN Author a ON ba.AID = a.ID
JOIN Book_Publisher bp ON b.ID = bp.BID
JOIN Publisher p ON bp.PID = p.ID
JOIN Book_Genre bg ON b.ID = bg.BID
JOIN Genre g on bg.GID = g.ID

WHERE Book.Title = :titleInput	
ORDER BY Author.Lname

--Search based on Publisher. Returns Book information associated with the desired PUblisher name sorted by author last name.
SELECT Book.Title, Author.lname, Author.fname, Publisher.Name, Genres.Name
FROM Book b 
JOIN Book_Author ba ON b.ID = ba.BID
JOIN Author a ON ba.AID = a.ID
JOIN Book_Publisher bp ON b.ID = bp.BID
JOIN Publisher p ON bp.PID = p.ID
JOIN Book_Genre bg ON b.ID = bg.BID
JOIN Genre g on bg.GID = g.ID

WHERE Publisher.Name = :pubNameInput
ORDER BY Publisher.Name

--Search Based on Genre. Returns all book information associated with the desired Genre sorted first By Genre Name then by author last name.

SELECT Book.Title, Author.lname, Author.fname, Publisher.Name, Genres.Name
FROM Book b 
JOIN Book_Author ba ON b.ID = ba.BID
JOIN Author a ON ba.AID = a.ID
JOIN Book_Publisher bp ON b.ID = bp.BID
JOIN Publisher p ON bp.PID = p.ID
JOIN Book_Genre bg ON b.ID = bg.BID
JOIN Genre g on bg.GID = g.ID

WHERE Genre.Name = :genNameInput	
ORDER BY Genre.Name, Author.Lname


--Update existing entry. Selects the ID based on the title the user wants to update. THe update function would also call INSERT queries for authors, genres, and Publishers which would insert the entries if they did not already exist. Any blind variable with New in the name indicates the new information the user inputs. Any blind variable with Update in the name indicates which entry the user wishes to update. 
UPDATE BOOK
SET Title = :titleNewInput
WHERE ID = ( SELECT ID FROM Book WHERE Title = :titleUpdateInput)

UPDATE Book_Authors
SET AID = (SELECT ID FROM Author WHERE FName = :FnameNewInput AND Lname = :LnameNewINput)
WHERE BID = ( SELECT ID FROM Book WHERE Title = :titleUpdateInput)

UPDATE Book_Genre
SET GID = (SELECT ID FROM Genres WHERE Name = :genNameNewInput)
WHERE BID = ( SELECT ID FROM Book WHERE Title = :titleUpdateInput)

UPDATE Book_Publisher
SET PID = (SELECT ID FROM Publisher WHERE Name = :pubNameNewInput)
WHERE BID = ( SELECT ID FROM Book WHERE Title = :titleUpdateInput)

UPDATE Author
SET Fname = :FnameNewInput, Lname = :LnameNewINput
WHERE ID = (SELECT ID FROM Author WHERE Fname = :FnameUpdateInput AND Lname = LnameUpdateInput)

UPDATE Genres
SET Name= :genNameNewInput
WHERE ID = (SELECT ID FROM Genres WHERE Name= :genNameUpdateInput)

UPDATE Publisher
SET name = :pubNameNewInput
WHERE ID = (SELECT ID FROM Publisher WHERE Name = :pubNameUpdateInput)



