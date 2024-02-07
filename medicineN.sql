CREATE TABLE users (
    id serial PRIMARY KEY,
    fname varchar(256) NOT NULL CHECK (fname != ''),
    lname varchar(256) NOT NULL CHECK (lname != ''),
    email varchar(300) NOT NULL UNIQUE CHECK (email != '')
);

INSERT INTO users (fname, lname, email) VALUES
('Ostap', 'Bender', 'ostap@gmail.com'),
('Adam', 'Kozlevich', 'antilope_gnu@gmail.com'),
('Shura','Balaganov', 'balaganov@gmail.com'),
('Mihail', 'Panikovski', 'panikovcki@gmail.com'),
('Zicpredsedatel', 'Funt', 'funt@gmail.com');

CREATE TABLE medicine (
     id serial PRIMARY KEY,
     title varchar(256) NOT NULL CHECK (title != ''),
     active_ingredient varchar(256) NOT NULL CHECK (active_ingredient != ''),
     dose numeric(5,2) NOT NULL CHECK (dose > 0),
     price numeric(7,2) NOT NULL CHECK (price > 0),
     CONSTRAINT "medicine_unit" UNIQUE (title, dose)
);

INSERT INTO medicine (title, active_ingredient, dose, price) VALUES
('Аспирин кардио', 'ацетилсалициловая кислота', 100, 71.84),
('Цитрамон-Дарница таблетки №6', 'ацетилсалициловая кислота, парацетамол, кофеин', 240, 23.70),
('Аспирин С таблетки шип. №10 (2х5)', 'ацетилсалициловая кислота и аскорбиновая кислота', 240, 223.20),
('Анальгин-Дарница таблетки по 500 мг №10', 'metamizole sodium', 500, 31.10),
('Нимесил гранулы д/ор. сусп. 100 мг/2 г по 2 г №30 (3х10) в пак.', 'нимесулид', 100, 613.80),
('Солпадеин актив таблетки шип. №12 (4х3) в стрип.', 'парацетамол, кофеин', 500, 225.53),
('урофен экспресс форте капсулы мягк. по 400 мг №10 в блис.', 'ибупрофен', 400, 188.93),
('Темпалгин таблетки, п/о №20 (10х2)', 'темпидон', 500, 167.40),
('Фармадол таблетки №10', 'ацетилсалициловая кислота, парацетамол, кофеин', 100, 59.85),
('Ибупрофен таблетки, п/плен. обол. по 200 мг №50 (10х5)', 'ибупрофен', 200, 58.72),
('Дексалгин таблетки, п/плен. обол. по 25 мг №10', 'декскетопрофен', 25, 210.50),
('Дексалгин инъект раствор д/ин. 50 мг/2 мл по 2 мл №5 в амп.', 'декскетопрофена трометамол', 25, 325.50),
('Еврофаст софткапс капсулы мягк. по 400 мг №20 (10х2)', 'ибупрофен', 400, 291.52),
('Фламидез таблетки, п/плен. обол. №30 (10х3)', 'парацетамол, диклофенак калия, серратиопептидаза', 500, 286.75),
('Фаниган таблетки №100 (10х10)', 'парацетамол, диклофенак натрия', 500, 671.71);

CREATE TABLE pharmacy (
    id serial PRIMARY KEY,
    title varchar(256) NOT NULL CHECK (title != ''),
    city varchar(100) NOT NULL CHECK (city != ''),
    city_area varchar(100) NOT NULL CHECK (city_area != ''),
    street varchar(100) NOT NULL CHECK (street != ''),
    home varchar(10) NOT NULL CHECK (home != ''),
    tel varchar(20) NOT NULL CHECK (tel != ''),
    CONSTRAINT "pharmacy_unit" UNIQUE (city, city_area, street, home)
);

INSERT INTO pharmacy (title, city, city_area, street, home, tel) VALUES
('Останній шлях', 'Львів', 'Франковский', 'Чупринки', '85', '45154548'),
('Роги і Копита', 'Чорноморськ', 'Одеський', 'Парковая', '1', '548545845'),
('Понтій Пілат', 'Одеса', 'Хаджибейский', 'Семена Палія', '12б', '451522151'),
('Девяте коло', 'Київ', 'Голосіївський', 'Паркова', '28', '4585215452'),
('Притон №9', 'Одеса', 'Приморський', 'Шевченка', '12', '45154544555'),
('Palermo', 'Одеса', 'Хаджибейский', 'Днепродорога', '156', '5485544745');

CREATE TABLE pharmacy_to_medicine (
    pharmacy_id int REFERENCES pharmacy(id),
    medicine_id int REFERENCES medicine(id),
    constraint "pharm_med" PRIMARY KEY (pharmacy_id, medicine_id),
    quantity int CHECK (quantity > 0)
);

INSERT INTO pharmacy_to_medicine (pharmacy_id, medicine_id, quantity)
VALUES
    (1, 1, 100),
    (1, 2, 200),
    (1, 3, 50),
    (1, 4, 55),
    (1, 7, 15),
    (1, 10, 75),
    (2, 1, 150),
    (2, 3, 41),
    (2, 4, 44),
    (2, 11, 55),
    (2, 8, 78),
    (3, 5, 55),
    (3, 10, 9),
    (3, 7, 150),
    (4, 2, 500),
    (4, 3, 500),
    (4, 4, 800),
    (4, 7, 900),
    (4, 10, 40),
    (5, 1, 60),
    (5, 11, 800),
    (5, 12, 900),
    (5, 15, 54),
    (5, 14, 45),
    (5, 13, 545),
    (6, 1, 150),
    (6, 2, 20),
    (6, 3, 30),
    (6, 4, 60);

 CREATE TABLE orders (
    id serial PRIMARY KEY,
    pharmacy_id int REFERENCES pharmacy(id),
    user_id int REFERENCES users(id),
    created_at timestamp DEFAULT current_timestamp
);


INSERT INTO orders (user_id, pharmacy_id) VALUES (1, 1);
INSERT INTO orders (user_id, pharmacy_id) VALUES (2, 3);
INSERT INTO orders (user_id, pharmacy_id) VALUES (3, 5);
INSERT INTO orders (user_id, pharmacy_id) VALUES (5, 6);
INSERT INTO orders (user_id, pharmacy_id) VALUES (1, 1);
INSERT INTO orders (user_id, pharmacy_id) VALUES (2, 1);
INSERT INTO orders (user_id, pharmacy_id) VALUES (1, 5);
INSERT INTO orders (user_id, pharmacy_id) VALUES (3, 2);
INSERT INTO orders (user_id, pharmacy_id) VALUES (2, 3);
INSERT INTO orders (user_id, pharmacy_id) VALUES (3, 6);
INSERT INTO orders (user_id, pharmacy_id) VALUES (2, 1);

CREATE TABLE orders_to_pharmacy_to_medicine (
    order_id int,
    pharmacy_id int,
    medicine_id int,
    quantity int CHECK (quantity > 0),
    FOREIGN KEY (pharmacy_id, medicine_id) 
    REFERENCES pharmacy_to_medicine(pharmacy_id, medicine_id),
    FOREIGN KEY (order_id) REFERENCES orders(id)
);


INSERT INTO orders_to_pharmacy_to_medicine (order_id, pharmacy_id, medicine_id, quantity) VALUES
(1, 1, 7, 50),
(1, 1, 2, 10),
(1, 1, 3, 6),
(2, 3, 5, 4 ),
(3, 5, 15, 5),
(2, 3, 7, 8 ),
(4, 6, 4, 8),
(5, 1, 10, 4),
(6, 1, 4, 14),
(7, 5, 11, 10),
(8, 2, 3, 11),
(9, 3, 7, 3),
(10, 6, 1, 13),
(11, 1, 10, 6);


CREATE VIEW orders_short AS (
    SELECT order_id, u.fname, quantity, m.title, p.title AS "Pharmacy Title", m.price FROM orders_to_pharmacy_to_medicine AS t
    LEFT JOIN orders AS o ON o.id = order_id
    LEFT JOIN users AS u ON o.user_id = u.id
    LEFT JOIN medicine As m ON t.medicine_id = m.id
    LEFT JOIN pharmacy AS p ON t.pharmacy_id = p.id
);

SELECT * FROM orders_short;