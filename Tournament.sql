create database Tournament
use  Tournament

select *
from Prizes
select *
from People
select *
from Teams
select *
from TeamMembers;
select *
from Tournaments

--DBCC CHECKIDENT(Teams, RESEED, 0)
create table Tournaments(
	id int primary key identity,
	TournamentName varchar(50),
	EntryFee money,
	Active bit
	)
create table TournamentEntries(
	id int primary key identity,
	TournamentId int,
	TeamId int
	)
create table Prizes(
	id int primary key identity,
	PlaceNumber int,
	PlaceName varchar(50),
	PrizeAmount money,
	PricePercentage float
	)
create table TournamentPrizes(
	id int primary key identity,
	TournamentId int,
	PrizeId int
	)
create table Teams(
	id int primary key identity,
	TeamName varchar(20)
	)
create table TeamMembers(
	id int primary key identity,
	TeamId int,
	PersonId  int
	)

create table People(
	id int primary key identity,
	FirstName varchar(50),
	LastName varchar(50),
	EmailAddress varchar(50),
	CellphoneNumber varchar(50)
	)
	
create table Matchups(
	id int primary key identity,
	WinnerId int,
	MatchupRound int 
	)
create table MatchupEntries(
	id int primary key identity,
	MatchupId int,
	ParentMatchupId int,
	TeamCompetingId int,
	Score float
	)

--Procedure
go
create proc spTournamentEntries_Insert
	@TournamentId int,
	@TeamId int,
	@id int =0 output
as 
begin
	insert into TournamentEntries values (@TournamentId,@TeamId)
	select @id=SCOPE_IDENTITY();
end
go
alter procedure spTeams_Insert
	@TeamName varchar(50),
	@id int =0 output
as
begin
	insert into Teams values(@TeamName)
	select @id= SCOPE_IDENTITY();
end
go
alter procedure spTeamMembers_Insert
	@TeamId int,
	@PersonId int	
as
begin
	insert into TeamMembers values(@TeamId,@PersonId)
	
end
go
create procedure spTournaments_Insert
	@TournamentName varchar(50),
	@EnrtyFee money,
	@id int= 0 output
as
begin
	insert into Tournaments values(@TournamentName,@EnrtyFee,1);
	select @id=SCOPE_IDENTITY();
end
go
create procedure spTournamentPrizes_Insert
	@TournamentId int,
	@PrizeId int,
	@id int= 0 output
as
begin
	insert into TournamentPrizes values(@TournamentId,@PrizeId);
	select @id=SCOPE_IDENTITY()
end
go
alter procedure spPrizes_Insert
	@placeNumber int,
	@placeName varchar(50),
	@prizeAmount money,
	@prizePercentage float,
	@id int =0 output
as
begin
	insert into Prizes values (@placeNumber,@placeName,@prizeAmount,@prizePercentage)
	select @id= SCOPE_IDENTITY();
end
go 
alter procedure spPeople_Insert
	@FirstName varchar(50),
	@LastName varchar(50),
	@EmailAddress varchar(50),
	@CellphoneNumber varchar(50),
	@id int =0 output
as
begin
	insert into People values(@FirstName,@LastName,@EmailAddress,@CellphoneNumber)
	select @id= SCOPE_IDENTITY();
end
go

create procedure spPeople_GetAll
as
begin 
	select * from People
end
go

create procedure spTeam_GetAll
as
begin
	select *
	from Teams
end
go
create procedure spTeam_GetByTournament
	@TournamentId int
as
begin
	select t.*
	from Teams t
	inner join TournamentEntries e on t.id = e.TeamId
	where e.TournamentId=@TournamentId;
end
go
create procedure spTeamMembers_GetByTeam
	@TeamId int
as
begin
	select p.*
	from TeamMembers m
	inner join People p on m.PersonId=p.id
	where m.TeamId=@TeamId;
end
--foreign key constraints

ALTER TABLE TournamentEntries
ADD CONSTRAINT FK_TournamentEntries_Tournments
FOREIGN KEY (TournamentId) REFERENCES Tournaments(id)

ALTER TABLE TournamentEntries
ADD CONSTRAINT FK_TournamentEntries_Teams
FOREIGN KEY (TeamId) REFERENCES Teams(id)
--////////////////////////////////////////////////////
ALTER TABLE TournamentPrizes
ADD CONSTRAINT FK_TournamentPrizes_Tournments
FOREIGN KEY (TournamentId) REFERENCES Tournaments(id)

ALTER TABLE TournamentPrizes
ADD CONSTRAINT FK_TournamentPrizes_Prizes
FOREIGN KEY (PrizeId) REFERENCES Prizes(id)
--////////////////////////////////////////////////////
ALTER TABLE TeamMembers
ADD CONSTRAINT FK_TeamMembers_Teams
FOREIGN KEY (TeamId) REFERENCES Teams(id)

ALTER TABLE TeamMembers
ADD CONSTRAINT FK_TeamMembers_People
FOREIGN KEY (PersonId) REFERENCES People(id)
--////////////////////////////////////////////////////
ALTER TABLE Matchups
ADD CONSTRAINT FK_Matchups_Teams
FOREIGN KEY (WinnerId) REFERENCES Teams(id)
--///////////////////////////////////////////////////
ALTER TABLE MatchupEntries
ADD CONSTRAINT FK_MatchupEntries_Matchups
FOREIGN KEY (MatchupId) REFERENCES Matchups(id)

ALTER TABLE MatchupEntries
ADD CONSTRAINT FK_MatchupEntries_Matchups_2
FOREIGN KEY (ParentMatchupId) REFERENCES Matchups(id)

ALTER TABLE MatchupEntries
ADD CONSTRAINT FK_MatchupEntries_Teams
FOREIGN KEY (TeamCompetingId) REFERENCES Teams(id)