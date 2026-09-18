CREATE TABLE dim_customer
(
    CustomerKey INT IDENTITY(1,1) PRIMARY KEY,

    customer_id VARCHAR(50) NOT NULL,
    customer_unique_id VARCHAR(50),

    customer_zip_code_prefix INT,
    customer_city VARCHAR(100),
    customer_state VARCHAR(10)
);
INSERT INTO dbo.Dim_Customer
(
    customer_id,
    customer_unique_id,
    customer_zip_code_prefix,
    customer_city,
    customer_state
)
SELECT
    customer_id,
    customer_unique_id,
    customer_zip_code_prefix,
    customer_city,
    customer_state
FROM dbo.olist_customers_dataset;

------------------------------------------------------------------------------------------------------
CREATE TABLE dbo.Dim_Product
(
    ProductKey INT IDENTITY(1,1) PRIMARY KEY,

    product_id VARCHAR(50) NOT NULL,

    product_category VARCHAR(100),

    product_name_length INT,
    product_description_length INT,
    product_photos_qty INT,

    product_weight_g DECIMAL(12,2),
    product_length_cm DECIMAL(12,2),
    product_height_cm DECIMAL(12,2),
    product_width_cm DECIMAL(12,2)
);


INSERT INTO dbo.Dim_Product
(
    product_id,
    product_category,
    product_name_length,
    product_description_length,
    product_photos_qty,
    product_weight_g,
    product_length_cm,
    product_height_cm,
    product_width_cm
)
SELECT
    p.product_id,

    COALESCE(
        t.product_category_name_english,
        p.product_category_name
    ) AS product_category,

    p.product_name_lenght,
    p.product_description_lenght,
    p.product_photos_qty,

    p.product_weight_g,
    p.product_length_cm,
    p.product_height_cm,
    p.product_width_cm

FROM olist_products_dataset p

LEFT JOIN product_category_name_translation t
    ON p.product_category_name = t.product_category_name;
----------------------------------------------------------------------------------------------------------------------------------------

CREATE TABLE dbo.Dim_Seller
(
    SellerKey INT IDENTITY(1,1) PRIMARY KEY,

    seller_id VARCHAR(50) NOT NULL,

    seller_zip_code_prefix INT,
    seller_city VARCHAR(100),
    seller_state VARCHAR(10)
);
INSERT INTO dbo.Dim_Seller
(
    seller_id,
    seller_zip_code_prefix,
    seller_city,
    seller_state
)
SELECT
    seller_id,
    seller_zip_code_prefix,
    seller_city,
    seller_state
FROM dbo.olist_sellers_dataset;
---------------------------------------------------------------------------------------------------------------------
CREATE TABLE dbo.Dim_Date
(
    DateKey INT PRIMARY KEY,

    FullDate DATE NOT NULL,

    Year INT,
    MonthNumber INT,
    MonthName VARCHAR(20),

    QuarterNumber INT,
    QuarterName VARCHAR(10),

    DayOfMonth INT,
    DayOfWeekNumber INT,
    DayName VARCHAR(20)
);

DECLARE @StartDate DATE = '2016-01-01';
DECLARE @EndDate DATE = '2018-12-31';

WHILE @StartDate <= @EndDate
BEGIN

    INSERT INTO dbo.Dim_Date
    (
        DateKey,
        FullDate,
        Year,
        MonthNumber,
        MonthName,
        QuarterNumber,
        QuarterName,
        DayOfMonth,
        DayOfWeekNumber,
        DayName
    )
    VALUES
    (
        CONVERT(INT, CONVERT(VARCHAR(8), @StartDate, 112)),
        @StartDate,
        YEAR(@StartDate),
        MONTH(@StartDate),
        DATENAME(MONTH, @StartDate),
        DATEPART(QUARTER, @StartDate),
        'Q' + CAST(DATEPART(QUARTER, @StartDate) AS VARCHAR(1)),
        DAY(@StartDate),
        DATEPART(WEEKDAY, @StartDate),
        DATENAME(WEEKDAY, @StartDate)
    );

    SET @StartDate = DATEADD(DAY, 1, @StartDate);

END;

-----------------------------------------------------------------------------------------------------------------------------------
CREATE TABLE dbo.Fact_Sales
(
    SalesKey BIGINT IDENTITY(1,1) PRIMARY KEY,

    order_id VARCHAR(50) NOT NULL,

    ProductKey INT NOT NULL,
    CustomerKey INT NOT NULL,
    SellerKey INT NOT NULL,
    DateKey INT NOT NULL,

    order_item_id INT,

    price DECIMAL(12,2),
    freight_value DECIMAL(12,2),

    order_status VARCHAR(30),

    delivery_date DATE,
    estimated_delivery_date DATE
);
INSERT INTO dbo.Fact_Sales
(
    order_id,
    ProductKey,
    CustomerKey,
    SellerKey,
    DateKey,
    order_item_id,
    price,
    freight_value,
    order_status,
    delivery_date,
    estimated_delivery_date
)
SELECT

    oi.order_id,

    p.ProductKey,

    c.CustomerKey,

    s.SellerKey,

    d.DateKey,

    oi.order_item_id,

    oi.price,

    oi.freight_value,

    o.order_status,

    CAST(o.order_delivered_customer_date AS DATE),

    CAST(o.order_estimated_delivery_date AS DATE)

FROM dbo.olist_order_items_dataset oi

INNER JOIN dbo.olist_orders_dataset o
    ON oi.order_id = o.order_id

INNER JOIN dbo.Dim_Product p
    ON oi.product_id = p.product_id

INNER JOIN dbo.Dim_Customer c
    ON o.customer_id = c.customer_id

INNER JOIN dbo.Dim_Seller s
    ON oi.seller_id = s.seller_id

INNER JOIN dbo.Dim_Date d
    ON CAST(o.order_purchase_timestamp AS DATE) = d.FullDate;
-------------------------------------------------------------------------------------------------------------------
ALTER TABLE Fact_Sales
ADD CONSTRAINT FK_Fact_Product
FOREIGN KEY (ProductKey)
REFERENCES dbo.Dim_Product(ProductKey);






ALTER TABLE Fact_Sales
ADD CONSTRAINT FK_Fact_Customer
FOREIGN KEY (CustomerKey)
REFERENCES dbo.Dim_Customer(CustomerKey);




ALTER TABLE Fact_Sales
ADD CONSTRAINT FK_Fact_Seller
FOREIGN KEY (SellerKey)
REFERENCES dbo.Dim_Seller(SellerKey);






ALTER TABLE Fact_Sales
ADD CONSTRAINT FK_Fact_Date
FOREIGN KEY (DateKey)
REFERENCES dbo.Dim_Date(DateKey);



