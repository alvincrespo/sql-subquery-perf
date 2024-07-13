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

-- Measure performance for each query
CALL measure_subquery_query_performance();

CALL measure_join_query_performance();

CALL measure_exists_query_performance();

--- Perf Metrics
-- SUBQUERY Query: 303.6000
-- JOIN Query: 791.2000
-- EXISTS Query: 241.6000
