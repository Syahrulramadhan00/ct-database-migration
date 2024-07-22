-- migrate:up
SET TIME ZONE 'Asia/Jakarta';
create table users (
  id integer not null primary key generated always as identity,
  name varchar(255),
  email varchar(255) not null,
  password varchar(255),
  is_verified BOOLEAN DEFAULT FALSE,
  otp_code varchar(5),
  created_at TIMESTAMP WITH TIME ZONE,
  updated_at TIMESTAMP WITH TIME ZONE
);

-- migrate:down
DROP TABLE IF EXISTS users;
