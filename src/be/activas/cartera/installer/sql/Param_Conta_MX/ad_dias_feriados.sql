use cobis
go

declare @w_fecha_ini       datetime,
        @w_fecha_fin       datetime,
        @w_dia_semana      int,
        @w_cod_pais        int,
        @w_ciudad_nacional int

--Creacion de tablas temporales
create table #feriado_nacional(fecha datetime)

--Insercion fechas feriado nacional 2017
insert into #feriado_nacional values('01/01/2017')
insert into #feriado_nacional values('02/06/2017')
insert into #feriado_nacional values('03/20/2017')
insert into #feriado_nacional values('04/13/2017')
insert into #feriado_nacional values('04/14/2017')
insert into #feriado_nacional values('05/01/2017')
insert into #feriado_nacional values('11/02/2017')
insert into #feriado_nacional values('11/20/2017')
insert into #feriado_nacional values('12/12/2017')
insert into #feriado_nacional values('12/25/2017')

--Insercion fechas feriado nacional 2018
insert into #feriado_nacional values('01/01/2018')
insert into #feriado_nacional values('02/05/2018')
insert into #feriado_nacional values('03/19/2018')
insert into #feriado_nacional values('03/29/2018')
insert into #feriado_nacional values('03/30/2018')
insert into #feriado_nacional values('05/01/2018')
insert into #feriado_nacional values('11/02/2018')
insert into #feriado_nacional values('11/19/2018')
insert into #feriado_nacional values('12/12/2018')
insert into #feriado_nacional values('12/25/2018')


--Rango del periodo
select @w_fecha_ini = '01/01/2017', @w_fecha_fin = '12/31/2018'

select @w_cod_pais = pa_smallint
from cl_parametro
where pa_nemonico='CP' and pa_producto='ADM'

select @w_ciudad_nacional = pa_smallint 
from cl_parametro
where pa_nemonico = 'CFN'

truncate table cl_dias_feriados

while datediff(dd,@w_fecha_ini,@w_fecha_fin) >= 0
begin
   if datepart(dw, @w_fecha_ini) in (1,7)
      or exists(select 1 from #feriado_nacional where datediff(dd,@w_fecha_ini,fecha) = 0) --Fines de semana/Feriados
   begin
      insert cl_dias_feriados(df_fecha,df_ciudad)
      select @w_fecha_ini,ci_ciudad
      from cobis..cl_ciudad
      where  ci_pais = @w_cod_pais
      and    ci_ciudad not in (select df_ciudad from cl_dias_feriados where df_fecha = @w_fecha_ini)

      insert cl_dias_feriados(df_fecha,df_ciudad)
      values(@w_fecha_ini, @w_ciudad_nacional)
   end
   select @w_fecha_ini = dateadd(dd,1,@w_fecha_ini)
end

--Creacion de tablas temporales
drop table #feriado_nacional
go

