-- migrate:up
create table delivery_products (
  id integer not null primary key generated always as identity,
  delivery_id integer not null,
  sales_id integer not null,
  quantity integer not null,
  created_at TIMESTAMP WITH TIME ZONE,
  FOREIGN KEY (delivery_id) REFERENCES delivery_orders(id) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (sales_id) REFERENCES sales(id) ON DELETE CASCADE ON UPDATE CASCADE
)

-- migrate:down
DROP TABLE IF EXISTS delivery_orders;
