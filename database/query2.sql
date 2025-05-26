
--step 1: table for Orders data
create table Orders
(
  OrderID INT PRIMARY KEY,
  UserId INT FOREIGN KEY REFERENCES Users(UserId),
  OrderDate DATETIME default getdate(),
  TotalAmount money NOT NULL,
  OrderStatus VARCHAR(20) CHECK (OrderStatus IN ('Pending', 'Shipped', 'Delivered', 'Cancelled')) default 'Pending'
);

--step 2: table for Orderdetails data
Create table OrderDetails
(
  OrderDetails INT PRIMARY KEY,
  OrderId INT FOREIGN KEY REFERENCES Orders(OrderID) on delete cascade,
  ProductId INT FOREIGN KEY REFERENCES Products(ProductID),
  Quantity INT CHECK (Quantity >0),
  Price MONEY Not null,
  Subtotal AS (Quantity*Price) Persisted --persisted is used to stored data physically in the table, saving computation time on queries.
 );

--step 3: table for payments data
create table Payments
(
  PaymentId INT PRIMARY KEY IDENTITY,
  OrderId INT FOREIGN KEY REFERENCES Orders(OrderId) on Delete cascade,
  PaymentMethod VARCHAR(50) CHECK (PaymentMethod IN ('Credit','Paypal','UPI','Net Banking')),
  PaymentStatus VARCHAR(20) CHECK (PaymentStatus IN ('Pending','Completed','Failed')) Default 'Pending',
  TransactionId VARCHAR(100) UNIQUE,
  PaymentDate DATETIME Default getdate()
);

--step 4: table for productReviews data
create table ProductReviews
(
  ReviewId INT PRIMARY KEY IDENTITY,
  UserId INT FOREIGN KEY REFERENCES Users(UserId),
  ProductId INT FOREIGN KEY REFERENCES Products(ProductId),
  Rating INT CHECK (Rating BETWEEN 1 AND 5),
  ReviewText TEXT,
  CreatedAt DATETIME default getdate()
);


