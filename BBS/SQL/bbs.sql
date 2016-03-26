create database bbs;
use bbs;

create table article
(
id int primary key auto_increment,
pid int,
rootid int,
title varchar(255),
cont text,
pdate datetime,
isleaf int
);

insert into article values (null, 0, 1, 'Ant fight elephent', 'Ant fight elephent', now(), 1);
insert into article values (null, 1, 1, 'Elephent is defeated', 'Elephent is defeated', now(), 1);
insert into article values (null, 2, 1, 'Ant also pay a lot of price', 'Ant also pay a lot of price', now(), 0);
insert into article values (null, 2, 1, 'Nonsense', 'Nonsense', now(), 1);
insert into article values (null, 4, 1, 'Not Nonsense', 'Not Nonsense', now(), 0);
insert into article values (null, 1, 1, 'How could that possible', 'How could that possible', now(), 1);
insert into article values (null, 6, 1, 'How could that impossible', 'How could that impossible', now(), 0);
insert into article values (null, 6, 1, 'The possibility is very high', 'The possibility is very high', now(), 0);
insert into article values (null, 2, 1, 'Elephent is in hospital', 'Elephent is in hospital', now(), 1);
insert into article values (null, 9, 1, 'Ant is nurse','Ant is nurse', now(), 0);
