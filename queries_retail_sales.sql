-- Criar a tabela
DROP TABLE IF EXISTS retail_sales;
CREATE TABLE retail_sales(
                transaction_id INT PRIMARY KEY,	
                sale_date DATE,	 
                sale_time TIME,	
                customer_id	INT,
                gender VARCHAR(15),
                age	INT,
                category VARCHAR(15),	
                quantity INT,
                price_per_unit FLOAT,	
                cogs FLOAT,
                total_sale FLOAT
            );

SELECT 
	COUNT(*)
FROM retail_sales;
-- Há 2000 registros

-- Verificar linhas com dados nulos
SELECT * FROM retail_sales
WHERE
	transaction_id IS NULL
	OR
	sale_date IS NULL
	OR
	sale_time IS NULL
	OR
	customer_id IS NULL
	OR
	gender IS NULL
	OR
	age IS NULL
	OR
	category IS NULL
	OR
	quantity IS NULL
	OR
	price_per_unit IS NULL
	OR
	cogs IS NULL
	OR
	total_sale IS NULL;

-- Deletar linhas com valores nulos (exceto idade)
DELETE FROM retail_sales
WHERE
	transaction_id IS NULL
	OR
	sale_date IS NULL
	OR
	sale_time IS NULL
	OR
	customer_id IS NULL
	OR
	gender IS NULL
	OR
	category IS NULL
	OR
	quantity IS NULL
	OR
	price_per_unit IS NULL
	OR
	cogs IS NULL
	OR
	total_sale IS NULL;

-- Exploração de dados

-- Quanto foi vendido? 1997 vendas
SELECT 
	COUNT(*) AS total_sales
FROM retail_sales;

-- Quantos clientes existem? Existem 155 clientes
SELECT
	COUNT(DISTINCT customer_id) AS customers
FROM retail_sales;

-- Quantas categorias de produtos existem?
SELECT
	DISTINCT category
FROM retail_sales;

-- Análise de dados e resolução de problemas de negócio

-- Q1. Quantas transações foram feitas em 2022-09-20?
SELECT *
FROM retail_sales
WHERE sale_date = '2022-09-20';

-- Q2. Recuperar as transações quando a categoria for 'Clothing' e a quantidade vendida for maior ou igual 4 no mês de Out-2022
SELECT *
FROM retail_sales
WHERE 
	category = 'Clothing' AND
	TO_CHAR(sale_date, 'YYYY-MM') = '2022-11' AND
	quantity >= 4;

-- Q3. Obtenha o total de vendas (total_sale) e o número de ordens para cada categoria
SELECT
	category,
	SUM(total_sale) AS total_sale,
	COUNT(*) AS total_order
FROM retail_sales
GROUP BY category;

-- Q4. Qual a média de idade dos clientes que compraram itens da categoria Beauty?
SELECT
	ROUND(AVG(age), 2) AS avg_age
FROM retail_sales
WHERE category = 'Beauty';

-- Q5. Encontre todas as transações em que total_sale seja maior que 1000.
SELECT *
FROM retail_sales
WHERE total_sale > 1000;

-- Q6. Encontre o total de transações feitas por cada genero em cada categoria
SELECT
	gender,
	category,
	COUNT(*) AS total_transaction
FROM retail_sales
GROUP BY gender, category
ORDER BY category;

-- Q7. Calcule a média de vendas para cada mês. Encontre o melhor mês de vendas para cada ano
SELECT
	year,
	month,
	avg_sale
FROM
(
	SELECT
		EXTRACT(YEAR FROM sale_date) AS year,
		EXTRACT(MONTH FROM sale_date) AS month,
		AVG(total_sale) AS avg_sale,
		RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) AS rank
	FROM retail_sales
	GROUP BY 1, 2
) AS t1
WHERE rank = 1;

-- Q8. Encontre o top 5 clientes com base no maior total de vendas
SELECT
	customer_id,
	SUM(total_sale) AS total_sale
FROM retail_sales
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;

-- Q9. Encontrar o número de clientes que compraram itens de cada categoria

SELECT
	category,
	COUNT(DISTINCT customer_id) AS customer
FROM retail_sales
GROUP BY category;

-- Q10. Encontre o total de transações de acordo com o período do dia

WITH hourly_sales AS
(
	SELECT *,
		CASE
			WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
			WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
			ELSE 'Evening'
		END AS shift
	FROM retail_sales
)
SELECT
	shift,
	COUNT(transaction_id)
FROM hourly_sales
GROUP BY shift;

-- Fim do projeto





