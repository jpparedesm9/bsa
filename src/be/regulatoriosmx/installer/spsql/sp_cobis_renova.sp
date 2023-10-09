/*************************************************************************/
/*   Archivo:              sp_cobis_renova.sp		                     */
/*   Stored procedure:     sp_cobis_renova                               */
/*   Base de datos:        cob_cartera                                   */
/*   Producto:             Regulatorios                                  */
/*   Disenado por:         Dario Cumbal - Daniel Berrio                  */
/*   Fecha de escritura:   Febrero 2023                                  */
/*************************************************************************/
/*                                  IMPORTANTE                           */
/*   Este programa es parte de los paquetes bancarios propiedad de       */
/*   'COBIS'.                                                            */
/*   Su uso no autorizado queda expresamente prohibido asi como          */
/*   cualquier alteracion o agregado hecho por alguno de sus             */
/*   usuarios sin el debido consentimiento por escrito de la             */
/*   Presidencia Ejecutiva de COBIS o su representante legal.            */
/*************************************************************************/
/*                                   PROPOSITO                           */
/*  Genera reporte COBIS_PROV_REFIN_AAAAMMDD.txt del requerimiento 200850*/
/*                                                                       */
/*       Parametros de Entrada                                           */
/*			Ninguno                                                      */
/*************************************************************************/
/*                             MODIFICACION                              */
/*    FECHA                 AUTOR                 RAZON                  */
/*    09/Feb/2023            DBM              emision inicial            */
/*    21/Jun/2023            KVI        Req.209947-IVA en Exig_T1,Pago_T1*/
/*************************************************************************/


use cob_cartera
go

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID ('sp_cobis_renova') IS NOT NULL
	DROP PROCEDURE sp_cobis_renova
GO

CREATE proc sp_cobis_renova(
   @i_param1  DATETIME = null,--Variabla de fecha, si va null toma la fecha del ambiente
   @i_param2  char(1) = 'N'   --Variable de reproceso S para Si N para No
)
AS

declare @w_fecha_proceso datetime,
		@w_fecha_corte datetime,
		@w_ini_mes datetime,
		@w_dia1mes datetime,
		@w_fecha_fin datetime,
		@w_ciudad_nacional int,
		@w_fecha_ini datetime,
		@w_batch int,
		@w_ruta_arch varchar(255),
		@w_nombre_arch varchar(30),
		@w_error int,
		@w_reporte varchar(24),
		@w_sql varchar(5000),
		@w_sql_bcp varchar(5000),
		@w_msg varchar(150)

if(@i_param1 is null or @i_param2 = 'N')
begin
	select @w_fecha_proceso = fp_fecha from cobis..ba_fecha_proceso
end
else
begin
	select @w_fecha_proceso = @i_param1
end

select @w_fecha_fin = dateadd(dd,0-datepart(dd,@w_fecha_proceso),@w_fecha_proceso)
print '@w_fecha_fin: ' + convert(varchar,@w_fecha_fin) 

select @w_ciudad_nacional = pa_int
from   cobis..cl_parametro with (nolock)
where  pa_nemonico = 'CIUN'
and    pa_producto = 'ADM'

select @w_ini_mes = dateadd(dd,1 - datepart(dd,@w_fecha_proceso),@w_fecha_proceso)
select @w_dia1mes = @w_ini_mes

/** Busco el primer dia laborable del mes  *****/
while exists(select
			   1
			 from   cobis..cl_dias_feriados
			 where  df_ciudad = @w_ciudad_nacional                                                   
					and df_fecha  = @w_ini_mes)
begin
  select
	@w_ini_mes = dateadd(dd,
						   1,
						   @w_ini_mes)
end

print 'Fecha para el primer dia hábil del mes ' + cast (@w_ini_mes as varchar)
print 'Fecha de ejecución ' + cast (@w_fecha_proceso as varchar)

/** Solo ejecutar el primer día laborable del mes**/
if @w_ini_mes != @w_fecha_proceso
begin
	print 'No se genera el reporte por no ser primer día laborable del mes'
	return 0
end


select @w_fecha_corte  = @w_fecha_fin



while exists(select 1 from cobis..cl_dias_feriados where df_ciudad = @w_ciudad_nacional  and df_fecha = @w_fecha_corte)
   select @w_fecha_corte = dateadd(dd,-1,@w_fecha_corte)

select @w_fecha_ini = convert(datetime, convert(varchar(2),month(@w_fecha_corte))+'/01/'+convert(varchar(4),year(@w_fecha_corte)))
print '@w_fecha_corte: ' + convert(varchar,@w_fecha_corte)
print '@w_fecha_ini: ' + convert(varchar,@w_fecha_ini)
 

select 
op_operacion, 
credito_destino  = op_banco    , 
Exig_T1_dest     = convert(money,null),
Pago_T1_dest     = convert(money,null),
Fec_Exig_T1_dest = convert(datetime,null),
Fec_Pago_T1_dest = convert(datetime,null),
Exig_T2_dest     = convert(money,null),
Pago_T2_dest     = convert(money,null),
Fec_Exig_T2_dest = convert(datetime,null),
Fec_Pago_T2_dest = convert(datetime,null),
Exig_T3_dest     = convert(money,null),
Pago_T3_dest     = convert(money,null),
Fec_Exig_T3_dest = convert(datetime,null),
Fec_Pago_T3_dest = convert(datetime,null),
Exig_T4_dest     = convert(money,null),
Pago_T4_dest     = convert(money,null),
Fec_Exig_T4_dest = convert(datetime,null),
Fec_Pago_T4_dest = convert(datetime,null),
credito_origen   = op_anterior,
Exig_T1_orig     = convert(money,null),
Pago_T1_orig     = convert(money,null),
Fec_Exig_T1_orig = convert(datetime,null),
Fec_Pago_T1_orig = convert(datetime,null),
Exig_T2_orig     = convert(money,null),
Pago_T2_orig     = convert(money,null),
Fec_Exig_T2_orig = convert(datetime,null),
Fec_Pago_T2_orig = convert(datetime,null),
Exig_T3_orig     = convert(money,null),
Pago_T3_orig     = convert(money,null),
Fec_Exig_T3_orig = convert(datetime,null),
Fec_Pago_T3_orig = convert(datetime,null),
Exig_T4_orig     = convert(money,null),
Pago_T4_orig     = convert(money,null),
Fec_Exig_T4_orig = convert(datetime,null),
Fec_Pago_T4_orig = convert(datetime,null)
into #renovaciones
from cob_cartera..ca_operacion,
cob_cartera..ca_estado
where es_codigo  = op_estado
and   es_procesa = 'S'
and op_anterior is not null
and op_fecha_ini <= @w_fecha_corte
and op_fecha_ini >= @w_fecha_ini
--drop table #renovaciones

select
banco     = dc_banco,
num_cuota = dc_num_cuota,
max_cuota_ex = max(dc_num_cuota),
Exig_Parc = isnull(sum(dc_cap_cuota + dc_int_acum + dc_iva_int_acum),0), -- Agregado IVA Req.209947
Pago      = isnull(sum(dc_cap_pag   + dc_int_pag + dc_iva_int_pag),0),   -- Agregado IVA Req.209947
Fec_Exig  = isnull(max(dc_fecha_vto),'01/01/1900'),
Fec_Pago  = isnull(max(dc_fecha_upago),'01/01/1900'),
FechaIni  = isnull(max(dc_fecha_ini),'01/01/1900'),
Exig_max  = convert(int,0)
into  #exigibles_destino
from  cob_conta_super..sb_dato_cuota_pry,
#renovaciones
where dc_fecha      = @w_fecha_corte
and   dc_aplicativo = 7
and   dc_fecha_vto  <= @w_fecha_corte
and   dc_banco       = credito_destino
group by dc_banco, dc_num_cuota
ORDER BY dc_banco


select od_banco = banco,max_cuota = max(num_cuota)
into #max_operacion_sec
from #exigibles_destino
group by banco

select sr_banco = od_banco, sr_max = max_cuota, sr_min = max_cuota -4
into #sec_restar
from #max_operacion_sec
order by  od_banco


delete #exigibles_destino
from #sec_restar
where banco = sr_banco
and num_cuota <= sr_min

/*select banco, count(1)
from #exigibles_destino
group by banco 
*/

update #exigibles_destino set
Exig_max = max_cuota
from #max_operacion_sec
where banco = od_banco


select 
banco,  
ex_Exig_T1 = sum(case when Exig_max = num_cuota then Exig_Parc else 0 end),
ex_Fec_Exig_T1 = max(case when Exig_max  = num_cuota then Fec_Exig else '01/01/1900' end),
ex_Pago_T1 = sum(case when Exig_max = num_cuota then Pago else 0 end),
ex_Fec_Pago_T1 = max(case when Exig_max = num_cuota then Fec_Pago else '01/01/1900' end),

ex_Exig_T2 = sum(case when Exig_max -  1 = num_cuota then Exig_Parc else 0 end),
ex_Fec_Exig_T2 = max(case when Exig_max -  1 = num_cuota then Fec_Exig else '01/01/1900' end),
ex_Pago_T2 = sum(case when Exig_max -  1 = num_cuota then Pago else 0 end),
ex_Fec_Pago_T2 = max(case when Exig_max -  1 = num_cuota then Fec_Pago else '01/01/1900' end),


ex_Exig_T3 = sum(case when Exig_max -  2 = num_cuota then Exig_Parc else 0 end),
ex_Fec_Exig_T3 = max(case when Exig_max -  2 = num_cuota then Fec_Exig else '01/01/1900' end),
ex_Pago_T3 = sum(case when Exig_max -  2 = num_cuota then Pago else 0 end),
ex_Fec_Pago_T3 = max(case when Exig_max -  2 = num_cuota then Fec_Pago else '01/01/1900' end),

ex_Exig_T4 = sum(case when Exig_max - 3= num_cuota then Exig_Parc else 0 end),
ex_Fec_Exig_T4 = max(case when Exig_max - 3 = num_cuota then Fec_Exig else '01/01/1900' end),
ex_Pago_T4 = sum(case when Exig_max - 3 = num_cuota then Pago else 0 end),
ex_Fec_Pago_T4 = max(case when Exig_max - 3 = num_cuota then Fec_Pago else '01/01/1900' end)
into #exigibles_destino_col 
from #exigibles_destino
group by banco


update #renovaciones set
Exig_T1_dest     = ex_Exig_T1,--convert(money,null),
Pago_T1_dest     = ex_Pago_T1,--convert(money,null),
Fec_Exig_T1_dest = ex_Fec_Exig_T1,--convert(datetime,null),
Fec_Pago_T1_dest = ex_Fec_Pago_T1,--convert(datetime,null),
Exig_T2_dest     = ex_Exig_T2,--convert(money,null),
Pago_T2_dest     = ex_Pago_T2,--convert(money,null),
Fec_Exig_T2_dest = ex_Fec_Exig_T2,--convert(datetime,null),
Fec_Pago_T2_dest = ex_Fec_Pago_T2,--convert(datetime,null),
Exig_T3_dest     = ex_Exig_T3,--convert(money,null),
Pago_T3_dest     = ex_Pago_T3,--convert(money,null),
Fec_Exig_T3_dest = ex_Fec_Exig_T3,--convert(datetime,null),
Fec_Pago_T3_dest = ex_Fec_Pago_T3,--convert(datetime,null),
Exig_T4_dest     = ex_Exig_T4,--convert(money,null),
Pago_T4_dest     = ex_Pago_T4,--convert(money,null),
Fec_Exig_T4_dest = ex_Fec_Exig_T4,--convert(datetime,null),
Fec_Pago_T4_dest = ex_Fec_Pago_T4--convert(datetime,null)
from #exigibles_destino_col
where credito_destino= banco


select banco, cuotas = count(1)
into #numero_cuotas_destino
from #exigibles_destino
group by banco


--------------------------------



select 
op_banco, 
op_fecha_fin, 
op_fecha_ult_proceso, 
fecha_ult = case when op_fecha_fin <= op_fecha_ult_proceso then op_fecha_fin else op_fecha_ult_proceso end,
fecha_fin_mes = convert(datetime,null) 
into #operacion_origen_fecha
from #renovaciones, cob_cartera..ca_operacion 
where credito_origen = op_banco


--drop table #operacion_origen_fecha

select distinct fecha_ult
into #fecha_calc_fin 
from #operacion_origen_fecha
order by fecha_ult

declare @w_fecha datetime,   @w_mes int, @w_anio int, @w_dia int, @w_fecha_final datetime--, @w_ciudad_nacional      int  
select @w_fecha = '01/01/1900'

select @w_ciudad_nacional = pa_int
from   cobis..cl_parametro with (nolock)
where  pa_nemonico = 'CIUN'
and    pa_producto = 'ADM'

while 1 = 1
begin
   select top 1
   @w_fecha = fecha_ult
   from #fecha_calc_fin
   where fecha_ult > @w_fecha
   order by fecha_ult
   
   if @@rowcount = 0 break
   
   select @w_mes = month(@w_fecha)
   select @w_anio = year(@w_fecha)
   
   select @w_dia = case 
                when @w_mes in (1,3, 5, 7 , 8, 10, 12) then 31 
                when @w_mes in (4,6, 9, 11) then 30 
                when @w_mes = 2 and ((@w_anio%4)=0 and (@w_anio % 100 <> 0 OR @w_anio % 400 = 0))then 29
                else 28 end
   select  @w_fecha_final = convert(datetime, convert(varchar(2), @w_mes)+'/'+ convert(varchar(2), @w_dia)+'/'+ convert(varchar(4),@w_anio))  
   
   while exists(select 1 from cobis..cl_dias_feriados where df_ciudad = @w_ciudad_nacional  and df_fecha = @w_fecha_final)
   select @w_fecha_final = dateadd(dd,-1,@w_fecha_final)
   
   update #operacion_origen_fecha set
   fecha_fin_mes = @w_fecha_final
   where fecha_ult= @w_fecha
      
end  

--drop table #exigibles_origen

select
banco     = dc_banco,
num_cuota = dc_num_cuota,
max_cuota_ex = max(dc_num_cuota),
Exig_Parc = isnull(sum(dc_cap_cuota + dc_int_acum + dc_iva_int_acum),0), -- Agregado IVA Req.209947
Pago      = isnull(sum(dc_cap_pag   + dc_int_pag + dc_iva_int_pag),0),   -- Agregado IVA Req.209947
Fec_Exig  = isnull(max(dc_fecha_vto),'01/01/1900'),
Fec_Pago  = isnull(max(dc_fecha_upago),'01/01/1900'),
FechaIni  = isnull(max(dc_fecha_ini),'01/01/1900'),
pendiente = convert(money,0),
Exig_max  = convert(int,0)
into  #exigibles_origen
from  cob_conta_super..sb_dato_cuota_pry,
#operacion_origen_fecha
where dc_fecha      = fecha_fin_mes
and   dc_aplicativo = 7
and   dc_fecha_vto  <= fecha_ult
and   dc_banco       = op_banco
group by dc_banco, dc_num_cuota
ORDER BY dc_banco


select od_banco = banco,max_cuota = max(num_cuota)
into #max_operacion_sec_origen
from #exigibles_origen
group by banco

select sr_banco = od_banco, sr_max = max_cuota, sr_min = max_cuota -4
into #sec_restar_origen
from #max_operacion_sec_origen
order by  od_banco


delete #exigibles_origen
from #sec_restar_origen
where banco = sr_banco
and num_cuota <= sr_min

/*select banco, count(1)
from #exigibles_destino
group by banco 
*/

update #exigibles_origen set
Exig_max = max_cuota
from #max_operacion_sec_origen
where banco = od_banco



select 
banco,  
ex_Exig_T1 = sum(case when Exig_max = num_cuota then Exig_Parc else 0 end),
ex_Fec_Exig_T1 = max(case when Exig_max  = num_cuota then Fec_Exig else '01/01/1900' end),
ex_Pago_T1 = sum(case when Exig_max = num_cuota then Pago else 0 end),
ex_Fec_Pago_T1 = max(case when Exig_max = num_cuota then Fec_Pago else '01/01/1900' end),

ex_Exig_T2 = sum(case when Exig_max -  1 = num_cuota then Exig_Parc else 0 end),
ex_Fec_Exig_T2 = max(case when Exig_max - 1 = num_cuota then Fec_Exig else '01/01/1900' end),
ex_Pago_T2 = sum(case when Exig_max - 1  = num_cuota then Pago else 0 end),
ex_Fec_Pago_T2 = max(case when Exig_max -  1 = num_cuota then Fec_Pago else '01/01/1900' end),


ex_Exig_T3 = sum(case when Exig_max -  2 = num_cuota then Exig_Parc else 0 end),
ex_Fec_Exig_T3 = max(case when Exig_max -  2 = num_cuota then Fec_Exig else '01/01/1900' end),
ex_Pago_T3 = sum(case when Exig_max -  2 = num_cuota then Pago else 0 end),
ex_Fec_Pago_T3 = max(case when Exig_max -  2 = num_cuota then Fec_Pago else '01/01/1900' end),

ex_Exig_T4 = sum(case when Exig_max - 3 = num_cuota then Exig_Parc else 0 end),
ex_Fec_Exig_T4 = max(case when Exig_max - 3 = num_cuota then Fec_Exig else '01/01/1900' end),
ex_Pago_T4 = sum(case when Exig_max - 3 = num_cuota then Pago else 0 end),
ex_Fec_Pago_T4 = max(case when Exig_max - 3 = num_cuota then Fec_Pago else '01/01/1900' end)
into #exigibles_origen_col
from #exigibles_origen
group by banco


update #renovaciones set
Exig_T1_orig     = ex_Exig_T1,--convert(money,null),
Pago_T1_orig     = ex_Pago_T1,--convert(money,null),
Fec_Exig_T1_orig = ex_Fec_Exig_T1,--convert(datetime,null),
Fec_Pago_T1_orig = ex_Fec_Pago_T1,--convert(datetime,null),
Exig_T2_orig     = ex_Exig_T2,--convert(money,null),
Pago_T2_orig     = ex_Pago_T2,--convert(money,null),
Fec_Exig_T2_orig = ex_Fec_Exig_T2,--convert(datetime,null),
Fec_Pago_T2_orig = ex_Fec_Pago_T2,--convert(datetime,null),
Exig_T3_orig     = ex_Exig_T3,--convert(money,null),
Pago_T3_orig     = ex_Pago_T3,--convert(money,null),
Fec_Exig_T3_orig = ex_Fec_Exig_T3,--convert(datetime,null),
Fec_Pago_T3_orig = ex_Fec_Pago_T3,--convert(datetime,null),
Exig_T4_orig     = ex_Exig_T4,--convert(money,null),
Pago_T4_orig     = ex_Pago_T4,--convert(money,null),
Fec_Exig_T4_orig = ex_Fec_Exig_T4,--convert(datetime,null),
Fec_Pago_T4_orig = ex_Fec_Pago_T4--convert(datetime,null)
from #exigibles_origen_col
where credito_origen = banco



update #renovaciones set
Exig_T1_dest     = Exig_T1_orig,--convert(money,null),
Pago_T1_dest     = Pago_T1_orig,--convert(money,null),
Fec_Exig_T1_dest = Fec_Exig_T1_orig,--convert(datetime,null),
Fec_Pago_T1_dest = Fec_Pago_T1_orig,--convert(datetime,null),
Exig_T2_dest     = Exig_T2_orig,--convert(money,null),
Pago_T2_dest     = Pago_T2_orig,--convert(money,null),
Fec_Exig_T2_dest = Fec_Exig_T2_orig,--convert(datetime,null),
Fec_Pago_T2_dest = Fec_Pago_T2_orig,--convert(datetime,null),
Exig_T3_dest     = Exig_T3_orig,--convert(money,null),
Pago_T3_dest     = Pago_T3_orig,--convert(money,null),
Fec_Exig_T3_dest = Fec_Exig_T3_orig,--convert(datetime,null),
Fec_Pago_T3_dest = Fec_Pago_T3_orig,--convert(datetime,null),
Exig_T4_dest     = Exig_T4_orig,--convert(money,null),
Pago_T4_dest     = Pago_T4_orig,--convert(money,null),
Fec_Exig_T4_dest = Fec_Exig_T4_orig,--convert(datetime,null),
Fec_Pago_T4_dest = Fec_Pago_T4_orig--convert(datetime,null)
where not exists(select 1 from #numero_cuotas_destino where banco = credito_destino)


update #renovaciones set
Exig_T4_dest     = Exig_T1_orig,--convert(money,null),
Pago_T4_dest     = Pago_T1_orig,--convert(money,null),
Fec_Exig_T4_dest = Fec_Exig_T1_orig,--convert(datetime,null),
Fec_Pago_T4_dest = Fec_Pago_T1_orig--convert(datetime,null),
from #numero_cuotas_destino
where credito_destino = banco
and cuotas = 3


update #renovaciones set
Exig_T4_dest     = Exig_T2_orig,--convert(money,null),
Pago_T4_dest     = Pago_T2_orig,--convert(money,null),
Fec_Exig_T4_dest = Fec_Exig_T2_orig,--convert(datetime,null),
Fec_Pago_T4_dest = Fec_Pago_T2_orig,--convert(datetime,null),
Exig_T3_dest     = Exig_T1_orig,--convert(money,null),
Pago_T3_dest     = Pago_T1_orig,--convert(money,null),
Fec_Exig_T3_dest = Fec_Exig_T1_orig,--convert(datetime,null),
Fec_Pago_T3_dest = Fec_Pago_T1_orig--convert(datetime,null),
from #numero_cuotas_destino
where credito_destino = banco
and cuotas = 2


update #renovaciones set
Exig_T4_dest     = Exig_T3_orig,--convert(money,null),
Pago_T4_dest     = Pago_T3_orig,--convert(money,null),
Fec_Exig_T4_dest = Fec_Exig_T3_orig,--convert(datetime,null),
Fec_Pago_T4_dest = Fec_Pago_T3_orig,--convert(datetime,null),
Exig_T3_dest     = Exig_T2_orig,--convert(money,null),
Pago_T3_dest     = Pago_T2_orig,--convert(money,null),
Fec_Exig_T3_dest = Fec_Exig_T2_orig,--convert(datetime,null),
Fec_Pago_T3_dest = Fec_Pago_T2_orig,--convert(datetime,null),
Exig_T2_dest     = Exig_T1_orig,--convert(money,null),
Pago_T2_dest     = Pago_T1_orig,--convert(money,null),
Fec_Exig_T2_dest = Fec_Exig_T1_orig,--convert(datetime,null),
Fec_Pago_T2_dest = Fec_Pago_T1_orig--convert(datetime,null),
from #numero_cuotas_destino
where credito_destino = banco
and cuotas = 1

create table ##tmp_renovaciones(
campo_1 text
)

insert into ##tmp_renovaciones
select
'credito_destino'  + ';' +
'Exig_T1'+ ';'+
'Pago_T1'+ ';'+
'Fec_Exig_T1'+ ';'+
'Fec_Pago_T1'+ ';'+
'Exig_T2' + ';'+
'Pago_T2' + ';'+
'Fec_Exig_T2'+ ';'+
'Fec_Pago_T2'+ ';'+
'Exig_T3' + ';'+
'Pago_T3' + ';'+
'Fec_Exig_T3'+ ';'+
'Fec_Pago_T3'+ ';'+
'Exig_T4' + ';'+
'Pago_T4' + ';'+
'Fec_Exig_T4'+ ';'+
'Fec_Pago_T4'+ ';'+
'credito_origen'  + ';'+
'Exig_T1' + ';'+
'Pago_T1' + ';'+
'Fec_Exig_T1'+ ';'+
'Fec_Pago_T1'+ ';'+
'Exig_T2' + ';'+
'Pago_T2' + ';'+
'Fec_Exig_T2'+ ';'+
'Fec_Pago_T2'+ ';'+
'Exig_T3' + ';'+
'Pago_T3' + ';'+
'Fec_Exig_T3'+ ';'+
'Fec_Pago_T3'+ ';'+
'Exig_T4' + ';'+
'Pago_T4' + ';'+
'Fec_Exig_T4'+ ';'+
'Fec_Pago_T4'

insert into ##tmp_renovaciones
select
credito_destino  + ';' +
convert(varchar(10),Exig_T1_dest) + ';'+
convert(varchar(10),Pago_T1_dest)+ ';'+
convert(varchar(10),Fec_Exig_T1_dest,112)+ ';'+
case Pago_T1_dest when 0 then '' else convert(varchar(10),Fec_Pago_T1_dest,112) end+ ';'+
convert(varchar(10),Exig_T2_dest) + ';'+
convert(varchar(10),Pago_T2_dest ) + ';'+
convert(varchar(10),Fec_Exig_T2_dest,112)+ ';'+
case Pago_T2_dest when 0 then '' else convert(varchar(10),Fec_Pago_T2_dest,112) end+ ';'+
convert(varchar(10),Exig_T3_dest) + ';'+
convert(varchar(10),Pago_T3_dest) + ';'+
convert(varchar(10),Fec_Exig_T3_dest,112)+ ';'+
case Pago_T3_dest when 0 then '' else convert(varchar(10),Fec_Pago_T3_dest,112) end+ ';'+
convert(varchar(10),Exig_T4_dest) + ';'+
convert(varchar(10),Pago_T4_dest) + ';'+
convert(varchar(10),Fec_Exig_T4_dest,112)+ ';'+
case Pago_T4_dest when 0 then '' else convert(varchar(10),Fec_Pago_T4_dest,112) end+ ';'+
credito_origen  + ';'+
convert(varchar(10),Exig_T1_orig) + ';'+
convert(varchar(10),Pago_T1_orig) + ';'+
convert(varchar(10),Fec_Exig_T1_orig,112)+ ';'+
case Pago_T1_orig when 0 then '' else convert(varchar(10),Fec_Pago_T1_orig,112) end+ ';'+
convert(varchar(10),Exig_T2_orig) + ';'+
convert(varchar(10),Pago_T2_orig) + ';'+
convert(varchar(10),Fec_Exig_T2_orig,112)+ ';'+
case Pago_T2_orig when 0 then '' else convert(varchar(10),Fec_Pago_T2_orig,112) end+ ';'+
convert(varchar(10),Exig_T3_orig) + ';'+
convert(varchar(10),Pago_T3_orig) + ';'+
convert(varchar(10),Fec_Exig_T3_orig,112)+ ';'+
case Pago_T3_orig when 0 then '' else convert(varchar(10),Fec_Pago_T3_orig,112) end+ ';'+
convert(varchar(10),Exig_T4_orig) + ';'+
convert(varchar(10),Pago_T4_orig) + ';'+
convert(varchar(10),Fec_Exig_T4_orig,112)+ ';'+
case Pago_T4_orig when 0 then '' else convert(varchar(10),Fec_Pago_T4_orig,112) end
from #renovaciones

select  @w_batch = 36430

select	
@w_ruta_arch	= ba_path_destino,
@w_nombre_arch	= CONVERT(varchar,DATEPART(yyyy, @w_fecha_proceso),4)+CONVERT(varchar,cobis.dbo.fn_llena_0(DATEPART(mm, @w_fecha_proceso),2),2)+CONVERT(varchar,cobis.dbo.fn_llena_0(DATEPART(dd, @w_fecha_proceso),2),2)

from cobis..ba_batch
where ba_batch = @w_batch

if @@error != 0 or @@rowcount != 1 or isnull(@w_ruta_arch, '') = '' or isnull(@w_nombre_arch, '') = ''
begin
   select @w_error = 70134
   goto ERROR_PROCESO
END

select @w_reporte = 'COBIS_PROV_REFIN_'
select @w_sql = 'select * from ##tmp_renovaciones'

select	@w_sql_bcp = 'bcp "' + @w_sql + '" queryout "' + @w_ruta_arch + @w_reporte + @w_nombre_arch +'".txt"'+'" -C -c -t";" -T'

EXEC xp_cmdshell @w_sql_bcp

drop table ##tmp_renovaciones

return 0

ERROR_PROCESO:

select @w_msg = mensaje
from cobis..cl_errores with (nolock)
where numero = @w_error
