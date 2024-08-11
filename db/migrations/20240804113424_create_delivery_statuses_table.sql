-- migrate:up
create table delivery_statuses (
  id integer not null primary key generated always as identity,
  name varchar(255) not null
);

INSERT INTO delivery_statuses (name) VALUES ('initialized');
INSERT INTO delivery_statuses (name) VALUES ('processed');
INSERT INTO delivery_statuses (name) VALUES ('done');

-- migrate:down
DROP TABLE IF EXISTS delivery_statuses;
