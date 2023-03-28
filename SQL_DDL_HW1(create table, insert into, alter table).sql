---1)Создать таблицу employees
---id. serial,  primary key,
--- employee_name. Varchar(50), not null

create table employees(
id serial primary key,
employee_name varchar(50) not null
);

---2)Наполнить таблицу employee 70 строками

insert into employees(employee_name)
values ('Аксиленкоа'),
('Аладжалова'),
('Анцуткин'),
('Бадонин'),
('Бажев'),
('Барханова'),
('Бахрамеловский'),
('Бедунков'),
('Бересенев'),
('Бондешова'),
('Брицева'),
('Бумаков'),
('Бычихина'),
('Веженсков'),
('Вестфальский'),
('Галстухов'),
('Горбилева'),
('Данильев'),
('Джерикина'),
('Домникова'),
('Емесеева'),
('Желватикова'),
('Захазкин'),
('Катилина'),
('Катюргина'),
('Каюкова'),
('Киляшова'),
('Кифарук'),
('Козутова'),
('Кривунова'),
('Куржин'),
('Курилко'),
('Кучукбаева'),
('Манышина'),
('Матвейчев'),
('Мерлинский'),
('Миссаржевская'),
('Моликова'),
('Мощанов'),
('Мпушкина'),
('Мровинская'),
('Нахшина'),
('Неффер'),
('Обольская'),
('Овар'),
('Овчиникова'),
('Петишова'),
('Пичерский'),
('Побеглов'),
('Повольянов'),
('Прикладова'),
('Рацылин'),
('Ротков'),
('Руцкой'),
('Сайкина'),
('Салишева'),
('Сельдешов'),
('Синновский'),
('Сковикова'),
('Солоненко'),
('Супранова'),
('Тернаков'),
('Тешечко'),
('Токовищева'),
('Турунова'),
('Укарикова'),
('Хизавец'),
('Шабалина'),
('Шабалова'),
('Шахотько');


---3)Создать таблицу salary
--- id. Serial  primary key,
--- monthly_salary. Int, not null

create table salary2(
id serial primary key,
monthly_salary int not null
);

---4)Наполнить таблицу salary 15 строками

insert into salary2(monthly_salary)
values (1000),
       (1100),
       (1200),
       (1300),
       (1400),
       (1500),
       (1600),
       (1700),
       (1800),
       (1900),
       (2000),
       (2100),
       (2200),
       (2300),
       (2400),
       (2500);
      
---5)Создать таблицу employee_salary
--- id. Serial  primary key,
--- employee_id. Int, not null, unique
--- salary_id. Int, not null
      
create table employee_salary2(
id serial primary key,
employee_id int unique not null,
salary_id int not null
);

---6)Наполнить таблицу employee_salary 40 строками:
--- в 10 строк из 40 вставить несуществующие employee_id

insert into employee_salary2(employee_id,salary_id)
values
(3,7),
(1,4),
(5,9),
(40,13),
(23,4),
(11,2),
(52,10),
(15,13),
(26,4),
(16,1),
(33,7),
(2,14),
(6,8),
(4,16),
(7,15),
(8,6),
(9,1),
(10,7),
(13,2),
(17,10),
(14,14),
(12,6),
(18,8),
(56,11),
(45,1),
(21,3),
(20,3),
(19,12),
(29,15),
(41,13),
(71,12),
(72,7),
(73,3),
(74,7),
(75,4),
(76,11),
(77,13),
(78,14),
(79,8),
(80,15);

---7)Создать таблицу roles
--- id. Serial  primary key,
--- role_name. int, not null, unique

create table roles2(
id serial primary key,
role_name int unique not null);

---8)Поменять тип столбца role_name с int на varchar(30)

alter table roles2
alter column role_name type varchar(30);

---9)Наполнить таблицу roles 20 строками

insert into roles2(role_name)
values ('Junior Python developer'),
('Middle Python developer'),
('Senior Python developer'),
('Junior Java developer'),
('Middle Java developer'),
('Senior Java developer'),
('Junior JavaScript developer'),
('Middle JavaScript developer'),
('Senior JavaScript developer'),
('Junior Manual QA engineer'),
('Middle Manual QA engineer'),
('Senior Manual QA engineer'),
('Project Manager'),
('Designer'),
('HR'),
('CEO'),
('Sales manager'),
('Junior Automation QA engineer'),
('Middle Automation QA engineer'),
('Senior Automation QA engineer');

---10)Создать таблицу roles_employee
--- id. Serial  primary key,
--- employee_id. Int, not null, unique (внешний ключ для таблицы employees, поле id)
--- role_id. Int, not null (внешний ключ для таблицы roles, поле id)

create table roles_employee(
id serial primary key,
employee_id int unique not null,
role_id int not null,
    foreign key(employee_id)
      references employees(id),
    foreign key(role_id)
      references roles2(id)
);
drop table roles_employee;

---11)Наполнить таблицу roles_employee 40 строками

insert into roles_employee(employee_id,role_id)
values (7,2),
(20,4),
(3,9),
(5,13),
(23,4),
(11,2),
(10,9),
(22,13),
(21,3),
(34,4),
(6,7),
(1,8),
(2,4),
(4,6),
(8,10),
(9,6),
(12,9),
(13,10),
(14,2),
(15,9),
(17,12),
(18,4),
(19,14),
(68,5),
(24,17),
(40,7),
(41,14),
(45,9),
(52,20),
(56,17),
(48,19),
(29,6),
(30,5),
(31,16),
(35,11),
(38,4),
(36,20),
(37,19),
(39,8),
(44,5);


select * from employees;
select * from salary2;
select * from employee_salary2;
select * from roles2;
select * from roles_employee;



