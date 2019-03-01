--Delete Statements. To maintain the data integrity of the database, we are only allowing users to delete books. Deleting a book will also remove any author, genre, and publisher affiliations from their respective tables (M-M deletion)

DELETE FROM Book WHERE Title = ':titleInput';

DELETE FROM Book_Authors WHERE BID = (SELECT ID FROM Book where Title = ':titleInput');

DELETE FROM Book_Genre WHERE BID = (SELECT ID FROM Book where Title = ':titleInput');

DELELTE FROM Book_Publisher WHERE BID = (SELECT ID FROM Book where Title = ':titleInput');


--Insert Queries. Takes data from text input and inserts the values into the appropriate tables. THe author, genre, and publisher input queries ensure that there is not duplicate data. Also updates the relationship tables. 


INSERT INTO Book(Title) VALUES (':titleInput');

INSERT INTO Author(fname, lname) 
VALUES (':fnameInput', ':lnameInput');


INSERT INTO Genres(Name) VALUES (':genNameInput');


INSERT INTO Publisher(Name) VALUES (':pubNameInput');


INSERT INTO Book_Authors (BID,AID) VALUES (( select ID from Book where Title = ':titleInput'),(SELECT ID from Author where fname = ':fnameInput' AND lname = ':lnameInput'));


INSERT INTO Book_Genre (BID,GID) VALUES (( select ID from Book where Title = ':titleInput'),(SELECT ID from Genres where Name = ':genNameInput'));

INSERT INTO Book_Publisher (BID,AID) VALUES (( select ID from Book where Title = ':titleInput'),(SELECT ID from Publisher where Name = ':pubNameInput'))

--Search based on Author Name


SELECT DISTINCT Title, lname, fname, pub_Name, gen_Name
FROM Book b 
JOIN Book_Authors ba ON b.ID = ba.BID
JOIN Author a ON ba.AID = a.ID
JOIN Book_Publisher bp ON b.ID = bp.BID
JOIN Publisher p ON bp.PID = p.ID
JOIN Book_Genre bg ON b.ID = bg.BID
JOIN Genres g on bg.GID = g.ID

WHERE fname = ':FnameInput' AND lname = ':LnameInput'
ORDER BY lname;

--Search based on Book Title. Returns all info associated with the desired book title.
SELECT DISTINCT Title, lname, fname, pub_Name, gen_Name
FROM Book b 
JOIN Book_Authors ba ON b.ID = ba.BID
JOIN Author a ON ba.AID = a.ID
JOIN Book_Publisher bp ON b.ID = bp.BID
JOIN Publisher p ON bp.PID = p.ID
JOIN Book_Genre bg ON b.ID = bg.BID
JOIN Genres g on bg.GID = g.ID

WHERE Title = ':titleInput'	
ORDER BY Title, lname;

--Search based on Publisher. Returns Book information associated with the desired PUblisher name sorted by author last name.
SELECT DISTINCT Title, lname, fname, pub_Name, gen_Name
FROM Book b 
JOIN Book_Authors ba ON b.ID = ba.BID
JOIN Author a ON ba.AID = a.ID
JOIN Book_Publisher bp ON b.ID = bp.BID
JOIN Publisher p ON bp.PID = p.ID
JOIN Book_Genre bg ON b.ID = bg.BID
JOIN Genres g on bg.GID = g.ID

WHERE pub_Name = ':pubNameInput'
ORDER BY Title

--Search Based on Genre. Returns all book information associated with the desired Genre sorted first By Genre Name then by author last name.
SELECT DISTINCT Title, lname, fname, pub_Name, gen_Name
FROM Book b 
JOIN Book_Authors ba ON b.ID = ba.BID
JOIN Author a ON ba.AID = a.ID
JOIN Book_Publisher bp ON b.ID = bp.BID
JOIN Publisher p ON bp.PID = p.ID
JOIN Book_Genre bg ON b.ID = bg.BID
JOIN Genres g on bg.GID = g.ID

WHERE gen_Name = ':genNameInput'	
ORDER BY  Title,lname;

--Update existing entry. Selects the ID based on the title the user wants to update. THe update function would also call INSERT queries for authors, genres, and Publishers which would insert the entries if they did not already exist. Any blind variable with New in the name indicates the new information the user inputs. Any blind variable with Update in the name indicates which entry the user wishes to update. 

UPDATE Book
SET Title = ':titleNewInput'
WHERE ID = ( SELECT ID WHERE Title = ':titleUpdateInput');

UPDATE Book_Authors
SET AID = (SELECT ID FROM Author WHERE FName = ':FnameNewInput' AND Lname = ':LnameNewINput')
WHERE BID = ( SELECT ID FROM Book WHERE Title = ':titleUpdateInput');

UPDATE Book_Genre
SET GID = (SELECT ID FROM Genres WHERE Name = ':genNameNewInput')
WHERE BID = ( SELECT ID FROM Book WHERE Title = ':titleUpdateInput');

UPDATE Book_Publisher
SET PID = (SELECT ID FROM Publisher WHERE Name = ':pubNameNewInput')
WHERE BID = ( SELECT ID FROM Book WHERE Title = ':titleUpdateInput');

UPDATE Author
SET Fname = ':FnameNewInput', Lname = ':LnameNewInput'
WHERE ID = (SELECT ID WHERE Fname = ':FnameUpdateInput' AND Lname = 'LnameUpdateInput');

UPDATE Genres
SET Name= ':genNameNewInput'
WHERE ID = (SELECT ID WHERE Name= ':genNameUpdateInput');

UPDATE Publisher
SET name = ':pubNameNewInput'
WHERE ID = (SELECT ID WHERE Name = ':pubNameUpdateInput');



