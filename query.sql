CREATE TABLE categories (
  category_id INTEGER PRIMARY KEY,
  category_name TEXT NOT NULL
);

INSERT INTO categories VALUES (1, 'Action');
INSERT INTO categories VALUES (2, 'Comedy');
INSERT INTO categories VALUES (3, 'Drama');
INSERT INTO categories VALUES (4, 'Romance');

CREATE TABLE movies (
  movie_id INTEGER PRIMARY KEY,
  movie_name TEXT NOT NULL,
  category_id INTEGER NOT NULL,
  length INTEGER NOT NULL,
  FOREIGN KEY (category_id) REFERENCES categories(category_id)
);

INSERT INTO movies VALUES (1, 'Movie A', 1, 120);
INSERT INTO movies VALUES (2, 'Movie B', 1, 150);
INSERT INTO movies VALUES (3, 'Movie C', 2, 90);
INSERT INTO movies VALUES (4, 'Movie D', 3, 180);
INSERT INTO movies VALUES (5, 'Movie E', 4, 120);




WITH CategoryFilmCount AS (
    SELECT
        categories.category_name AS CategoryName,
        COUNT(movies.movie_id) AS FilmCount
    FROM
        categories
    JOIN
        movies
    ON
        categories.category_id = movies.category_id
    GROUP BY
        categories.category_name
),
CategoryAverageLength AS (
    SELECT
        categories.category_name AS CategoryName,
        AVG(movies.length) AS AverageLength
    FROM
        categories
    JOIN
        movies
    ON
        categories.category_id = movies.category_id
    GROUP BY
        categories.category_name
)
SELECT
    CategoryFilmCount.CategoryName,
    CategoryFilmCount.FilmCount,
    CategoryAverageLength.AverageLength
FROM
    CategoryFilmCount
JOIN
    CategoryAverageLength
ON
    CategoryFilmCount.CategoryName = CategoryAverageLength.CategoryName
ORDER BY
    CategoryFilmCount.FilmCount DESC;
