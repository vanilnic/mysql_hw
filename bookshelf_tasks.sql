-- 1. Найти автора с самым большим числом книг и вывести его имя
SELECT authors.name
from authors_books
JOIN authors ON authors.id = authors_books.authors_id
GROUP BY authors_id
ORDER BY COUNT(authors_books.books_id) DESC
LIMIT 1
; 
-- 2. Вывести пять самых старых книг у которых указан год издания
SELECT title, year
from books
WHERE year IS NOT NULL
ORDER BY year ASC
LIMIT 5
;
-- 3. Вывести общее количество книг на полке в кабинете
SELECT COUNT(books.id)
from books
JOIN shelves ON books.shelves_id = shelves.id
WHERE shelves.title = 'Полка в кабинете'
;
-- 4. Вывести названия, имена авторов и годы издания книг, которые находятся на полке в спальне
SELECT books.title, authors.name, books.year
from books
JOIN authors_books ON books.id = authors_books.books_id
JOIN authors ON authors_books.authors_id = authors.id
JOIN shelves ON books.shelves_id = shelves.id
WHERE shelves.title = 'Полка в спальне'  
;
-- 5. Вывести названия и годы издания книг, написанных автором 'Лев Толстой'
SELECT books.title, books.year
from books
JOIN authors_books ON books.id = authors_books.books_id
JOIN authors ON authors_books.authors_id = authors.id
WHERE authors.name = 'Лев Толстой'
;
-- 6. Вывести название книг, которые написали авторы, чьи имена начинаются на букву "А"
SELECT books.title, authors.name
from books
JOIN authors_books ON books.id = authors_books.books_id
JOIN authors ON authors_books.authors_id = authors.id
WHERE authors.name LIKE 'А%'
;
-- 7. Вывести название книг и имена авторов для книг, которые находятся на полках, названия которых включают слова «верхняя» или «нижняя»
SELECT books.title, authors.name
from books
JOIN authors_books ON books.id = authors_books.books_id
JOIN authors ON authors_books.authors_id = authors.id
JOIN shelves ON books.shelves_id = shelves.id
WHERE shelves.title LIKE '%нижняя%' OR shelves.title LIKE '%верхняя%'
;
-- 8. Книгу «Божественная комедия» автора «Данте Алигьери» одолжили почитать другу Ивану Иванову, необходимо написать один или несколько запросов которые отразят это событие в БД
UPDATE books
JOIN authors_books ON authors_books.books_id = books.id
JOIN authors ON authors_books.authors_id = authors.id
SET books.friends_id = (SELECT friends.id FROM friends WHERE friends.name = 'Иванов Иван')
WHERE authors.name = 'Данте Алигьери' AND books.title = 'Божественная комедия'
AND books.id > 0;
-- 9. Добавить в базу книгу «Краткие ответы на большие вопросы», год издания 2020, автор «Стивен Хокинг», положить ее на полку в кабинете
INSERT INTO books (books.title, books.year, books.shelves_id)
VALUES ('Краткие ответы на большие вопросы', '2020', (SELECT id FROM shelves WHERE title = 'Полка в кабинете'))
;
INSERT INTO authors (authors.name)
VALUES ('Стивен Хокинг')
;
INSERT INTO authors_books (authors_books.books_id, authors_books.authors_id)
VALUES (176, 145);