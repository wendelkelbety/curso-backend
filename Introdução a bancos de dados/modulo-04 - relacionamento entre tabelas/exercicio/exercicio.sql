CREATE TABLE product(id serial PRIMARY KEY,name varchar(30),value float);

CREATE TABLE stock(id serial, cod_product int, name varchar(30), amount int);

INSERT INTO product (name, value) VALUES ('BISCOITO', 2.95);

INSERT INTO stock (cod_product, name, amount) VALUES (1, 'BISCOITO', 120);

ALTER TABLE stock ADD CONSTRAINT fk_relation_product FOREIGN KEY (cod_product) REFERENCES product (id);

SELECT product.name, product.value, amount FROM product INNER JOIN stock ON product.id = stock.cod_product;