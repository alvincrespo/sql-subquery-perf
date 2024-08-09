-- Drop database
DROP DATABASE IF EXISTS library_join;

-- Create the database
CREATE DATABASE library_join;

-- Select the database
USE library_join;

-- Create authors table
CREATE TABLE authors (
  author_id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  birthdate DATE,
  nationality VARCHAR(100)
);

-- Create books table
CREATE TABLE books (
  book_id INT AUTO_INCREMENT PRIMARY KEY,
  title VARCHAR(200) NOT NULL,
  publication_year INT,
  genre VARCHAR(50),
  author_id INT,
  FOREIGN KEY (author_id) REFERENCES authors(author_id)
);

CREATE INDEX idx_author_id_books ON books(author_id);

CREATE INDEX idx_author_id_authors ON authors(author_id);

CREATE INDEX idx_nationality_authors ON authors(nationality);

ANALYZE TABLE authors;

ANALYZE TABLE books;

-- Create stored procedure for subquery query
DROP PROCEDURE IF EXISTS measure_subquery_query_performance;

DELIMITER $$

CREATE PROCEDURE measure_subquery_query_performance()
BEGIN
  DECLARE start_time BIGINT;
  DECLARE end_time BIGINT;
  DECLARE total_time BIGINT DEFAULT 0;
  DECLARE run_count INT DEFAULT 5;
  DECLARE i INT DEFAULT 0;

  WHILE i < run_count DO
  SET
    start_time = (
      SELECT
        UNIX_TIMESTAMP(NOW(3)) * 1000
    );

  -- Start time in milliseconds
  -- Your query goes here
  SELECT
    *
  FROM
    books
  WHERE
    author_id NOT IN(
      SELECT
        author_id
      FROM
        authors
      WHERE
        nationality != "Georgia"
    );

  SET
    end_time = (
      SELECT
        UNIX_TIMESTAMP(NOW(3)) * 1000
    );

  -- End time in milliseconds
  SET
    total_time = total_time + (end_time - start_time);

  -- Accumulate time
  SET
    i = i + 1;

  END WHILE;

  SELECT
    total_time / run_count AS average_execution_time_ms;

-- Average execution time in milliseconds
END $$ -- Create stored procedure for inner join query

DELIMITER ;

DROP PROCEDURE IF EXISTS measure_join_query_performance;

DELIMITER $$

CREATE PROCEDURE measure_join_query_performance()
BEGIN
  DECLARE start_time BIGINT;
  DECLARE end_time BIGINT;
  DECLARE total_time BIGINT DEFAULT 0;
  DECLARE run_count INT DEFAULT 5;
  DECLARE i INT DEFAULT 0;

  WHILE i < run_count DO
  SET
    start_time = (
      SELECT
        UNIX_TIMESTAMP(NOW(3)) * 1000
    );

  -- Start time in milliseconds
  -- Your query goes here
  SELECT
    books.*
  FROM
    books
    LEFT JOIN (
      SELECT
        author_id
      FROM
        authors
      WHERE
        nationality != 'Georgia'
    ) AS filtered_authors ON books.author_id = filtered_authors.author_id
  WHERE
    filtered_authors.author_id IS NULL;

  SET
    end_time = (
      SELECT
        UNIX_TIMESTAMP(NOW(3)) * 1000
    );

  -- End time in milliseconds
  SET
    total_time = total_time + (end_time - start_time);

  -- Accumulate time
  SET
    i = i + 1;

  END WHILE;

  SELECT
    total_time / run_count AS average_execution_time_ms;

-- Average execution time in milliseconds
END $$ -- Create stored procedure for exists query

DELIMITER ;

DROP PROCEDURE IF EXISTS measure_exists_query_performance;

DELIMITER $$

CREATE PROCEDURE measure_exists_query_performance()
BEGIN
  DECLARE start_time BIGINT;
  DECLARE end_time BIGINT;
  DECLARE total_time BIGINT DEFAULT 0;
  DECLARE run_count INT DEFAULT 5;
  DECLARE i INT DEFAULT 0;

  WHILE i < run_count DO
  SET
    start_time = (
      SELECT
        UNIX_TIMESTAMP(NOW(3)) * 1000
    );

  -- Start time in milliseconds
  -- Your query goes here
  SELECT
    *
  FROM
    books
  WHERE
    NOT EXISTS (
      SELECT
        1
      FROM
        authors
      WHERE
        authors.author_id = books.author_id
        AND authors.nationality != 'Georgia'
    );

  SET
    end_time = (
      SELECT
        UNIX_TIMESTAMP(NOW(3)) * 1000
    );

  -- End time in milliseconds
  SET
    total_time = total_time + (end_time - start_time);

  -- Accumulate time
  SET
    i = i + 1;

  END WHILE;

  SELECT
    total_time / run_count AS average_execution_time_ms;

-- Average execution time in milliseconds
END $$ -- Reset Delimiter

DELIMITER ;
