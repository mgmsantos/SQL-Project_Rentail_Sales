# 📊 SQL - Projeto de Análise de Vendas

Este projeto demonstra a aplicação robusta de SQL para transformar dados brutos de transações de varejo em insights estratégicos. Utilizando um conjunto de dados de vendas, o trabalho foca na limpeza, exploração e análise avançada para solucionar desafios de negócio. Os objetivos específicos incluem: avaliar o desempenho das vendas por categoria, identificar clientes de maior valor e mapear o comportamento de compra ao longo do tempo (incluindo picos de venda e segmentação horária). O resultado é uma série de consultas SQL complexas que fornecem uma base sólida para a tomada de decisões em otimização de estoque, campanhas de marketing e planejamento operacional.

## Objetivos do Projeto
O objetivo principal deste projeto foi aplicar habilidades em SQL para:

Limpar e Preparar os Dados: Garantir a integridade dos dados, identificando e tratando valores nulos.

Explorar os Dados (EDA): Entender a estrutura do conjunto de dados, o número de transações, clientes e categorias de produtos.

Resolver Questões de Negócio: Responder a perguntas específicas de negócio por meio de consultas SQL complexas, como agregação, window functions e CTEs (Common Table Expressions).

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
