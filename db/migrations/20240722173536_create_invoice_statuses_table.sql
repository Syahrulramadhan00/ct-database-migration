-- migrate:up
create table invoice_statuses (
  id integer not null primary key generated always as identity,
  name varchar(255) not null
);

INSERT INTO invoice_statuses (name) VALUES ('finalized');
INSERT INTO invoice_statuses (name) VALUES ('sended');
INSERT INTO invoice_statuses (name) VALUES ('preorder_created');
INSERT INTO invoice_statuses (name) VALUES ('faktur_created');
INSERT INTO invoice_statuses (name) VALUES ('inserted_into_receipt');
INSERT INTO invoice_statuses (name) VALUES ('paid');
INSERT INTO invoice_statuses (name) VALUES ('done');

-- migrate:down
DROP TABLE IF EXISTS invoice_statuses;
