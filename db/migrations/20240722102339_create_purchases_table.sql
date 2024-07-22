-- migrate:up
create table purchases (
  id integer not null primary key generated always as identity,
  product_id integer NOT NULL,
  image_path varchar(255),
  count integer DEFAULT 0,
  price integer DEFAULT 0,
  created_at TIMESTAMP WITH TIME ZONE,
  is_paid BOOLEAN DEFAULT FALSE,
  FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE ON UPDATE CASCADE
);

-- migrate:down
DROP TABLE IF EXISTS purchases;