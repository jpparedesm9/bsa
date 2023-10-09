set nocount on
go
select 'S', 'master'
go
select 'S', nombre
 from master..parambd_cobis, master..bd_cobis_actual
where producto		= prod_actual
order by secuencial
go
set nocount off
go
