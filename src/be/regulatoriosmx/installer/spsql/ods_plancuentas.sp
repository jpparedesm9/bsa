/*************************************************************************/
/*   Archivo:              ods_plancuentas.sp                            */
/*   Stored procedure:     sp_ods_plan_cuentas                           */
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
/*************************************************************************/
/*                              CAMBIOS                                  */
/*   24/09/2020 ACH             Caso: 146729                             */
/*   05/11/2021 DCU             Caso 172117                              */
/*************************************************************************/

use cob_conta_super
go

if exists(select 1 from sysobjects where name = 'sp_ods_plan_cuentas')
    drop proc sp_ods_plan_cuentas
go

create proc sp_ods_plan_cuentas
(
    @t_show_version     bit  =   0
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
    @w_comando          varchar(2500),
    @w_report_nombre    varchar(100),
    @w_return           int,
    @w_dia              varchar(2),
    @w_mes              varchar(2),
    @w_anio              varchar(4),
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
    @w_query            varchar(500)


select @w_sp_name = 'sp_ods_plan_cuentas'

select @w_formato_fecha = 112, @w_batch = 7526

--Versionamiento del Programa
if @t_show_version = 1
begin
  print 'Stored Procedure=' + @w_sp_name + ' Version=' + '1.0.0.0'
  return 0
end


select @w_fecha_proceso = fp_fecha from cobis..ba_fecha_proceso

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
select @w_anio = right(convert(varchar(4), datepart(yyyy, @w_fecha_ini)),4)  -- caso#146729


select @w_nom_arch = @w_report_nombre + '_D' +@w_anio + @w_mes + @w_dia +'.' + 'txt'
select @w_nom_log  = @w_report_nombre + '_D' +@w_anio + @w_mes + @w_dia + '.err'


--Consultar informacion inicial
select cuenta       = cu_cuenta,
       nombre       = cu_nombre,
       descripcion  = cu_descripcion,
       estado       = cu_estado,
       fecha_estado = max(cu_fecha_estado),
	   cargabal = convert(char(20), null)
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
where eq_valor_cat = cuenta
and eq_catalogo = 'ODS_CTA_01'

if @@error != 0
begin
   select @w_error = 710002
   goto ERROR_PROCESO
end

update #plan_cuentas set
cargabal=null
where len(cargabal) = 0

--Registro de Informacion del Reporte en Estructura Final
truncate table sb_ods_plancuentas

insert into sb_ods_plancuentas	
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
ltrim(rtrim(cuenta)),
78,
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
  when 'V' then convert(varchar(8), '')
  when 'C' then convert(varchar(8), fecha_estado, @w_formato_fecha)
end,
convert(varchar(8), @w_fecha_ini, @w_formato_fecha),
ltrim(rtrim(convert(varchar(20),cargabal))) --ltrim(rtrim(cargabal))
from #plan_cuentas

if @@error <> 0
begin
   select @w_error = 724662
   goto ERROR_PROCESO
end

--ACTUALIZACION DE 4 ULTIMOS CAMPOS A ALTAIR , LAS CUENTAS COBIS SE MANTIENEN
update sb_ods_plancuentas set  
op_cod_est_sdo      = isnull(sb_cod_estado_altair ,op_cod_est_sdo ),
op_tip_cta_cont     = isnull(sb_tipo_cuenta_altair,op_tip_cta_cont),
op_tip_divisa       = isnull(sb_tipo_divisa_altair,op_tip_divisa),
op_cls_sdo          = isnull(sb_cls_sdo_altair    ,op_cls_sdo)
from sb_equivalencia_cuentas
where  op_cod_cta_cont = sb_cuenta_cobis


update sb_ods_plancuentas set 
op_des_cta_cont = replace(replace(replace(replace(replace(replace(replace(op_des_cta_cont,'Ó','O'),'Í','I'),'É','E'),'Á','A'),'Ñ','N'),'Ü','U'),'Ú','U')


--Actualizar linea de detalle del archivo
update sb_ods_plancuentas
set op_registro_archivo = convert(varchar,isnull(op_cod_cta_cont, ''))     +'|'+
                          '00'+convert(varchar,isnull(op_cod_entidad, 0))  +'|'+
                          convert(varchar,isnull(op_des_cta_cont,''))      +'|'+
                          convert(varchar,isnull(op_tip_cta_cont,''))      +'|'+
                          convert(varchar,isnull(op_tip_divisa,0))         +'|'+
                          convert(varchar,isnull(op_cls_sdo, ''))          +'|'+
                          convert(varchar,isnull(op_cod_est_sdo,''))       +'|'+
                          convert(varchar,isnull(op_tip_acceso, ''))       +'|'+
                          convert(varchar,isnull(op_cod_est_cuenta, ''))   +'|'+
                          convert(varchar,isnull(op_fec_alta, ''))         +'|'+
                          convert(varchar,isnull(op_fec_baja, ''))         +'|'+
                          convert(varchar,isnull(op_fec_data, ''))		   +'|'+
						  convert(varchar,isnull(op_cod_cargabal, ''))

if @@error <> 0
begin
   select @w_error = 724533
   goto ERROR_PROCESO
end

--Geneacion del BCP para creacion del archivo 
select @w_query   = 'select op_registro_archivo from cob_conta_super..sb_ods_plancuentas order by op_cod_cta_cont'

select @w_destino = @w_path + @w_nom_arch, -- COB_ODS_06<aaaa_mm_dd>.txt
       @w_errores = @w_path + @w_nom_log   -- COB_ODS_06<aaaa_mm_dd>.err

select @w_comando = 'bcp "' + @w_query + '" queryout "'
select @w_comando = @w_comando + @w_destino + '" -b5000 -c' + @w_s_app + 's_app.ini -T -e"' + @w_errores + '"'

--PRINT 'Comando: ' + @w_comando

exec @w_error = xp_cmdshell @w_comando

if @w_error <> 0 begin
  select @w_error = 70146
  goto ERROR_PROCESO
end


SALIDA_PROCESO:
return 0

ERROR_PROCESO:
select @w_msg = mensaje
from  cobis..cl_errores with (nolock)
where numero = @w_error
set transaction isolation level read uncommitted

select @w_msg = isnull(@w_msg, @w_mensaje)

exec @w_return       = cob_conta_super..sp_errorlog
     @i_operacion    = 'I',
     @i_fecha_fin    = @w_fecha_proceso,
     @i_origen_error = @w_error,
     @i_fuente       = @w_sp_name,
     @i_descrp_error = @w_msg

return @w_error

go


