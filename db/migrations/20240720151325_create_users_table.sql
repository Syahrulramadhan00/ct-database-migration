-- migrate:up
create table users (
  id integer not null primary key generated always as identity,
  name varchar(255),
  email varchar(255) not null,
  password varchar(255)
);

-- migrate:down
drop table users;
