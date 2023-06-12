-- 1. Вывести суммарное количество единиц техники на складе (не товарных позиций, а товаров!)
SELECT SUM(amount) as 'суммарное кол-во'
from hardware 
;
-- 2. Вывести какие товары на складе закончились
SELECT title as 'Закончились'
from hardware
WHERE amount = 0
;
-- 3. Вывести среднюю цену монитора
SELECT AVG(price) as 'Средняя цена мониторов'
from hardware
WHERE title LIKE 'Монитор %'
;
-- 4. Вывести все клавиатуры, при этом результаты отсортировать от самой дешевой до самой дорогой
SELECT title, price
from hardware
WHERE title LIKE 'Клавиатура %'
ORDER BY price ASC
;
-- 5. Вывести в рамках одного запроса количество товарных позиций по каждому тегу с использованием группировки, результаты отсортировать от максимального количества до минимального
SELECT tag, count(title) as 'amount'
FROM hardware 
GROUP BY tag 
ORDER BY amount DESC;
-- 6. Вывести количество товарных позиций со скидками на складе
SELECT amount 
from hardware
WHERE amount != 0 AND tag = 'discount'
;
-- 7. Вывести название и цену самой дорогой новинки
SELECT title, price
from hardware
WHERE tag = 'new'
ORDER BY price DESC
LIMIT 1
;
-- 8. Добавить в таблицу товар Ноутбук Lenovo 2BXKQ7E9XD как новинку по цене 54500 руб. в единственном экземпляре
INSERT INTO hardware 
(title, price, tag, amount) 
VALUES 
("Ноутбук Lenovo 2BXKQ7E9XD", 54500, "new", 1)
;
-- 9. Найти и удалить по названию из базы ошибочно добавленный товар Очки PS VR 2
DELETE FROM hardware
WHERE hardware.title = 'Очки PS VR 2' AND hardware.id > 0
;