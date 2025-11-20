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

- 1. Qual o número de transações realizadas no dia 24/11/2022 (Véspera de Natal) ?
 
- 2. Quantas transações foram da categória 'Vestuário' e com quantidade maior que 4 na véspera de natal ?
     
- 3. Durante todo o período, qual foi o total de transações de cada categoria ?
     
- 4. Qual a idade média dos clientes que compram produtos da categoria 'Beleza' ?
     
- 5. Qauis transações tiveram um valor total de venda maior que $ 1000?
     
- 6. Quantas transações foram feitas por clientes do gênero masculino ? E feminino ?
     
- 7. Qual a média de vendas de cada mês ? Qual mês houve o maior número de vendas em cada ano ?
     
- 8. Quais os 5 clientes que possuem o maior volume total de vendas ?
     
- 9. Quantos clientes únicos compraram itens de cada categoria ?
      
- 10. Qual o total de transações em cada turno do dia ?
  
