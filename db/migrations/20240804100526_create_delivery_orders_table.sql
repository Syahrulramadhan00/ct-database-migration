-- migrate:up
create table delivery_orders (
  id integer not null primary key generated always as identity,
  invoice_id integer not null,
  sender_id integer,
  order_code varchar(255),
  note varchar(255),
  place varchar(255),
  photo_path varchar(255),
  status integer not null,
  created_at TIMESTAMP WITH TIME ZONE,
  FOREIGN KEY (invoice_id) REFERENCES invoices(id) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (sender_id) REFERENCES users(id) ON DELETE CASCADE ON UPDATE CASCADE
)

-- migrate:down
DROP TABLE IF EXISTS delivery_orders;
