SELECT date_trunc('month', o.created_at) AS order_month,
       COUNT(DISTINCT o.id) AS count_orders,
       SUM(CASE
             WHEN opli.partner_id IS NULL THEN oli.item_price * oli.quantity
             ELSE opli.item_price * pf.contract_rate * opli.quantity
           END) AS total_gross_sales,
       SUM(CASE
             WHEN opli.partner_id IS NULL THEN oli.item_cost * oli.quantity
             ELSE opli.item_price * opli.quantity
           END) AS total_net_sales,
       array_agg(o.id) AS list_order
FROM orders o
JOIN order_line_items oli ON o.id = oli.order_id
LEFT JOIN order_partner_line_items opli ON o.id = opli.order_id AND oli.part_number = opli.part_number
LEFT JOIN partner_feature pf ON opli.partner_id = pf.id
JOIN users u ON o.user_id = u.id
WHERE u.email NOT LIKE '%@vention.cc'
  AND o.created_at >= '2021-01-01'
GROUP BY order_month
ORDER BY order_month;

--------------------------------------------------------------------------------
-- for better readability

SELECT EXTRACT('year' FROM o.created_at) AS order_year,
	   EXTRACT('month' FROM o.created_at) AS order_month,
	   CASE
	   	WHEN EXTRACT('month' FROM o.created_at) = 1 THEN 'Jan'
		WHEN EXTRACT('month' FROM o.created_at) = 2 THEN 'Feb'
		WHEN EXTRACT('month' FROM o.created_at) = 3 THEN 'Mar'
		WHEN EXTRACT('month' FROM o.created_at) = 4 THEN 'Apr'
		WHEN EXTRACT('month' FROM o.created_at) = 5 THEN 'May'
		WHEN EXTRACT('month' FROM o.created_at) = 6 THEN 'Jun'
		WHEN EXTRACT('month' FROM o.created_at) = 7 THEN 'Jul'
		WHEN EXTRACT('month' FROM o.created_at) = 8 THEN 'Aug'
		WHEN EXTRACT('month' FROM o.created_at) = 9 THEN 'Sep'
		WHEN EXTRACT('month' FROM o.created_at) = 10 THEN 'Oct'
		WHEN EXTRACT('month' FROM o.created_at) = 11 THEN 'Nov'
		WHEN EXTRACT('month' FROM o.created_at) = 12 THEN 'Dec'
 	   END AS order_month_name,
	   --EXTRACT('month' FROM o.created_at) AS order_month,
       COUNT(DISTINCT o.id) AS count_orders,
       SUM(CASE
             WHEN opli.partner_id IS NULL THEN oli.item_price * oli.quantity
             ELSE opli.item_price * pf.contract_rate * opli.quantity
           END) AS total_gross_sales,
       SUM(CASE
             WHEN opli.partner_id IS NULL THEN oli.item_cost * oli.quantity
             ELSE opli.item_price * opli.quantity
           END) AS total_net_sales,
       array_agg(o.id) AS list_order
FROM orders o
JOIN order_line_items oli ON o.id = oli.order_id
LEFT JOIN order_partner_line_items opli ON o.id = opli.order_id AND oli.part_number = opli.part_number
LEFT JOIN partner_feature pf ON opli.partner_id = pf.id
JOIN users u ON o.user_id = u.id
WHERE u.email NOT LIKE '%@vention.cc'
  AND o.created_at >= '2021-01-01'
GROUP BY order_year, order_month
ORDER BY order_year, order_month;
