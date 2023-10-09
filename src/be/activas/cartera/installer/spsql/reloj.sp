use cob_cartera
go

if exists(select 1 from sysobjects where name = 'ca_reloj')
   drop table ca_reloj
   
go

create table ca_reloj(
referencia int          not null,
hora       varchar(30)  not null)

go

if exists(select 1 from sysobjects where name = 'sp_reloj')
   drop proc sp_reloj
go
 
create proc sp_reloj
@i_referencia  int,
@i_borrar      char(1) = 'N'
as

if @i_borrar = 'S' truncate table ca_reloj

insert into ca_reloj values(@i_referencia, convert(varchar,getdate(),109))

go
