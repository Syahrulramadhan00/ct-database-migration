  -- migrate:up
  create table receipt_invoices (
    id integer not null primary key generated always as identity,
    receipt_id integer not null,
    invoice_id integer not null,
    FOREIGN KEY (receipt_id) REFERENCES receipts(id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (invoice_id) REFERENCES invoices(id) ON DELETE CASCADE ON UPDATE CASCADE
  );

  -- migrate:down
  DROP TABLE IF EXISTS receipt_invoices;
