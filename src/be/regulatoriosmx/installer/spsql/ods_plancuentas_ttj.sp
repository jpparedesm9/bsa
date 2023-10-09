/*************************************************************************/
/*   Archivo:              ods_plancuentas_ttj.sp                        */
/*   Stored procedure:     sp_ods_plan_cuentas_ttj                       */
/*   Base de datos:        cob_conta_super                               */
/*   Producto:             Regulatorios                                  */
/*   Disenado por:         Raúl Altamirano Mendez                        */
/*   Fecha de escritura:   Diciembre 2017                                */
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
/*   Extraccion de datos para la generacion de archivo de interface ODS 6*/
/*   Plan de Cuentas                                                     */
/*                              CAMBIOS                                  */
/*   04/03/2020    	AORTIZ   Modificaciones a archivos ODS               */
/*   17/08/2020    	ACHP     Caso #143664 campo cargabal-cambio de nombre*/
/*   05/11/2021     DCU      Caso 172117                                 */
/*   12/11/2021     DCU      Caso #172460                                */
/*   12/01/2022    	KVI      Caso #173512-Archivo tome ultimo dia natural*/
/*************************************************************************/
use cob_conta_super
go


if exists(select 1 from sysobjects where name = 'sp_ods_plan_cuentas_ttj')
    drop proc sp_ods_plan_cuentas_ttj
go

create proc sp_ods_plan_cuentas_ttj
(
    @i_param1           datetime = null,   --FECHA 
    @t_show_version     bit      =   0
     
)
as
declare
    @w_sp_name          varchar(20),
    @w_s_app            varchar(50),
    @w_path             varchar(255),
    @w_destino          varchar(2500),
    @w_msg              varchar(200),
    @w_error            int,
    @w_errores          varchar(1500),
    @w_comando          varchar(8000),
    @w_report_nombre    varchar(100),
    @w_return           int,
    @w_dia              varchar(2),
    @w_mes              varchar(2),
    @w_anio             varchar(4),
    @w_nom_arch         varchar(255),
    @w_nom_log          varchar(255),
    @w_fecha_proceso    datetime,
    @w_fecha_apertura   datetime,
    @w_fecha_ini        datetime,
    @w_mensaje          varchar(150),
    @w_empresa          int,
    @w_ciudad_nacional  int,
    @w_formato_fecha    int,
    @w_batch            int,
    @w_query            varchar(500),
	@w_columna          varchar(50),
    @w_col_id           int,
    @w_cabecera         varchar(8000),
    @w_nom_cabecera     varchar(8000), 
    @w_nom_columnas     varchar(8000),
    @w_cont_columnas    int,
	@w_sql              varchar(5000),
	@w_es_fin_mes       char(1),
	@w_fecha_fin_mes_hab datetime,
	--Caso #173512 Ini
	@w_fecha_fin_mes     datetime, 
	@w_dia_m             varchar(2),
    @w_mes_m             varchar(2),
    @w_anio_m            varchar(4)
	--Caso #173512 Fin



select @w_sp_name = 'sp_ods_plan_cuentas_ttj'
declare @resultadobcp table (linea varchar(max))
select @w_formato_fecha = 112, @w_batch = 7536
select @w_es_fin_mes = 'N'

--Versionamiento del Programa
if @t_show_version = 1
begin
  print 'Stored Procedure=' + @w_sp_name + ' Version=' + '1.0.0.0'
  return 0
end


if @i_param1 is null 
   select @w_fecha_proceso = fp_fecha from cobis..ba_fecha_proceso
else 
   select @w_fecha_proceso = @i_param1
  

select @w_fecha_apertura = '12/20/2017'


select @w_s_app = pa_char
from   cobis..cl_parametro
where  pa_producto = 'ADM' and pa_nemonico = 'S_APP'

if @@error != 0 or @@rowcount != 1
begin
   select @w_error = 101254
   goto ERROR_PROCESO
end

select @w_empresa = pa_tinyint
from   cobis..cl_parametro
where  pa_nemonico = 'EMP' and pa_producto = 'ADM'

if @@error != 0 or @@rowcount != 1
begin
   select @w_error = 101254
   goto ERROR_PROCESO
end

select @w_ciudad_nacional = pa_int
from   cobis..cl_parametro with (nolock)
where  pa_nemonico = 'CIUN'
and    pa_producto = 'ADM'

if @@error != 0 or @@rowcount != 1
begin
   select @w_error = 101254
   goto ERROR_PROCESO
end


select @w_path          = ba_path_destino,
       @w_report_nombre = ba_arch_resultado
from  cobis..ba_batch
where ba_batch = @w_batch

if @@error != 0 or @@rowcount != 1 or
   isnull(@w_path, '') = '' or 
   isnull(@w_report_nombre, '') = ''
begin
   select @w_error = 807048
   goto ERROR_PROCESO
end

--HASTA ENCONTRAR EL HABIL ANTERIOR
select @w_fecha_ini = dateadd(dd, -1, @w_fecha_proceso)

while exists(select 1 from cobis..cl_dias_feriados where df_ciudad = @w_ciudad_nacional and df_fecha = @w_fecha_ini)
begin 
   if datepart(dd, @w_fecha_ini) != 1 select @w_fecha_ini = dateadd(dd, -1, @w_fecha_ini) else break
end

select @w_dia = right('00' + convert(varchar(2), datepart(dd, @w_fecha_ini)), 2)
select @w_mes = right('00' + convert(varchar(2), datepart(mm, @w_fecha_ini)), 2)
select @w_anio = right(convert(varchar(4), datepart(yyyy, @w_fecha_ini)),4)

-------------------------------------------Caso #143664 Ini
SELECT @w_fecha_fin_mes_hab = dateadd(d, -1, dateadd(m, DATEDIFF(m, 0, @w_fecha_ini) + 1, 0))

while exists(select 1 from cobis..cl_dias_feriados where df_ciudad = @w_ciudad_nacional and df_fecha = @w_fecha_fin_mes_hab) 
begin
   if datepart(dd, @w_fecha_fin_mes_hab) != 1 select @w_fecha_fin_mes_hab = dateadd(dd, -1, @w_fecha_fin_mes_hab) else break
end

if(convert(VARCHAR(10),@w_fecha_fin_mes_hab, @w_formato_fecha) = convert(VARCHAR(10),@w_fecha_ini, @w_formato_fecha))
    select @w_es_fin_mes = 'S'
-------------------------------------------Caso #143664 Fin	
------- creacion del encabezado
if exists(select 1 from sysobjects where name = 'sb_tmp_cabecera_cuentas' and type = 'U')
   drop table sb_tmp_cabecera_cuentas

create table sb_tmp_cabecera_cuentas
(
    cabecera01  varchar(50),
    cabecera02  varchar(50),
    cabecera03  varchar(50),
    cabecera04  varchar(50),
    cabecera05  varchar(50),
    cabecera06  varchar(50),
    cabecera07  varchar(50),
    cabecera08  varchar(50),
    cabecera09  varchar(50),
    cabecera10  varchar(50),
    cabecera11  varchar(50),
    cabecera12  varchar(50),
    cabecera13  varchar(50)
)

--Consultar informacion inicial
select cuenta       = cu_cuenta,
       nombre       = cu_nombre,
       descripcion  = cu_descripcion,
       estado       = cu_estado,
       fecha_estado = max(cu_fecha_estado),
       cargabal     = convert(varchar(20),null)
into #plan_cuentas
from cob_conta..cb_cuenta 
where cu_empresa = @w_empresa
and   cu_movimiento = 'S'
group by cu_cuenta,cu_nombre,cu_descripcion,cu_estado

if @@error != 0
begin
   select @w_error = 70139
   goto ERROR_PROCESO
end

update #plan_cuentas set 
cargabal = eq_valor_arch
from sb_equivalencias 
where ltrim(rtrim(eq_valor_cat)) = ltrim(rtrim(cuenta))
and eq_catalogo = 'ODS_CTA_01'

update #plan_cuentas set
cargabal=null
where len(cargabal) = 0

if @@error != 0
begin
   select @w_error = 710002
   goto ERROR_PROCESO
end

--Registro de Informacion del Reporte en Estructura Final
truncate table sb_ods_plancuentas_ttj

insert into sb_ods_plancuentas_ttj	
(
 op_cod_cta_cont,
 op_cod_entidad,
 op_des_cta_cont,
 op_tip_cta_cont,
 op_tip_divisa,
 op_cls_sdo,
 op_cod_est_sdo,
 op_tip_acceso,
 op_cod_est_cuenta,
 op_fec_alta,
 op_fec_baja,
 op_fec_data,
 op_cod_cargabal
)
select
replicate ('0',(15 - len(ltrim(rtrim(cuenta))))) + convert(varchar,ltrim(rtrim(cuenta))),
convert(varchar(4),'0078'),
substring(ltrim(rtrim(nombre)), 1, 64),
case substring(ltrim(rtrim(cuenta)), 1, 1)
  when '1' then 'A'
  when '2' then 'P'
  when '5' then 'RG'
  when '6' then 'RP'
  when '7' then 'O'
  when '8' then 'O'
  else 'T'
end,
1,
null,
'01',
'A',
case estado
  when 'V' then 'A'
  when 'C' then 'B'
end,
case estado
  when 'V' then convert(varchar(8), fecha_estado, @w_formato_fecha)
  when 'C' then convert(varchar(8), @w_fecha_apertura, @w_formato_fecha)
end,
case estado
  when 'V' then convert(varchar(8), null)
  when 'C' then convert(varchar(8), fecha_estado, @w_formato_fecha)
end,
convert(varchar(8), @w_fecha_ini, @w_formato_fecha),
ltrim(rtrim(convert(varchar(20),cargabal)))
from #plan_cuentas

if @@error <> 0
begin
   select @w_error = 724662
   goto ERROR_PROCESO
end

--ACTUALIZACION DE 4 ULTIMOS CAMPOS A ALTAIR , LAS CUENTAS COBIS SE MANTIENEN
update sb_ods_plancuentas_ttj set  
op_cod_est_sdo      = isnull(sb_cod_estado_altair ,op_cod_est_sdo ),
op_tip_cta_cont     = isnull(sb_tipo_cuenta_altair,op_tip_cta_cont),
op_tip_divisa       = isnull(sb_tipo_divisa_altair,op_tip_divisa),
op_cls_sdo          = isnull(sb_cls_sdo_altair    ,op_cls_sdo)
from sb_equivalencia_cuentas
where  op_cod_cta_cont = sb_cuenta_cobis

print 'Generando Cabeceras'

select @w_col_id   = 0,
       @w_columna  = '',
       @w_cabecera = '',
       @w_nom_cabecera = '', 
       @w_nom_columnas = '',
       @w_cont_columnas = 0
       
while 1 = 1 begin
   set rowcount 1 
   select @w_columna = lower(substring(ltrim(rtrim(c.name)), 4, len(ltrim(rtrim(c.name))) - 3)),
          @w_col_id  = c.colid
   from sysobjects o, syscolumns c
   where o.id    = c.id
   and   o.name  = 'sb_ods_plancuentas_ttj'
   and   c.colid > @w_col_id
   order by c.colid
    
   if @@rowcount = 0 begin
      set rowcount 0
      break
   end
   
   set rowcount 0 
   select @w_cont_columnas = @w_cont_columnas + 1

   select @w_nom_cabecera = @w_nom_cabecera + 'cabecera' + right('00' + convert(varchar(2), @w_cont_columnas), 2) + char(44)
   select @w_cabecera = @w_cabecera + char(39) + @w_columna + char(39) + char(44)
   select @w_nom_columnas = @w_nom_columnas +'op_' + lower(@w_columna) + char(44)   
   
end

select @w_cabecera = substring(@w_cabecera, 1, len(@w_cabecera) - 1),
       @w_nom_cabecera = substring(@w_nom_cabecera, 1, len(@w_nom_cabecera) - 1),
       @w_nom_columnas = substring(@w_nom_columnas, 1, len(@w_nom_columnas) - 1)

--Escribir Cabecera
select    @w_sql = 'insert into cob_conta_super..sb_tmp_cabecera_cuentas '
select    @w_sql = @w_sql + '('
select    @w_sql = @w_sql + @w_nom_cabecera
select    @w_sql = @w_sql + ')'
select    @w_sql = @w_sql + ' values '
select    @w_sql = @w_sql + '('
select    @w_sql = @w_sql + @w_cabecera
select    @w_sql = @w_sql + ')'

exec (@w_sql)

if @@ERROR <> 0 begin
   print 'Error generando Archivo de Cabeceras'
   print @w_sql
   select
   @w_error = 2108048,
   @w_mensaje = 'Error generando Archivo de Cabeceras'
   goto ERROR_PROCESO
end

update sb_ods_plancuentas_ttj set 
op_des_cta_cont = replace(replace(replace(replace(replace(replace(replace(op_des_cta_cont,'Ó','O'),'Í','I'),'É','E'),'Á','A'),'Ñ','N'),'Ü','U'),'Ú','U')



select @w_sql = 'select '
select @w_sql = @w_sql + @w_nom_cabecera
select @w_sql = @w_sql + ' from cob_conta_super..sb_tmp_cabecera_cuentas '
select @w_sql = @w_sql + ' union all ' 
select @w_sql = @w_sql + 'select '
select @w_sql = @w_sql + @w_nom_columnas
select @w_sql = @w_sql + ' from cob_conta_super..sb_ods_plancuentas_ttj '

-------------------------------------------Caso #143664 Ini
print 'borrar-w_fecha_ini: ' + convert(varchar(30),@w_fecha_ini)
print 'borrar-w_fecha_fin_mes_hab: ' + convert(varchar(30), @w_fecha_fin_mes_hab)
print 'borrar-w_es_fin_mes:' + @w_es_fin_mes

if(@w_es_fin_mes = 'S')
begin
    print 'borrar-Se van a crear archivos con D y M'
	
	-------------------------------------------Caso #173512 Ini
	select @w_fecha_fin_mes = dateadd(d, -1, dateadd(m, DATEDIFF(m, 0, @w_fecha_ini) + 1, 0))
	print 'borrar-w_fecha_fin_mes: ' + convert(varchar(30), @w_fecha_fin_mes)
	select @w_dia_m = right('00' + convert(varchar(2), datepart(dd, @w_fecha_fin_mes)), 2) 
    select @w_mes_m = right('00' + convert(varchar(2), datepart(mm, @w_fecha_fin_mes)), 2) 
    select @w_anio_m = right(convert(varchar(4), datepart(yyyy, @w_fecha_fin_mes)),4)      
	-------------------------------------------Caso #173512 Fin
	
    --Primer Archivo
    select @w_nom_arch = @w_report_nombre + '_M_' + @w_anio_m + @w_mes_m + @w_dia_m +'.' + 'txt'
    select @w_nom_log  = @w_report_nombre + '_M_' + @w_anio_m + @w_mes_m + @w_dia_m + '.err'
	
    select @w_destino = @w_path + @w_nom_arch, -- COB_ODS_06<aaaa_mm_dd>.txt
           @w_errores = @w_path + @w_nom_log   -- COB_ODS_06<aaaa_mm_dd>.err
    
    select @w_comando = 'bcp "' + @w_sql + '" queryout "'
    select @w_comando = @w_comando + @w_destino + '" -b5000 -c -C ' + @w_s_app + 's_app.ini -T -e"' + @w_errores + '"'+ ' -t"|" '

    --SELECCIONA CON %ERROR% SI NO ENCUENTRA EN EL FORMATO: ERROR = 
    exec @w_error = xp_cmdshell @w_comando
    print @w_error
    if @w_error <> 0 begin
      select @w_error = 70146
      goto ERROR_PROCESO
    end	
end

select @w_nom_arch = @w_report_nombre + '_D_' +@w_anio + @w_mes + @w_dia +'.' + 'txt'
select @w_nom_log  = @w_report_nombre + '_D_' +@w_anio + @w_mes + @w_dia + '.err'

select @w_destino = @w_path + @w_nom_arch, -- COB_ODS_06<aaaa_mm_dd>.txt
       @w_errores = @w_path + @w_nom_log   -- COB_ODS_06<aaaa_mm_dd>.err

select @w_comando = 'bcp "' + @w_sql + '" queryout "'
select @w_comando = @w_comando + @w_destino + '" -b5000 -c -C ' + @w_s_app + 's_app.ini -T -e"' + @w_errores + '"'+ ' -t"|" '

--SELECCIONA CON %ERROR% SI NO ENCUENTRA EN EL FORMATO: ERROR = 
exec @w_error = xp_cmdshell @w_comando
print @w_error
if @w_error <> 0 begin
  select @w_error = 70146
  goto ERROR_PROCESO
end
-------------------------------------------Caso #143664 Fin

SALIDA_PROCESO:
   return 0

ERROR_PROCESO:

select @w_msg = mensaje
from  cobis..cl_errores with (nolock)
where numero = @w_error
set transaction isolation level read uncommitted

if @w_msg is null select @w_msg = @w_mensaje
else select @w_msg = @w_msg + ' - ' + @w_mensaje

exec @w_return       = cob_conta_super..sp_errorlog
     @i_operacion    = 'I',
     @i_fecha_fin    = @w_fecha_proceso,
     @i_origen_error = @w_error,
     @i_fuente       = @w_sp_name,
     @i_descrp_error = @w_msg

return @w_error

go