USE supply_chain_db;
# SQL Analysis & Stored Procedures

#Supplier Performance Analysis
DELIMITER $$
CREATE PROCEDURE supplier_performance()
BEGIN
	SELECT
		supplier_name,
        month,
        SUM(order_qty)AS total_order_qty
	FROM supply_chain_data
    GROUP BY supplier_name,month
    ORDER BY total_order_qty DESC;
END $$

DELIMITER ;

#Supplier Dependency Risk Analysis
DELIMITER $$
CREATE PROCEDURE supplier_dependency_risk()
BEGIN
	SELECT
		supplier_name,
        SUM(order_qty)AS total_qty,
        ROUND(SUM(order_qty)*100.0/(SELECT SUM(order_qty)
        FROM supply_chain_data),2
        )AS contribution_percent
	FROM supply_chain_data
    GROUP BY supplier_name
    ORDER BY contribution_percent DESC;
END $$
DELIMITER ;

# Monthly Procurement Trend
DELIMITER $$
CREATE PROCEDURE monthly_procurement_trend()
BEGIN
	SELECT
		month,
        SUM(order_qty)AS total_procurement
	FROM supply_chain_data
    GROUP BY month
    ORDER BY month;
END $$
DELIMITER ;

# Top Supplier Identification
DELIMITER $$
CREATE PROCEDURE top_suppliers()
BEGIN
	SELECT
		supplier_name,
        SUM(order_qty)AS total_qty
	FROM supply_chain_data
    GROUP BY supplier_name 
    ORDER BY total_qty DESC
    LIMIT 5;
END $$
DELIMITER ;

# Demand Fluctuation Detection
DELIMITER $$
CREATE PROCEDURE demand_fluctuation()
BEGIN
	SELECT 
		supplier_name,
        MAX(order_qty)AS max_qty,
        MIN(order_qty)AS min_qty,
        AVG(order_qty)AS avg_qty
	FROM supply_chain_data
    GROUP BY supplier_name;
END $$
DELIMITER ;

# Supplier Monthly Growth
DELIMITER $$
CREATE PROCEDURE supplier_monthly_growth()
BEGIN
	SELECT
		supplier_name,
        month,
        SUM(order_qty)AS total_qty,
        LAG(SUM(order_qty))OVER(PARTITION BY supplier_name ORDER BY month)AS previous_month_qty
	FROM supply_chain_data
    GROUP BY supplier_name,month ;
END $$
DELIMITER ;
    
	


