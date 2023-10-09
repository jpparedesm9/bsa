 use cob_interfase
 go
 
 if exists(select 1 from sysobjects where name = 'sp_datepart')
    drop proc sp_datepart
 go
 
 CREATE procedure sp_datepart
(
   @i_fecha   datetime,
   @o_anio    smallint  = null out,
   @o_mes     smallint  = null out,
   @o_dia     smallint  = null out,
   @o_week    smallint  = null out,
   @o_min     smallint  = null out,
   @o_hora    smallint  = null out

)
as

print 'Ingresa al sp_datepart'
select @o_dia = datepart(dd, @i_fecha)

select @o_mes = datepart(mm, @i_fecha)

select @o_anio = datepart(yy, @i_fecha)

select @o_week = datepart(weekday, @i_fecha)

select @o_hora = datepart(hh, @i_fecha)

select @o_min = datepart(mi, @i_fecha)

return 0
go