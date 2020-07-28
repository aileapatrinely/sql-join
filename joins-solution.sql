--1. Get all customers and their addresses.
SELECT * FROM "customers"
JOIN "addresses" ON "customers".id="addresses".customer_id;
--2. Get all orders and their line items (orders, quantity and product).
SELECT  FROM "orders"
JOIN "line_items" ON "orders".id="line_items".order_id
JOIN "products" ON "products".id="line_items".product_id;
--3. Which warehouses have cheetos?
SELECT "warehouse".warehouse FROM "warehouse"
JOIN "warehouse_product" ON "warehouse".id= "warehouse_product".warehouse_id
JOIN "products" ON "products".id="warehouse_product".product_id
WHERE "products".description = 'cheetos';
--4. Which warehouses have diet pepsi?
SELECT "warehouse".warehouse FROM "warehouse"
JOIN "warehouse_product" ON "warehouse".id= "warehouse_product".warehouse_id
JOIN "products" ON "products".id="warehouse_product".product_id
WHERE "products".description = 'diet pepsi';

--5. Get the number of orders for each customer. NOTE: It is OK if those without orders are not included in results.
SELECT COUNT ("address_id") occurences FROM "orders"
JOIN "addresses" ON "addresses".id="orders".address_id
JOIN "customers" ON "customers".id="addresses".customer_id
GROUP BY "address_id"
HAVING COUNT ("address_id")>1;
--6. How many customers do we have?
SELECT COUNT("id") FROM "customers";
--7. How many products do we carry?
SELECT COUNT("id") FROM "products";
--8. What is the total available on-hand quantity of diet pepsi?
SELECT SUM("on_hand") FROM "warehouse_product"
JOIN "warehouse" ON "warehouse".id= "warehouse_product".warehouse_id
JOIN "products" ON "products".id="warehouse_product".product_id
WHERE "products".description = 'diet pepsi';

## Stretch
--9. How much was the total cost for each order?
SELECT "products".unit_price*"line_items".quantity FROM "products"
JOIN "line_items" ON "line_items".product_id="products".id
JOIN "orders" ON "orders".id="line_items".order_id;
--10. How much has each customer spent in total?
SELECT SUM("products".unit_price*"line_items".quantity) FROM "products"
JOIN "line_items" ON "line_items".product_id="products".id
JOIN "orders" ON "orders".id="line_items".order_id
JOIN "addresses" ON "addresses".id="orders".address_id
JOIN "customers" ON "customers".id="addresses".customer_id
GROUP BY "customers".id;
--11. How much has each customer spent in total? Customers who have spent $0 should still show up in the table. It should say 0, not NULL (research coalesce).
