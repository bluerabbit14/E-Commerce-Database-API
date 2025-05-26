
                                    ---   ALL DATABASE TABLES  ---
--step 1:  table to store data of "ACTIVE" Users
create table Users
(
  UserID INT PRIMARY KEY IDENTITY(1000,1), 
  FullName VARCHAR(100) NOT NULL,
  Email VARCHAR(150) UNIQUE NOT NULL,
  PasswordHash VARCHAR(255) NOT NULL, 
  PhoneNumber VARCHAR(10) NOT NULL CHECK (PhoneNumber LIKE '%[6-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]%'),
  Address VARCHAR(255) NOT NULL,
  UserRole VARCHAR(20) NOT NULL CHECK (UserRole IN ('Admin','Customer')) DEFAULT 'Customer',
  CreatedAt DATETIME NOT NULL DEFAULT GETDATE()
); 

--step 2:  store procedure to insert data values in users table
   create procedure InsertUser 
   @FullName VARCHAR(100),
   @Email VARCHAR(150),
   @PasswordHash VARCHAR(255), 
   @PhoneNumber VARCHAR(10),
   @Address VARCHAR(255), 
   @UserRole VARCHAR(20)
AS
BEGIN
    Insert into Users
	Values
	(@FullName,@Email,@PasswordHash,@PhoneNumber,@Address,@UserRole,GETDATE());
END;  

--step 3: Store Procedure to generate 8-digit alphanumeric password code
CREATE PROCEDURE GeneratePassword
  @Password VARCHAR(8) OUTPUT
AS
BEGIN
    DECLARE @Chars VARCHAR(62) = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';

    -- Generate 8 random characters from @Chars using NEWID()
    SELECT @Password = 
        SUBSTRING(@Chars, ABS(CHECKSUM(NEWID())) % LEN(@Chars) + 1, 1) +
        SUBSTRING(@Chars, ABS(CHECKSUM(NEWID())) % LEN(@Chars) + 1, 1) +
        SUBSTRING(@Chars, ABS(CHECKSUM(NEWID())) % LEN(@Chars) + 1, 1) +
        SUBSTRING(@Chars, ABS(CHECKSUM(NEWID())) % LEN(@Chars) + 1, 1) +
        SUBSTRING(@Chars, ABS(CHECKSUM(NEWID())) % LEN(@Chars) + 1, 1) +
        SUBSTRING(@Chars, ABS(CHECKSUM(NEWID())) % LEN(@Chars) + 1, 1) +
        SUBSTRING(@Chars, ABS(CHECKSUM(NEWID())) % LEN(@Chars) + 1, 1) +
        SUBSTRING(@Chars, ABS(CHECKSUM(NEWID())) % LEN(@Chars) + 1, 1); 
END;
   DECLARE @GeneratedPassword Varchar(8);
   EXEC GeneratePassword @GeneratedPassword OUTPUT;
   print @GeneratedPassword;


  
--step 4:  table to store data of "ACTIVE" Products
create table Products
(
  ProductID INT PRIMARY KEY IDENTITY(2000,1),    --PK
  ProductName VARCHAR(100) NOT NULL,
  Description TEXT,
  Price money NOT NULL,
  Stock int check(stock>=0),
  Category INT FOREIGN KEY REFERENCES ProductCategory(CategoryId),    --FK
  ImageURL VARCHAR(255),
  CreateAt DATETIME default getdate()
);
--step 5:  store procedure to insert data values in Product table
create procedure InsertProduct
  @ProductName VARCHAR(100),
  @Description TEXT,
  @Price money,
  @Stock int,
  @Category VARCHAR(50),
  @ImageURL VARCHAR(255)
AS
BEGIN
    Insert into Products 
	Values
	(@ProductName,@description,@Price,@Stock,@Category,@ImageURL,GETDATE());
END; 
  EXEC InsertProduct 'pen',NULL,4000,NULL,NULL,NULL;

  select * from users
  select* from products
  select* from productsCategory


--step 6:  table to store data of Product Category
Create table ProductCategory
(
  categoryID INT IDENTITY(3000,1),   --PK
  categoryName VARCHAR(255),
  Description TEXT, 
  PRIMARY KEY(CategoryId)
);

--step 7: create store procedure to insert into category table
 Create Procedure InsertProductsCatogory
  @categoryName VARCHAR(255),
  @Description TEXT
 AS
 BEGIN
        Insert into ProductsCategory
		values
		(@categoryName,@Description);
 END; 
       EXEC InsertProductsCatogory 'Industrial',NULL;