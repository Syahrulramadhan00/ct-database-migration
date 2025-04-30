-- migrate:up
create table suppliers (
    id integer not null primary key generated always as identity,
    name varchar(255),
    company varchar(255),
    address varchar(255),
    telephone varchar (255)
    );

-- migrate:down
DROP TABLE IF EXISTS suppliers;