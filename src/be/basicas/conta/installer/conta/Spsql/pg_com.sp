/************************************************************************/
/*      Archivo           :  cb_saprm.sqr                               */
/*      Base de datos     :  cob_conta                                  */
/*      Producto          :  Contabilidad                               */
/*      Disenado por      :  José Rafael Molano Zorro                   */
/*      Fecha de escritura:  06/05/2005                                 */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      "MACOSA", representantes exclusivos para el Ecuador de la       */
/*      "NCR CORPORATION".                                              */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de MACOSA o su representante.             */
/************************************************************************/
/*                              PROPOSITO                               */
/*      Emite listados de estado de resultados para un nùmero de meses, */
/*      tomando las fechas ingresadas por parametro.                    */
/*                                                                      */
/*                                                                      */
/************************************************************************/
/*                            MODIFICACIONES                            */
/*						                        */
/*      FECHA                AUTOR                 RAZON                */
/*   06/05/2005     José Rafael Molano Zorro       Emision Inicial      */
/************************************************************************/


use cob_conta
go 

if exists (select * from sysobjects where name = 'cb_pgcom')
   drop table cb_pgcom
go

create table cb_pgcom
(
   pg_empresa      tinyint         null,
   pg_cuenta       cuenta          null,
   pg_nombre       descripcion     null,
   pg_oficina      smallint        null,
   pg_saldo_ant    money           null,
   pg_saldo_act    money           null,
   pg_diferencia   money           null,
   pg_porcentaje   money           null
)
--lock datarows
go

if exists (select * from sysobjects where name = 'sp_estado_resultados')
   drop proc sp_estado_resultados
go

create proc sp_estado_resultados(
   @s_ssn		  int = null,
   @s_date		  datetime = null,
   @s_term		  descripcion = null,
   @s_corr		  char(1) = null,
   @s_ssn_corr	          int = null,
   @s_ofi		  smallint = null,
   @t_rty		  char(1) = null,
   @t_trn		  smallint = null,
   @t_debug 	          char(1) = 'N',
   @t_file		  varchar(14) = null,
   @t_from		  varchar(30) = null,
   @i_fecha_i	          datetime,
   @i_fecha_f	          datetime,
   @i_empresa	          tinyint,
   @i_nivel_of      	  int,
   @i_oficina_i	          smallint,
   @i_oficina_f	          smallint

)
as

declare

   @w_empresa             tinyint,
   @w_nivel_of            int,
   @w_oficina_i           smallint,
   @w_oficina_f           smallint,
   @w_oficina             smallint,
   @w_fecha               datetime,
   @w_fecha_i             datetime,
   @w_fecha_f             datetime,
   @w_fecha_fin           datetime,
   @w_fecha_a_i           datetime,
   @w_fecha_a_f           datetime,
   @w_dias_dif            int,
   @w_meses               int,
   @w_anio_i              char(4),
   @w_mes_i	          char(2),
   @w_sp_name             varchar,
   @w_corte               smallint,
   @w_corte_ant           smallint,
   @w_corte_a_i           smallint,
   @w_corte_a_f           smallint,
   @w_corte_m             smallint,
   @w_corte_f             smallint,
   @w_corte_i             smallint,
   @w_corte_dia           smallint,
   @w_periodo             smallint,   
   @w_periodo_i           smallint,
   @w_periodo_f           smallint,
   @w_periodo_a_i         smallint,
   @w_periodo_a_f         smallint,
   @w_contador            int,
   @w_saldo               money,
   @w_nombre              descripcion,
   @w_concepto            money,
   @w_cuenta              cuenta



Select @w_dias_dif = datediff(dd, @i_fecha_i, @i_fecha_f)

If @w_dias_dif < 0
begin
   print 'Fecha Invalida'
   return 0
end


Select @w_corte = max(co_corte)
from cob_conta..cb_corte,cob_conta..cb_periodo
where co_empresa = convert(tinyint,@i_empresa)
and   pe_empresa = convert(tinyint,@i_empresa)
and   @i_fecha_i between pe_fecha_inicio and pe_fecha_fin
and   co_periodo = pe_periodo
and   datepart(mm,co_fecha_fin) = datepart(mm,@i_fecha_i)
group by co_periodo

Select @w_corte_dia = co_corte
from cob_conta..cb_corte,cob_conta..cb_periodo
where co_empresa = convert(tinyint,@i_empresa)
and   pe_empresa = convert(tinyint,@i_empresa)
and   @i_fecha_i between pe_fecha_inicio and pe_fecha_fin
and   co_fecha_ini = @i_fecha_i
and   co_periodo = pe_periodo
and   datepart(mm,co_fecha_fin) = datepart(mm,@i_fecha_i)

if (@w_corte <> @w_corte_dia)
begin
   print 'No es una fecha fin de mes'
   return 0
end
else

   Select
   @w_periodo_i = co_periodo ,@w_corte_i = max(co_corte)
   from cob_conta..cb_corte,cob_conta..cb_periodo
   where co_empresa = convert(tinyint,@i_empresa)
   and   pe_empresa = convert(tinyint,@i_empresa)
   and   @i_fecha_i between pe_fecha_inicio and pe_fecha_fin
   and   co_periodo = pe_periodo
   and   datepart(mm,co_fecha_fin) = datepart(mm,@i_fecha_i)
   group by co_periodo

   Select
   @w_periodo_f = co_periodo ,@w_corte_f = max(co_corte)
   from cob_conta..cb_corte,cob_conta..cb_periodo
   where co_empresa = convert(tinyint,@i_empresa)
   and   pe_empresa = convert(tinyint,@i_empresa)
   and   @i_fecha_f between pe_fecha_inicio and pe_fecha_fin
   and   co_periodo = pe_periodo
   and   datepart(mm,co_fecha_fin) = datepart(mm,@i_fecha_f)
   group by co_periodo

   select @w_fecha_a_i = dateadd(mm, -1, @i_fecha_i)
   Select
   @w_periodo_a_i = co_periodo ,@w_corte_a_i = max(co_corte)
   from cob_conta..cb_corte,cob_conta..cb_periodo
   where co_empresa = convert(tinyint,@i_empresa)
   and   pe_empresa = convert(tinyint,@i_empresa)
   and   @w_fecha_a_i between pe_fecha_inicio and pe_fecha_fin
   and   co_periodo = pe_periodo
   and   datepart(mm,co_fecha_fin) = datepart(mm,@w_fecha_a_i)
   group by co_periodo

   select @w_fecha_a_f = dateadd(mm, -1, @i_fecha_f)
   Select @w_periodo_a_f = co_periodo, @w_corte_a_f = max(co_corte)
   from cob_conta..cb_corte,cob_conta..cb_periodo
   where co_empresa = convert(tinyint,@i_empresa)
   and   pe_empresa = convert(tinyint,@i_empresa)
   and   @w_fecha_a_f between pe_fecha_inicio and pe_fecha_fin
   and   co_periodo = pe_periodo
   and   datepart(mm,co_fecha_fin) = datepart(mm,@w_fecha_a_f)
   group by co_periodo

truncate table cb_pgcom

insert into cb_pgcom 
select
convert(tinyint,@i_empresa),
hi_cuenta,
'CTA',
je_oficina_padre,
0,
sum(hi_saldo),
0,
0
from cob_conta_his..cb_hist_saldo,cob_conta..cb_oficina,cob_conta..cb_jerarquia
where of_empresa = convert(tinyint,@i_empresa)
and   of_organizacion = convert(tinyint,@i_nivel_of)
and   of_oficina >= convert(smallint,@i_oficina_i)
and   of_oficina <= convert(smallint,@i_oficina_f)
and   je_empresa = of_empresa
and   je_oficina_padre = of_oficina
and   hi_empresa = convert(tinyint,@i_empresa)
and   hi_periodo = convert(int,@w_periodo_f)
and   hi_corte   = convert(int,@w_corte_f)
and   hi_oficina = je_oficina
and   hi_cuenta  >= '4'
and   hi_cuenta  < '6'
group by je_oficina_padre,hi_cuenta

update cb_pgcom
set pg_nombre = cu_nombre
from cob_conta..cb_cuenta
where cu_empresa = convert(tinyint,@i_empresa)
and   pg_empresa = cu_empresa
and   pg_cuenta  = cu_cuenta
and   pg_cuenta > ' '
and   pg_oficina >= 0

declare cursor_saldo1 cursor for
select sum(hi_saldo), hi_cuenta, je_oficina_padre
from cob_conta_his..cb_hist_saldo,cob_conta..cb_oficina,cob_conta..cb_jerarquia,cob_conta..cb_pgcom
where hi_corte   = convert(int,@w_corte_i)
and   hi_periodo = convert(int,@w_periodo_i)
and   hi_empresa = convert(tinyint,@i_empresa)
and   pg_cuenta = hi_cuenta
and   of_empresa = convert(tinyint,@i_empresa)
and   of_organizacion = convert(tinyint,@i_nivel_of)
and   pg_oficina = je_oficina_padre
and   je_empresa = of_empresa
and   je_oficina_padre = of_oficina
and   hi_oficina = je_oficina
group by je_oficina_padre, hi_cuenta
for read only

open  cursor_saldo1
fetch cursor_saldo1  into @w_concepto,@w_cuenta,@w_oficina
while @@fetch_status =0 
begin   
   if @@fetch_status = -1 
   begin
      print 'Error en Fetch de cursor_saldo1'
      return 0
   end          
   update cob_conta..cb_pgcom
   set pg_saldo_ant = @w_concepto
   where pg_cuenta = @w_cuenta
   and   pg_oficina =  @w_oficina
   fetch cursor_saldo1  into @w_concepto,@w_cuenta,@w_oficina
end
close cursor_saldo1
deallocate cursor_saldo1

declare cursor_saldo2 cursor for
select sum(hi_saldo), hi_cuenta, je_oficina_padre
from cob_conta_his..cb_hist_saldo,cob_conta..cb_oficina,cob_conta..cb_jerarquia,cob_conta..cb_pgcom
where hi_empresa = convert(tinyint,@i_empresa)
and   hi_periodo = convert(int,@w_periodo_a_i)
and   hi_corte   = convert(int,@w_corte_a_i)
and   pg_cuenta = hi_cuenta
and   of_empresa = convert(tinyint,@i_empresa)
and   of_organizacion = convert(tinyint,@i_nivel_of)
and   pg_oficina = je_oficina_padre
and   je_empresa = of_empresa
and   je_oficina_padre = of_oficina
and   hi_oficina = je_oficina
group by je_oficina_padre, hi_cuenta
for read only

open  cursor_saldo2
fetch cursor_saldo2  into @w_concepto,@w_cuenta,@w_oficina
while @@fetch_status =0 
begin   
   if @@fetch_status = -1 
   begin
      print 'Error en Fetch de cursor_saldo2'
      return 0
   end          
   update cob_conta..cb_pgcom
   set pg_saldo_ant = pg_saldo_ant - @w_concepto
   where pg_cuenta = @w_cuenta
   and   pg_oficina =  @w_oficina
   fetch cursor_saldo2  into @w_concepto,@w_cuenta,@w_oficina
end
close cursor_saldo2
deallocate cursor_saldo2

declare cursor_saldo3 cursor for
select sum(hi_saldo), hi_cuenta, je_oficina_padre
from cob_conta_his..cb_hist_saldo,cob_conta..cb_oficina,cob_conta..cb_jerarquia,cob_conta..cb_pgcom
where hi_empresa = convert(tinyint,@i_empresa)
and   hi_periodo = convert(int,@w_periodo_a_f)
and   hi_corte   = convert(int,@w_corte_a_f)
and   pg_cuenta = hi_cuenta
and   of_empresa = convert(tinyint,@i_empresa)
and   of_organizacion = convert(tinyint,@i_nivel_of)
and   pg_oficina = je_oficina_padre
and   je_empresa = of_empresa
and   je_oficina_padre = of_oficina
and   hi_oficina = je_oficina
group by je_oficina_padre, hi_cuenta
for read only

open  cursor_saldo3
fetch cursor_saldo3  into @w_concepto,@w_cuenta,@w_oficina
while @@fetch_status =0 
begin   
   if @@fetch_status = -1 
   begin
      print 'Error en Fetch de cursor_saldo3'
      return 0
   end       
   update cob_conta..cb_pgcom
   set pg_saldo_act = pg_saldo_act - @w_concepto
   where pg_cuenta = @w_cuenta
   and   pg_oficina =  @w_oficina
   fetch cursor_saldo3  into @w_concepto,@w_cuenta,@w_oficina
end
close cursor_saldo3
deallocate cursor_saldo3

update cob_conta..cb_pgcom
set pg_saldo_ant =pg_saldo_ant * (-1), 
pg_saldo_act = pg_saldo_act * (-1)
from cob_conta..cb_cuenta
where pg_cuenta = cu_cuenta
and   cu_categoria = 'C'

update cob_conta..cb_pgcom
set pg_diferencia = (pg_saldo_act - pg_saldo_ant)

update cob_conta..cb_pgcom
set pg_porcentaje = (pg_diferencia / pg_saldo_ant) * 100
where pg_saldo_ant <> 0


update cob_conta..cb_pgcom
set pg_porcentaje = 100
where pg_saldo_ant = 0
and   pg_saldo_act <> 0

go

