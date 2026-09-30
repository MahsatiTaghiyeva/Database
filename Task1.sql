CREATE TABLE Categories
(
    Id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    Name VARCHAR(100) NOT NULL UNIQUE
);
CREATE TABLE Colors
(
    Id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    Name VARCHAR(50) NOT NULL UNIQUE
);
CREATE TABLE Products
(
    Id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    Name VARCHAR(150) NOT NULL,
    Price NUMERIC(10,2) NOT NULL CHECK (Price >= 0),
    Cost NUMERIC(10,2) NOT NULL CHECK (Cost >= 0),
    CategoryId INT NOT NULL,

    CONSTRAINT FK_Products_Categories
        FOREIGN KEY (CategoryId)
        REFERENCES Categories(Id)
);
CREATE TABLE ProductColors
(
    ProductId INT NOT NULL,
    ColorId INT NOT NULL,

    PRIMARY KEY (ProductId, ColorId),

    CONSTRAINT FK_ProductColors_Products
        FOREIGN KEY (ProductId)
        REFERENCES Products(Id)
        ON DELETE CASCADE,

    CONSTRAINT FK_ProductColors_Colors
        FOREIGN KEY (ColorId)
        REFERENCES Colors(Id)
        ON DELETE CASCADE
);
INSERT INTO Categories (Name)
VALUES
    ('Electronics'),
    ('Clothing'),
    ('Books');
INSERT INTO Colors (Name)
VALUES
    ('Black'),
    ('White'),
    ('Blue'),
    ('Red');
INSERT INTO Products (Name, Price, Cost, CategoryId)
VALUES
    ('Laptop', 1200.00, 900.00, 1),
    ('T-Shirt', 30.00, 15.00, 2),
    ('Novel', 20.00, 10.00, 3),
    ('Smartphone', 800.00, 600.00, 1);
INSERT INTO ProductColors (ProductId, ColorId)
VALUES
    (1, 1),
    (1, 2),
    (1, 3),
    (2, 1),
    (2, 4),
    (3, 1),
    (4, 1),
    (4, 2);
SELECT
    p.Name AS "Product Name",
    p.Price,
    p.Cost,
    c.Name AS "Category Name",
    co.Name AS "Color Name"
FROM Products p
JOIN Categories c
    ON p.CategoryId = c.Id
JOIN ProductColors pc
    ON p.Id = pc.ProductId
JOIN Colors co
    ON pc.ColorId = co.Id
ORDER BY p.Id;