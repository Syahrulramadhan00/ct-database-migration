-- migrate:up
CREATE TABLE receipt_invoices (
  id INTEGER NOT NULL PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  receipt_id INTEGER NOT NULL,
  invoice_id INTEGER NOT NULL,
  FOREIGN KEY (receipt_id) REFERENCES receipts(id) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (invoice_id) REFERENCES invoices(id) ON DELETE CASCADE ON UPDATE CASCADE
);

-- migrate:down
DROP TABLE IF EXISTS receipt_invoices;