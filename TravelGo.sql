create database travel_on_the_go;
use  travel_on_the_go;

create table passenger( ID int   primary key auto_increment,
  Passenger_name varchar(10) ,
  Category               varchar(10),
   Gender                 varchar(1),
   Boarding_City      varchar(20),
   Destination_City   varchar(20),
  Distance                int,
  Bus_Type             varchar(10)
);

create table price( Bus_Type   varchar(10),
             Distance      int,
              Price       int
);

insert into passenger values(1,'Sejal','AC', 'F','Bengaluru','Chennai',350,'Sleeper');
insert into passenger values(2,'Anmol','Non-AC', 'M',	'Mumbai','Hyderabad',700,'Sitting');
insert into passenger values(3,'Pallavi','AC','F','Panaji','Bengaluru',600,'Sleeper');
insert into passenger values(4,'Khusboo','AC','F','Chennai','Mumbai',1500,'Sleeper');
insert into passenger values(5,'Udit','Non-AC','M','Trivandrum','panaji',1000,'Sleeper');
insert into passenger values(6,'Ankur','AC','M','Nagpur','Hyderabad',500,'Sitting');
insert into passenger values(7,'Hemant','Non-AC','M','panaji','Mumbai',700,'Sleeper');
insert into passenger values(8,'Manish','Non-AC','M','Hyderabad','Bengaluru',500,'Sitting');
insert into passenger values(9,'Piyush','AC','M','Pune','Nagpur',700,'Sitting');

insert into PRICE values('Sleeper',350,770);
insert into PRICE values('Sleeper',500,1100);
insert into PRICE values('Sleeper',600,1320);
insert into PRICE values('Sleeper',700,1540);
insert into PRICE values('Sleeper',1000,2200);
insert into PRICE values('Sleeper',1200,2640);
insert into PRICE values('Sleeper',1500,2700);
insert into PRICE values('Sitting',500,620);
insert into PRICE values('Sitting',600,744);
insert into PRICE values('Sitting',700,868);
insert into PRICE values('Sitting',1000,1240);
insert into PRICE values('Sitting',1200,1488);
insert into PRICE values('Sitting',1500,1860);

/*
3)	How many females and how many male passengers travelled for a minimum distance of 600 KMs?
*/
select gender,count(gender) as Count from passenger where distance >=600 group by gender;

/*
4)	Find the minimum ticket price for Sleeper Bus.
*/
select min(Price) as Min_Price from price where Bus_Type='Sleeper';

/*
5)	Select passenger names whose names start with character 'S' 
*/
select Passenger_name from passenger where Passenger_name like'S%';

/*
6)	Calculate price charged for each passenger displaying Passenger name, 
Boarding City, Destination City, Bus_Type, Price in the output
*/

select a.Passenger_name,a.Boarding_City,a.Destination_City,a.Bus_Type,b.Price from passenger a,price b 
where (a.Bus_Type=b.Bus_Type and a.Distance=b.Distance);

/*
7)	What are the passenger name/s and his/her ticket price 
who travelled in the Sitting bus  for a distance of 1000 KM s 
*/
select a.Passenger_name,b.Price from passenger a,price b where (a.Bus_Type="Sitting" and b.Bus_Type="Sitting"
and a.Distance=1000 and b.Distance=1000);

/*
8)	What will be the Sitting and Sleeper bus charge for Pallavi to travel from Bangalore to Panaji?
*/
select Price from price where distance=(
select distance from passenger where(Boarding_City='Bengaluru' and Destination_City='Panaji') or 
(Destination_City='Panaji' and Boarding_City='Bengaluru'));

/*
9)List the distances from the "Passenger" table which are unique (non-repeated distances) in descending order.
*/

/*
10)	Display the passenger name and percentage of distance travelled by that passenger from 
the total distance travelled by all passengers without using user variables 
*/
select Passenger_name,(distance/(select sum(distance) from passenger))*100 as percentage_travel from passenger;

/*
11)	Display the distance, price in three categories in table Price
a)	Expensive if the cost is more than 1000
b)	Average Cost if the cost is less than 1000 and greater than 500
c)	Cheap otherwise
*/

select Bus_Type,distance,Price,
case
when Price>1000 then 'Expensive'
when 500<Price<1000  then 'Average'
else 'Cheap'
end as Cost from price;
