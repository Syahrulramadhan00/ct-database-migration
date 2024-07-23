-- migrate:up
create table invoices (
  id integer not null primary key generated always as identity,
  invoice_status_id integer not null DEFAULT 1,
  client_id integer not null,
  invoice_code varchar(255) not null,
  description varchar(255),
  payment_method varchar(255),
  po_code varchar(255),
  seller varchar(255),
  platform_number varchar(255),
  platform varchar(255),
  platform_description varchar(255),
  tax integer,
  discount integer,
  deadline TIMESTAMP WITH TIME ZONE,
  note varchar(255),
  facture_path varchar(255),
  is_taxable BOOLEAN DEFAULT FALSE,
  po_path varchar(255),
  created_at TIMESTAMP WITH TIME ZONE,
  updated_at TIMESTAMP WITH TIME ZONE,
  FOREIGN KEY (invoice_status_id) REFERENCES invoice_statuses(id) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (client_id) REFERENCES clients(id) ON DELETE CASCADE ON UPDATE CASCADE
);

-- migrate:down
DROP TABLE IF EXISTS invoices;

