-- 1. 各省份总销售额（实际支付金额）排名
SELECT
    收货地址,
    ROUND(SUM(CAST(买家实际支付金额 AS DECIMAL(10,2))), 2) AS 总销售额,
    RANK() OVER (ORDER BY SUM(CAST(买家实际支付金额 AS DECIMAL(10,2))) DESC) AS 排名
FROM xiao_shou_biao
WHERE 买家实际支付金额 IS NOT NULL AND 买家实际支付金额 != ''
GROUP BY 收货地址
ORDER BY 排名;
-- 2. 按订单创建时间的小时统计订单数、总销售额
SELECT
    HOUR(订单创建时间) AS 小时,
    COUNT(*) AS 订单数,
    ROUND(SUM(CAST(买家实际支付金额 AS DECIMAL(10,2))), 2) AS 总销售额
FROM xiao_shou_biao
WHERE 订单创建时间 IS NOT NULL
GROUP BY HOUR(订单创建时间)
ORDER BY 小时;
-- 3. 每日累计销售额
SELECT
    DATE(订单创建时间) AS 日期,
    ROUND(SUM(CAST(买家实际支付金额 AS DECIMAL(10,2))), 2) AS 日销售额,
    ROUND(SUM(SUM(CAST(买家实际支付金额 AS DECIMAL(10,2)))) OVER (ORDER BY DATE(订单创建时间)), 2) AS 累计销售额
FROM xiao_shou_biao
WHERE 订单创建时间 IS NOT NULL
GROUP BY DATE(订单创建时间)
ORDER BY 日期;

-- 4. 金额分层
SELECT
    CASE
        WHEN CAST(买家实际支付金额 AS DECIMAL(10,2)) BETWEEN 0 AND 50 THEN '0-50'
        WHEN CAST(买家实际支付金额 AS DECIMAL(10,2)) BETWEEN 50.01 AND 200 THEN '50-200'
        WHEN CAST(买家实际支付金额 AS DECIMAL(10,2)) BETWEEN 200.01 AND 500 THEN '200-500'
        WHEN CAST(买家实际支付金额 AS DECIMAL(10,2)) > 500 THEN '500以上'
        ELSE '未知'
        END AS 金额分层,
    COUNT(*) AS 订单数,
    ROUND(SUM(CAST(买家实际支付金额 AS DECIMAL(10,2))), 2) AS 总销售额,
    ROUND(AVG(CAST(买家实际支付金额 AS DECIMAL(10,2))), 2) AS 平均订单金额,
 
    ROUND(SUM(CASE WHEN CAST(退款金额 AS DECIMAL(10,2)) > 0 THEN 1 ELSE 0 END) / COUNT(*) * 100, 2) AS 退款率_百分比
FROM xiao_shou_biao
WHERE 买家实际支付金额 IS NOT NULL AND 买家实际支付金额 != ''
GROUP BY 金额分层
ORDER BY MIN(CAST(买家实际支付金额 AS DECIMAL(10,2)));
-- 5. 各省份退款率
SELECT
    收货地址,
    COUNT(*) AS 总订单数,
    SUM(CASE WHEN CAST(退款金额 AS DECIMAL(10,2)) > 0 THEN 1 ELSE 0 END) AS 退款订单数,
    ROUND(SUM(CASE WHEN CAST(退款金额 AS DECIMAL(10,2)) > 0 THEN 1 ELSE 0 END) / COUNT(*) * 100, 2) AS 退款率_百分比
FROM xiao_shou_biao
WHERE 收货地址 IS NOT NULL
GROUP BY 收货地址
ORDER BY 退款率_百分比 DESC;
-- 6. 按小时统计退款订单数和退款率
SELECT
    HOUR(订单创建时间) AS 小时,
    COUNT(*) AS 订单数,
    SUM(CASE WHEN CAST(退款金额 AS DECIMAL(10,2)) > 0 THEN 1 ELSE 0 END) AS 退款订单数,
    ROUND(SUM(CASE WHEN CAST(退款金额 AS DECIMAL(10,2)) > 0 THEN 1 ELSE 0 END) / COUNT(*) * 100, 2) AS 退款率_百分比
FROM xiao_shou_biao
WHERE 订单创建时间 IS NOT NULL
GROUP BY HOUR(订单创建时间)
ORDER BY 小时;
-- 7. 未付款订单按小时分布
SELECT
    HOUR(订单创建时间) AS 小时,
    COUNT(*) AS 未付款订单数
FROM xiao_shou_biao
WHERE (CAST(买家实际支付金额 AS DECIMAL(10,2)) = 0 OR 买家实际支付金额 IS NULL OR 买家实际支付金额 = '')
  AND (CAST(退款金额 AS DECIMAL(10,2)) = 0 OR 退款金额 IS NULL OR 退款金额 = '')
GROUP BY HOUR(订单创建时间)
ORDER BY 小时;
-- 8. 未付款订单按省份分布
SELECT
    收货地址,
    COUNT(*) AS 未付款订单数
FROM xiao_shou_biao
WHERE (CAST(买家实际支付金额 AS DECIMAL(10,2)) = 0 OR 买家实际支付金额 IS NULL OR 买家实际支付金额 = '')
  AND (CAST(退款金额 AS DECIMAL(10,2)) = 0 OR 退款金额 IS NULL OR 退款金额 = '')
GROUP BY 收货地址
ORDER BY 未付款订单数 DESC;
