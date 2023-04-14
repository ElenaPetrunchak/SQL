---1)Вывести название, жанр и цену тех книг, количество которых больше 8, в отсортированном по убыванию цены виде.

select title, name_genre, price
from book inner join genre
 on book.genre_id = genre.genre_id
 where amount > 8
 order by price desc;
 
---2)Вывести все жанры, которые не представлены в книгах на складе.

select name_genre
from genre left join book
on book.genre_id = genre.genre_id
where book.title is null;

---3)Необходимо в каждом городе провести выставку книг каждого автора в течение 2020 года. Дату проведения выставки выбрать случайным образом. Создать запрос, который выведет город, автора и дату проведения выставки. 
---Последний столбец назвать Дата. Информацию вывести, отсортировав сначала в алфавитном порядке по названиям городов, а потом по убыванию дат проведения выставок.

select name_city, name_author, (DATE_ADD('2020-01-01', INTERVAL FLOOR(RAND() * 365) DAY)) as Дата
from city cross join author
order by name_city, Дата desc;

---4)Вывести информацию о книгах (жанр, книга, автор), относящихся к жанру, включающему слово «роман» в отсортированном по названиям книг виде.

select name_genre, title, name_author
from author
     inner join book on book.author_id = author.author_id
     inner join genre on book.genre_id = genre.genre_id
where name_genre like '%роман%'
order by title;

---5)Посчитать количество экземпляров  книг каждого автора из таблицы author.  Вывести тех авторов,  количество книг которых меньше 10, в отсортированном по возрастанию количества виде. Последний столбец назвать Количество.

select name_author, sum(amount) as Количество
from 
   author left join book
   on author.author_id = book.author_id
group by name_author
having sum(amount) < 10 OR SUM(amount) IS NULL
order by Количество;

---6)Вывести в алфавитном порядке всех авторов, которые пишут только в одном жанре.

select name_author
from author 
left join book on author.author_id = book.author_id
group by name_author
HAVING COUNT(DISTINCT(genre_id))=1;

---7)Вывести все заказы Баранова Павла (id заказа, какие книги, по какой цене и в каком количестве он заказал) в отсортированном по номеру заказа и названиям книг виде.

select buy.buy_id, book.title, book.price, buy_book.amount
from client
       inner join buy on client.client_id = buy.client_id
       inner join buy_book on buy.buy_id = buy_book.buy_id
       inner join book on book.book_id = buy_book.book_id
where name_client like '%Баранов Павел%'        
order by buy.buy_id,  book.title;      


---8)Посчитать, сколько раз была заказана каждая книга, для книги вывести ее автора (нужно посчитать, в каком количестве заказов фигурирует каждая книга).  
---Вывести фамилию и инициалы автора, название книги, последний столбец назвать Количество. Результат отсортировать сначала  по фамилиям авторов, а потом по названиям книг.

select author.name_author, book.title, count(buy_book.amount) as Количество
from author 
    inner join book on author.author_id = book.author_id 
    left join buy_book on book.book_id = buy_book.book_id
group by book.title, author.name_author    
order by author.name_author, book.title;  

---9)Вывести города, в которых живут клиенты, оформлявшие заказы в интернет-магазине. Указать количество заказов в каждый город, этот столбец назвать Количество. 
---Информацию вывести по убыванию количества заказов, а затем в алфавитном порядке по названию городов.

select city.name_city, count(buy.buy_id) as Количество
from city
   inner join client on city.city_id = client.city_id
   inner join buy on client.client_id = buy.client_id
group by name_city
order by Количество DESC, name_city; 

---10)Вывести номера всех оплаченных заказов и даты, когда они были оплачены.

select buy_step.buy_id, buy_step.date_step_end
from step
       inner join buy_step on step.step_id = buy_step.step_id
where buy_step.date_step_end is not null and step.name_step like '%Оплата%';

---11)Вывести информацию о каждом заказе: его номер, кто его сформировал (фамилия пользователя) и его стоимость (сумма произведений количества заказанных книг и их цены), в отсортированном по номеру заказа виде. Последний столбец назвать Стоимость

select buy.buy_id, client.name_client, sum(buy_book.amount * book.price) as Стоимость
from client 
    inner join buy on client.client_id = buy.client_id
    inner join buy_book on buy.buy_id = buy_book.buy_id
    inner join book on buy_book.book_id = book.book_id
group by buy.buy_id, client.name_client
order by buy.buy_id;

---12)Вывести номера заказов (buy_id) и названия этапов, на которых они в данный момент находятся. Если заказ доставлен –  информацию о нем не выводить. Информацию отсортировать по возрастанию buy_id.

select buy_step.buy_id, step.name_step
from buy_step
     inner join step on buy_step.step_id = step.step_id
where buy_step.date_step_end is null and buy_step.date_step_beg is not null
order by buy_step.buy_id;

---13)В таблице city для каждого города указано количество дней, за которые заказ может быть доставлен в этот город (рассматривается только этап "Транспортировка"). 
---Для тех заказов, которые прошли этап транспортировки, вывести количество дней за которое заказ реально доставлен в город. А также, если заказ доставлен с опозданием, указать количество дней задержки, в противном случае вывести 0. 
---В результат включить номер заказа (buy_id), а также вычисляемые столбцы Количество_дней и Опоздание. Информацию вывести в отсортированном по номеру заказа виде.

select buy.buy_id, datediff(date_step_end,date_step_beg) as Количество_дней, if(datediff(date_step_end,date_step_beg) > city.days_delivery, datediff(date_step_end,date_step_beg) - city.days_delivery,0) as Опоздание
from city
     inner join client on city.city_id = client.city_id
     inner join buy on client.client_id = buy.client_id
     inner join buy_step on buy.buy_id = buy_step.buy_id
     inner join step on step.step_id = buy_step.step_id 
where name_step like '%Транспортировка%' and date_step_end is not null
order by buy.buy_id;

---14)Выбрать всех клиентов, которые заказывали книги Достоевского, информацию вывести в отсортированном по алфавиту виде. В решении используйте фамилию автора, а не его id.

select distinct name_client
from client
     inner join buy on client.client_id = buy.client_id
     inner join buy_book on buy.buy_id = buy_book.buy_id
     inner join book on book.book_id = buy_book.book_id
     inner join author on book.author_id = author.author_id
where name_author like '%Достоевский%'
order by name_client;

