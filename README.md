# 📊 SQL - Projeto de Análise de Vendas

Este projeto demonstra a aplicação robusta de SQL para transformar dados brutos de transações de varejo em insights estratégicos. Utilizando um conjunto de dados de vendas, o trabalho foca na limpeza, exploração e análise avançada para solucionar desafios de negócio. Os objetivos específicos incluem: avaliar o desempenho das vendas por categoria, identificar clientes de maior valor e mapear o comportamento de compra ao longo do tempo (incluindo picos de venda e segmentação horária). O resultado é uma série de consultas SQL complexas que fornecem uma base sólida para a tomada de decisões em otimização de estoque, campanhas de marketing e planejamento operacional.

## 🎯 Objetivos do Projeto
O objetivo principal deste projeto foi aplicar habilidades em SQL para:

Limpar e Preparar os Dados: Garantir a integridade dos dados, identificando e tratando valores nulos.

Explorar os Dados (EDA): Entender a estrutura do conjunto de dados, o número de transações, clientes e categorias de produtos.

Resolver Questões de Negócio: Responder a perguntas específicas de negócio por meio de consultas SQL complexas, como agregação, window functions e CTEs (Common Table Expressions).

## 📂 Estrutura do Conjunto de Dados
O conjunto de dados retail_sales contém informações detalhadas sobre cada transação de venda. A tabela foi criada com a seguinte estrutura:
| Coluna | Tipo de Dado | Descrição |
| :--- | :--- | :--- |
| **`transaction_id`** | INT | **Chave Primária**. Identificador único da transação. |
| `sale_date` | DATE | Data em que a venda ocorreu. |
| `sale_time` | TIME | Hora em que a venda ocorreu. |
| `customer_id` | INT | Identificador do cliente que realizou a compra. |
| `gender` | VARCHAR(15) | Gênero do cliente. |
| `age` | INT | Idade do cliente. |
| `category` | VARCHAR(15) | Categoria do produto vendido. |
| `quantity` | INT | Número de unidades vendidas na transação. |
| `price_per_unit` | FLOAT | Preço de venda por unidade do produto. |
| `cogs` | FLOAT | Custo dos Bens Vendidos. |
| `total_sale` | FLOAT | Valor total da venda. |

### 1. Construção do conjunto de dados
```sql
CREATE DATABASE p1_retail_db;

CREATE TABLE retail_sales
(
    transactions_id INT PRIMARY KEY,
    sale_date DATE,	
    sale_time TIME,
    customer_id INT,	
    gender VARCHAR(10),
    age INT,
    category VARCHAR(35),
    quantity INT,
    price_per_unit FLOAT,	
    cogs FLOAT,
    total_sale FLOAT
);
```
### 2. Exploração e limpeza dos dados
```sql
SELECT COUNT(*)
FROM retail_sales; -- obter a contagem de registros

SELECT COUNT(DISTINCT customer_id)
FROM retail_sales; -- obter a contagem de clientes unicos

SELECT DISTINCT category
FROM retail_sales; -- obter a contagem de categorias unicas

SELECT *
FROM retail_sales
WHERE 
    sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
    gender IS NULL OR age IS NULL OR category IS NULL OR 
    quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL;

DELETE
FROM retail_sales
WHERE 
    sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
    gender IS NULL OR age IS NULL OR category IS NULL OR 
    quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL;
```
### 3. Análise de dados e resultados
Foram definidas 10 perguntas específicas de negócios, visando extrair insights acerca dos dados:

- Quais transações foram realizadas no dia 24/11/2022 (Véspera de Natal) ?

```sql
SELECT *
FROM retail_sales
WHERE sale_date = '2022-12-24';
```
 
- Quais transações foram da categória 'Vestuário' na véspera de natal ?

```sql
SELECT *
FROM retail_sales
WHERE 
	category = 'Clothing' AND
	TO_CHAR(sale_date, 'YYYY-MM') = '2022-11';
```
     
- Durante todo o período, qual foi o total de vendas e transações para cada categoria ?

```sql
SELECT
	category,
	SUM(total_sale) AS total_sale,
	COUNT(*) AS total_order
FROM retail_sales
GROUP BY category;
```

- Qual a idade média dos clientes que compram produtos da categoria 'Beleza' ?

```sql
SELECT
	ROUND(AVG(age), 2) AS avg_age
FROM retail_sales
WHERE category = 'Beauty';
```
     
- Quais transações tiveram um valor total de venda maior que $ 1000?

```sql
SELECT *
FROM retail_sales
WHERE total_sale > 1000;
```
     
- Quantas transações foram feitas por clientes do gênero masculino ? E feminino ?

```sql
SELECT
	gender,
	category,
	COUNT(*) AS total_transaction
FROM retail_sales
GROUP BY gender, category
ORDER BY category;
```
     
- Qual a média de vendas de cada mês ? Qual mês houve o maior número de vendas em cada ano ?

```sql
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
```
     
- Quais os 5 clientes que possuem o maior volume total de vendas ?

```sql
SELECT
	customer_id,
	SUM(total_sale) AS total_sale
FROM retail_sales
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;
```
     
- Quantos clientes únicos compraram itens de cada categoria ?

```sql
SELECT
	category,
	COUNT(DISTINCT customer_id) AS customer
FROM retail_sales
GROUP BY category;
```
      
- Qual o total de transações em cada turno do dia ?

```sql
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
```
  
