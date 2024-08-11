-- migrate:up
create table sales (
  id integer not null primary key generated always as identity,
  invoice_id integer not null,
  product_id integer not null,
  quantity integer not null,
  price integer not null,
  not_sent_count integer DEFAULT 0,
  send_status BOOLEAN DEFAULT FALSE,
  created_at TIMESTAMP WITH TIME ZONE,
  FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (invoice_id) REFERENCES invoices(id) ON DELETE CASCADE ON UPDATE CASCADE
);

-- migrate:down
DROP TABLE IF EXISTS sales;

