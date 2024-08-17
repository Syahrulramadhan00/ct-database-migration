-- migrate:up
create table receipts (
  id integer not null primary key generated always as identity,
  number integer not null,
  photo varchar(255),
  created_at TIMESTAMP WITH TIME ZONE,
  client_id integer not null,
  status integer not null,
    FOREIGN KEY (client_id) REFERENCES clients(id) ON DELETE CASCADE ON UPDATE CASCADE
);

-- migrate:down
DROP TABLE IF EXISTS receipts;
