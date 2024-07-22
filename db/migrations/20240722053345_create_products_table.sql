-- migrate:up
create table products (
  id integer not null primary key generated always as identity,
  name varchar(255) NOT NULL,
  stock integer DEFAULT 0,
  updated_at TIMESTAMP WITH TIME ZONE,
  created_at TIMESTAMP WITH TIME ZONE,
  deleted_at TIMESTAMP WITH TIME ZONE
);

-- migrate:down
DROP TABLE IF EXISTS products;
