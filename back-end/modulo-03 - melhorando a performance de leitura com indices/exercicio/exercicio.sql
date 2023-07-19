create table cliente(id SERIAL, name TEXT);

insert into cliente (name) select 'joao' from generate_series(1, 2500000);

explain analyze select * from cliente where id = 2;

create index idx_cliente on cliente (id);

explain analyze select * from cliente where id = 2;