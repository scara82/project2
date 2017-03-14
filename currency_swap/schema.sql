CREATE TABLE users (
  id SERIAL4 PRIMARY KEY,
  email VARCHAR(400) NOT NULL,
  phone_number VARCHAR NOT NULL,
  password_digest VARCHAR(400) NOT NULL
);

CREATE TABLE posts (
  id SERIAL4 PRIMARY KEY,
  curr_from VARCHAR(100) NOT NULL,
  curr_to VARCHAR(100) NOT NULL,
  amount INTEGER NOT NULL,
  before_date DATE,
  post_code VARCHAR,
  phone_number VARCHAR NOT NULL,
  user_id INTEGER
);

CREATE TABLE users_ratings (
  id SERIAL4 PRIMARY KEY,
  email VARCHAR(400) NOT NULL,
  rating INTEGER
);
