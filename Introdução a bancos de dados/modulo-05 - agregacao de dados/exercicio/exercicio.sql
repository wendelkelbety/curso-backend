CREATE TABLE product(product_id serial NOT NULL, product_name varchar(25) NOT NULL, created_date timestamp NOT NULL DEFAULT now(), CONSTRAINT product_key PRIMARY KEY (product_id));

'na criação da tabela de produto estava o campo "name", então o alterei para ficar padronizado e mais intuitivo ficando assim "product_name"'

CREATE TABLE stock(id serial NOT NULL, product_id int NOT NULL, quantity int NOT NULL, CONSTRAINT stock_key PRIMARY KEY (id));

'insert produto'
INSERT INTO product (product_name) VALUES ('celular');
INSERT INTO product (product_name) VALUES ('livro');
INSERT INTO product (product_name) VALUES ('tablet');
INSERT INTO product (product_name) VALUES ('notebook');
INSERT INTO product (product_name) VALUES ('roteador');
'insert estoque'
INSERT INTO stock (product_id, quantity) VALUES (1, 5);
INSERT INTO stock (product_id, quantity) VALUES (2, 3);
INSERT INTO stock (product_id, quantity) VALUES (3, 0);
INSERT INTO stock (product_id, quantity) VALUES (4, 1);
INSERT INTO stock (product_id, quantity) VALUES (5, 0);

SELECT product_name, stock.quantity product FROM product INNER JOIN stock USING (product_id) GROUP BY product_name, stock.quantity ORDER BY stock.quantity;

'soma individual de cada item'
SELECT product_id, SUM(quantity) FROM stock GROUP BY product_id;

'soma total de todos os itens'
SELECT SUM(quantity) FROM stock;