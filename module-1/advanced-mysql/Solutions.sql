# Challenge 1
SELECT a.au_id AS 'AUTHOR_ID', title.title_id AS 'TITLE_ID',
title.advance * ta.royaltyper / 100 AS 'ADVANCE',
title.price * s.qty * title.royalty / 100 * ta.royaltyper / 100 AS 'Sales_Royalty'
FROM authors a
INNER JOIN titleauthor ta ON a.au_id = ta.au_id 
INNER JOIN titles title ON ta.title_id = title.title_id
INNER JOIN sales s ON ta.title_id = s.title_id

SELECT AUTHOR_ID, TITLE_ID, Sales_Royalty as 'Agg_Royalties'
FROM (
    SELECT a.au_id AS 'AUTHOR_ID', title.title_id AS 'TITLE_ID',
        title.advance * ta.royaltyper / 100 AS 'ADVANCE',
        SUM(title.price * s.qty * title.royalty / 100 * ta.royaltyper / 100) AS 'Sales_Royalty'
    FROM authors a
        INNER JOIN titleauthor ta ON a.au_id = ta.au_id 
        INNER JOIN titles title ON ta.title_id = title.title_id
        INNER JOIN sales s ON ta.title_id = s.title_id
    GROUP BY a.au_id, title.title_id 
) summary;

SELECT AUTHOR_ID, Agg_Royalties + Agg_Advance AS Profits
FROM (
    SELECT AUTHOR_ID, TITLE_ID, Sales_Royalty as 'Agg_Royalties', ADVANCE as 'Agg_Advance'
    FROM (
        SELECT a.au_id AS 'AUTHOR_ID', title.title_id AS 'TITLE_ID',
            SUM(title.advance * ta.royaltyper / 100) AS 'ADVANCE',
            SUM(title.price * s.qty * title.royalty / 100 * ta.royaltyper / 100) AS 'Sales_Royalty'
        FROM authors a
            INNER JOIN titleauthor ta ON a.au_id = ta.au_id 
            INNER JOIN titles title ON ta.title_id = title.title_id
            INNER JOIN sales s ON ta.title_id = s.title_id
        GROUP BY a.au_id, title.title_id 
) summary) total
ORDER BY Profits Desc
Limit 3

# Challenge 2
CREATE TEMPORARY TABLE authors.sales_test
SELECT a.au_id AS 'AUTHOR_ID', title.title_id AS 'TITLE_ID',
    title.advance * ta.royaltyper / 100 AS 'ADVANCE',
    title.price * s.qty * title.royalty / 100 * ta.royaltyper / 100 AS 'Sales_Royalty'
FROM authors a
    INNER JOIN titleauthor ta ON a.au_id = ta.au_id 
    INNER JOIN titles title ON ta.title_id = title.title_id
    INNER JOIN sales s ON ta.title_id = s.title_id
GROUP BY a.au_id, title.title_id

SELECT AUTHOR_ID, ADVANCE + Sales_Royalty
FROM authors.sales_test;


# Challenge 3
SELECT AUTHOR_ID, Agg_Royalties + Agg_Advance AS Profits
FROM (
    SELECT AUTHOR_ID, TITLE_ID, Sales_Royalty as 'Agg_Royalties', ADVANCE as 'Agg_Advance'
    FROM (
        SELECT a.au_id AS 'AUTHOR_ID', title.title_id AS 'TITLE_ID',
            SUM(title.advance * ta.royaltyper / 100) AS 'ADVANCE',
            SUM(title.price * s.qty * title.royalty / 100 * ta.royaltyper / 100) AS 'Sales_Royalty'
        FROM authors a
            INNER JOIN titleauthor ta ON a.au_id = ta.au_id 
            INNER JOIN titles title ON ta.title_id = title.title_id
            INNER JOIN sales s ON ta.title_id = s.title_id
        GROUP BY a.au_id, title.title_id 
) summary) total
ORDER BY Profits Desc
LIMIT 3

CREATE TABLE most_prifiting_authors
SELECT AUTHOR_ID, ADVANCE + Sales_Royalty
FROM authors.sales_test
ORDER BY Profits Desc
Limit 3