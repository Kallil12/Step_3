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
