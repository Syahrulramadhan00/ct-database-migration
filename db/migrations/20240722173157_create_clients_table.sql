-- migrate:up
create table clients (
  id integer not null primary key generated always as identity,
  name varchar(255) not null,
  place varchar(255),
  description varchar(255),
  telephone varchar(255)
);
INSERT INTO clients (name) VALUES ('Sinergi');
INSERT INTO clients (name) VALUES ('RWK');
INSERT INTO clients (name) VALUES ('ikanindo');


-- migrate:down
DROP TABLE IF EXISTS clients;
