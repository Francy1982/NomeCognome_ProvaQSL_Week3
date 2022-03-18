create database NegozioDiMusica

--Domanda 1  B
--Domanda 2  Creerò una terza tabella (di giunzione) in cui inserirò le primary key di ogni tabella (che lì saranno le foreign key)
            -- ed eventuali campi appartenenti alla relazione tra le due.
--Domanda 3  B
--Domanda 4  B
--Domanda 5  B

create table Band(
IDBand int identity(1,1) not null primary key,
Nome varchar(30) not null,
NumeroComponenti int not null
)

create table Album(
IDAlbum int identity(1,1) not null primary key,
Titolo varchar(100) not null,
AnnoUscita int not null,
CasaDiscografica varchar(300) not null,
Genere varchar not null,
Supporto varchar not null,
IDBand int not null,
constraint CHK_Genere check(Genere = 'Classico' or Genere = 'Pop' or Genere = 'Jazz' or Genere = 'Metal' or Genere = 'Rock'),
constraint CHK_Supporto check(Supporto = 'CD' or Supporto = 'Vinile' or Supporto = 'Streaming'),
constraint UNQ_Unicita unique(Titolo,AnnoUScita,CasaDiscografica,Genere,Supporto),
constraint FK_Band foreign key(IDBand) references Band(IDBand)
)

create table Brano(
IDBrano int identity(1,1)  not null constraint PK_Brano primary Key,
Titolo varchar(100) not null,
Durata float not null,
IDBand int not null,
constraint FK_BranoBand foreign key(IDBAnd) references Band(IDBand)
)

create table BranoAlbum(
IDBrano int not null,
IDAlbum int not null,
constraint FK_Brano foreign key(IDBrano) references Brano(IDBrano),
constraint FK_ALbum foreign key(IDAlbum) references Album(IDAlbum),
constraint PK_BranoAlbum primary key(IdBrano,IDAlbum) 
)

alter table Album alter column Genere varchar(50)
alter table Album alter column Supporto varchar(50)

 
select * from Band
select * from Album
select * from Brano
select * from BranoAlbum



insert into Band values('Maneskin', 4)   
insert into Band values('883',2)
insert into Band values('The Giornalisti', 5)
insert into Band values('Beatles', 4)

insert into Album values('Maneskin 1', 2018, 'Sony Music', 'Rock','Streaming',1)  
insert into Album values('Maneskin 2', 2020, 'Sony Music', 'Rock', 'Streaming',1)
insert into Album values('Maneskin 3', 2022, 'Sony Music', 'Rock', 'Streaming',1)
insert into Album values('B 883', 1990, 'Altra casa discografica', 'Pop', 'CD',2)
insert into Album values('A 883', 1993, 'Altra casa discigrafica', 'Pop','CD',2)
insert into Album values('Beatles 1', 1970, 'Casa Inglese', 'Rock', 'Vinile',4)
insert into Album values('The giornalisti', 2001, 'Casa Italia', 'Pop', 'Vinile',3)

insert into Brano values('Imagine',3,4)
insert into Brano values('Marlena',1.5,1)
insert into Brano values('Zitti e buoni',2,1)
insert into Brano values('Gli anni',2.3,2)
insert into Brano values ('Bella Ciao',4,2)


insert into BranoAlbum values(1, 6)   
insert into BranoAlbum values(4, 5)
insert into BranoAlbum values(2, 1)
insert into BranoAlbum values(3,2)


--punto 1

select a.Titolo
from Album a join Band b on b.IDBand = a.IDBand
where b.Nome = '883'
order by a.Titolo

--punto 2
select *
from Album a 
where AnnoUscita = 2020 and CasaDiscografica = 'Sony Music'

--punto 3
select *
from Album a join BranoAlbum ba on ba.IDAlbum = a.IDAlbum 
             join Brano br on br.IDBrano = ba.IDBrano 
			 join Band b on b.IDBand = a.IDBand
where a.AnnoUscita < 2019 and b.Nome = 'Maneskin'

--punto 4
select *
from brano br join BranoAlbum ba on br.IDBrano = ba.IDBrano
              join Album a on a.IDAlbum = ba.IDAlbum
where br.Titolo = 'Imagine'

--punto 5
select b.Nome,sum(br.IDBrano) as 'Brani totali'
from Band b left join Brano br on b.IDBand = br.IDBand
group by b.Nome 
having b.Nome = 'The Giornalisti'


--punto 6
select a.Titolo, Sum(br.Durata * 60) as 'Durata Album in secondi'
from Brano br join BranoAlbum ba on br.IDBrano = ba.IDBrano
              join Album a on a.IDAlbum = ba.IDAlbum		  
group by a.Titolo

--punto 7
select distinct *
from Band b join Brano br on b.IDBand = br.IDBand 
where br.Durata >3 and b.Nome = '883'


--punto 8
select *
from Band b
where b.Nome like 'M%n'

--punto 9

select a.Titolo,     
case
when a.AnnoUscita <1980 then 'Very Old'
when a.AnnoUscita = 2021  then 'New Entry'
when a.AnnoUscita between 2010 and 2020 then 'Recente'
else 'Old'
end as 'Etichetta di uscita'
from Album a 


--punto 10
 					
select *
from Brano
where IDBrano not in (select IDBrano from BranoAlbum)




