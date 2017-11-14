DROP TABLE IF EXISTS bounties;

CREATE TABLE bounties (
  id SERIAL8 PRIMARY KEY,
  name VARCHAR(255),
  species VARCHAR(255),
  value INT2,
  location VARCHAR(255)
);
