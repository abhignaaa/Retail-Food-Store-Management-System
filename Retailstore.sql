
-- retriving the dataset

SELECT * FROM retailfoodstore.retail_food_stores;

-- Dropping empty columns

ALTER TABLE retail_food_stores DROP COLUMN `AddressLine2`, DROP COLUMN `AddressLine3`;

-- Different types of SQL queries with SELECT clause

-- GROUPBY

SELECT City, Count(*) AS CountOfStores
FROM retail_food_stores
GROUP BY City;

-- sub-query

SELECT * FROM retail_food_stores
WHERE City IN (
	SELECT City FROM retail_food_stores
    GROUP BY City HAVING COUNT(*) > 100
);

-- LIKE query

SELECT DBA_Name
FROM retail_food_stores
WHERE DBA_Name LIKE '%deli%';

-- JOIN

SELECT t1.License_Number, t1.City, t1.Square_Footage
FROM retail_food_stores t1
JOIN (
	SELECT MIN(Square_Footage) AS MinSqFt FROM retail_food_stores
) t2
ON t1.Square_Footage = t2.MinSqFt;

-- ORDER BY

SELECT License_Number, Entity_Name, DBA_Name, NYS_Municipal_Boundaries
FROM retail_food_stores
ORDER BY NYS_Municipal_Boundaries DESC;


-- BCNF Tables

CREATE TABLE County (
    County_id INT NOT NULL PRIMARY KEY,
    County varchar(20)
);


CREATE TABLE Operation(
	Operation_id INT NOT NULL,
    Operation_Type Char(5),
    PRIMARY KEY(Operation_id));
    
    
CREATE TABLE Establishment(
	Estab_id INT NOT NULL,
    Entity_Name VARCHAR(25),
    DBA_Name VARCHAR(45),
    Street_Number INT,
    Street_Name VARCHAR(18),
    AddressLine2 VARCHAR(28),
    AddressLine3 VARCHAR(32),
    City VARCHAR(15),
    State VARCHAR(9),
    Zip_Code INT NOT NULL,
    Square_Footage INT,
    Georeference VARCHAR(46),
    PRIMARY KEY(Estab_id));
    
-- new tables in bcnf

CREATE TABLE Establishment(
    Estab_id INT NOT NULL,
    Entity_Name VARCHAR(25),
    DBA_Name VARCHAR(45),
    Street_Number INT,
    Street_Name VARCHAR(18),
    AddressLine2 VARCHAR(28),
    AddressLine3 VARCHAR(32),
    City VARCHAR(15),
    State VARCHAR(9),
    Square_Footage INT,
    Georeference VARCHAR(46),
    PRIMARY KEY(Estab_id)
);


CREATE TABLE Establishment_Zip(
    Estab_id INT NOT NULL,
    Zip_Code INT NOT NULL,
    PRIMARY KEY(Estab_id, Zip_Code),
    FOREIGN KEY(Estab_id) REFERENCES Establishment(Estab_id)
);

    CREATE TABLE License(
    License_Number INT NOT NULL PRIMARY KEY,
    Estab_id INT NOT NULL,
    FOREIGN KEY (Estab_id) 
    REFERENCES Establishment (Estab_id));

-- inserting values 

ALTER TABLE retail_food_stores ADD COLUMN County_id SERIAL;


ALTER TABLE retail_food_stores ADD COLUMN Operation_id INT;


UPDATE retail_food_stores SET Operation_id = CONCAT('101', County_id) WHERE Operation_id IS NULL;


ALTER TABLE retail_food_stores ADD COLUMN Estab_id INT;


UPDATE retail_food_stores SET Estab_id = CONCAT('9170', County_id) WHERE Estab_id IS NULL;

-- County table

INSERT INTO County (County_id, County)
SELECT County_id, County FROM retail_food_stores;

SELECT * FROM County;

-- Operation table

INSERT INTO Operation (Operation_id, Operation_Type)
SELECT Operation_id, Operation_Type FROM retail_food_stores;

SELECT * FROM Operation;

-- Establishment table

ALTER TABLE Establishment
MODIFY COLUMN City VARCHAR(295), 
MODIFY COLUMN Street_Number VARCHAR(270),
MODIFY COLUMN Entity_Name VARCHAR(225),
MODIFY COLUMN DBA_Name VARCHAR(245),
MODIFY COLUMN Street_Name VARCHAR(218),
MODIFY COLUMN State VARCHAR(199),
MODIFY COLUMN Georeference VARCHAR(246);

INSERT INTO Establishment(
Estab_id, Entity_Name, DBA_Name, Street_Number, City, State, Square_Footage, Georeference
)
SELECT Estab_id, Entity_Name, DBA_Name, Street_Number, City, State, Square_Footage, Georeference 
FROM retail_food_stores;

DELETE FROM Establishment; # since we didnt insert Street_Name previously

INSERT INTO Establishment(
Estab_id, Entity_Name, DBA_Name, Street_Number, Street_Name, City, State, Square_Footage, Georeference
)
SELECT Estab_id, Entity_Name, DBA_Name, Street_Number, Street_Name, City, State, Square_Footage, Georeference 
FROM retail_food_stores;

SELECT * FROM Establishment;

-- Establishment_Zip table

INSERT INTO Establishment_Zip(Estab_id,Zip_Code)
SELECT Estab_id,Zip_Code FROM retail_food_stores;

SELECT * FROM Establishment_Zip;

-- License table

INSERT INTO License(License_Number,Estab_id)
SELECT License_Number,Estab_id FROM retail_food_stores;

SELECT * FROM License;

-- Indexing

CREATE INDEX idx_establishment_city ON Establishment (City);

CREATE INDEX idx_establishment_georeference ON Establishment (Georeference);

CREATE INDEX idx_establishment_city_state ON Establishment (City, State);

-- More queries

-- top 30 cities with the highest number of food establishments

SELECT City, COUNT(*) AS Num_Estab FROM Establishment
GROUP BY City
ORDER BY Num_Estab DESC
LIMIT 30;

-- average square footage of food establishments by state


SELECT State, AVG(Square_Footage) AS AvgSqFt
FROM Establishment
GROUP BY State;

-- 10 zip codes with the highest number of food establishments

SELECT SUBSTRING_INDEX(Street_Name, ' ', -1) AS Zip_Code, COUNT(*) AS Num_Estab
FROM Establishment
GROUP BY Zip_Code
ORDER BY Num_Estab DESC
LIMIT 10;

-- Execution analysis

EXPLAIN SELECT * FROM Establishment WHERE City = 'New York' AND Square_Footage > 5000;


