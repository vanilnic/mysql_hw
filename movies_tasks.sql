-- 1. Вывести сколько фильмов сняла кинокомпания Universal Pictures
SELECT COUNT(movies.title) FROM movies
JOIN companies ON movies.companies_id = companies.id
WHERE companies.title = 'Universal Pictures'
;
-- 2. Вывести сколько всего фильмов было снято режиссером Фрэнсисом Фордом Копполой
SELECT COUNT(movies.title) FROM movies
JOIN directors ON movies.directors_id = directors.id
WHERE full_name = 'Фрэнсис Форд Коппола'
;
-- 3. Вывести количество снятых фильмов за последние 20 лет
SELECT COUNT(*) FROM movies
WHERE year BETWEEN (YEAR(CURDATE()) - 20) AND YEAR(CURDATE())
;
-- 4. Вывести все жанры фильмов в которых снимал Стивен Спилберг в течении всей своей карьеры
SELECT DISTINCT genres.title FROM genres
JOIN movies ON genres.id = movies.genres_id
JOIN directors ON movies.directors_id = directors.id
WHERE full_name = 'Стивен Спилберг'
;
-- 5. Вывести названия, жанры и режиссеров 5 самых дорогих фильмов
SELECT movies.title, genres.title, directors.full_name FROM movies
JOIN genres ON genres.id = movies.genres_id
JOIN directors ON movies.directors_id = directors.id
ORDER BY movies.budget DESC
LIMIT 5
;
-- 6. Вывести имя режиссера с самым большим количеством фильмов
SELECT directors.full_name FROM directors
JOIN movies ON directors.id = movies.directors_id
GROUP BY directors.full_name
ORDER BY COUNT(movies.title) DESC
LIMIT 1
;
-- 7. Вывести названия и жанры фильмов, снятые самой большой кинокомпанией (по сумме всех бюджетов фильмов)
SELECT movies.title, genres.title FROM movies
JOIN genres ON genres.id = movies.genres_id
WHERE companies_id = ( 
	SELECT companies.id FROM companies
    JOIN movies ON movies.companies_id = companies.id
    GROUP BY companies.id
    ORDER BY SUM(movies.budget) DESC
    LIMIT 1
)
;
-- 8. Вывести средний бюджет фильмов, снятых кинокомпанией Warner Bros.
SELECT AVG(movies.budget) FROM movies
JOIN companies ON movies.companies_id = companies.id
WHERE companies.title = 'Warner Bros.'
;
-- 9. Вывести количество фильмов каждого жанра и средний бюджет по жанру
SELECT genres.title, COUNT(movies.title), AVG(movies.budget) FROM movies
JOIN genres ON genres.id = movies.genres_id
GROUP BY genres.title
;
-- 10. Найти и удалить комедию "Дикие истории" 2014-го года
DELETE movies FROM movies
JOIN genres ON genres.id = movies.genres_id
WHERE genres.title = 'комедия' AND movies.title = 'Дикие истории' AND movies.year = 2014
;