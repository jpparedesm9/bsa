/*************************************************************************/
/*   Archivo:              ods_balanactivos_tti.sp                       */
/*   Stored procedure:     sp_ods_balance_activos_tti                    */
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
/*   Extraccion de datos para la generacion de archivo de interface ODS 2*/
/*   Balance Activos  TTI                                                */
/*                              CAMBIOS                                  */
/* Sep-23-2019                 AGO             REQ 121717 ODS REVOLVENTE */
/* Oct-31-2019                 AGO             MEJORA 129414             */
/*   27/01/2022       DCU      Caso: #177407                             */
/*************************************************************************/
use cob_conta_super
go

if exists(select 1 from sysobjects where name = 'sp_ods_balance_activos_tti')
    drop proc sp_ods_balance_activos_tti
go

create proc sp_ods_balance_activos_tti
(
    @t_show_version     bit  =   0
)
as
declare
    @w_sp_name          varchar(20),
    @w_s_app            varchar(50),
    @w_path             varchar(255),
    @w_path_obj         varchar(255),
    @w_destino          varchar(2500),
    @w_msg              varchar(200),
    @w_error            int,
    @w_errores          varchar(1500),
    @w_comando          varchar(2500),
    @w_cadena           varchar (1000),
    @w_report_nombre    varchar(100),
    @w_reporte          varchar(10),
    @w_return           int,
    @w_dia              varchar(2),
    @w_mes              varchar(2),
    @w_anio              varchar(4),
    @w_nom_arch         varchar(255),
    @w_nom_log          varchar(255),
    @w_fecha_proceso    datetime,
    @w_mensaje          varchar(150),
    @w_empresa          int,
    @w_ciudad_nacional  int,
    @w_fecha_corte        datetime,
    @w_est_vigente      tinyint,
    @w_est_vencido      tinyint,
    @w_formato_fecha    int,
    @w_batch            int,
    @w_query            varchar(500),
	@w_est_etapa2       tinyint 


select @w_sp_name = 'sp_ods_balance_activos_tti'

select @w_formato_fecha = 112, @w_batch = 75221 ----

--Versionamiento del Programa
if @t_show_version = 1
begin
  print 'Stored Procedure=' + @w_sp_name + ' Version=' + '1.0.0.0'
  return 0
end


select @w_fecha_proceso = fp_fecha from cobis..ba_fecha_proceso


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


select @w_path = ba_path_destino,
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


--CONSULTAR ESTADO VENCIDO/VIGENTE PARA CARTERA
exec @w_error  = cob_externos..sp_estados
@i_producto      = 7,
@o_est_vencido   = @w_est_vencido   out,
@o_est_vigente   = @w_est_vigente   out,
@o_est_etapa2    = @w_est_etapa2    out 

if @w_error > 0 or @w_est_vencido is null or @w_est_vigente is null
begin
   select
   @w_error   = 2108029,
   @w_mensaje = 'No Encontro Estado Vigente/Vencido para Cartera'
   goto ERROR_PROCESO
end



--HASTA ENCONTRAR EL HABIL ANTERIOR
select @w_fecha_corte = dateadd(dd, -1, @w_fecha_proceso)

while exists(select 1 from cobis..cl_dias_feriados where df_ciudad = @w_ciudad_nacional and df_fecha = @w_fecha_corte)
begin
   if datepart(dd, @w_fecha_corte) != 1 select @w_fecha_corte = dateadd(dd, -1, @w_fecha_corte) else break
end


   
select @w_dia = right('00' + convert(varchar(2), datepart(dd, @w_fecha_corte)), 2)
select @w_mes = right('00' + convert(varchar(2), datepart(mm, @w_fecha_corte)), 2)
select @w_anio = right(convert(varchar(4), datepart(yyyy, @w_fecha_corte)),4) -- caso#146729

select @w_nom_arch = @w_report_nombre + '_' + @w_anio + @w_mes + @w_dia +'.' + 'txt'
select @w_nom_log  = @w_report_nombre + '_' + @w_anio + @w_mes + @w_dia + '.err'


--Consultar informacion inicial para generacion del archivo
select 
'banco'        = do_banco,
'cuenta'       = bod_cuenta,
'fecha'        = bod_fecha,
'oficina'      = do_oficina, --bod_oficina,
'rubro'        = bod_concepto,
'saldo_cta'    = bod_val_opera
into #datos_ctas_prestamos
from cob_conta_super..sb_dato_operacion,
     cob_conta..cb_boc_det     
where do_fecha = @w_fecha_corte
and   do_aplicativo = 7 
and   do_estado_cartera in (@w_est_vigente, @w_est_etapa2, @w_est_vencido)
and   bod_fecha = do_fecha
and   bod_banco = do_banco
and   bod_producto = do_aplicativo
and   (bod_cuenta like '1%' or bod_cuenta like '2%' or bod_cuenta like '3%')
--and   do_tipo_operacion not in('REVOLVENTE')
order by do_banco, bod_concepto, bod_cuenta

if @@error != 0
begin
   select @w_error = 70139
   goto ERROR_PROCESO
end



--Registro de Informacion del Reporte en Estructura Final
truncate table sb_ods_balanactivos_tti

insert into sb_ods_balanactivos_tti 
(
 ob_num_cuenta,
 ob_cod_cta_cont,
 ob_cod_divisa,
 ob_fec_data,
 ob_cod_pais,
 ob_cod_centro_cont,
 ob_cod_entidad,
 ob_imp_sdo_cont_mo,
 ob_imp_sdo_cont_ml
)
select
ltrim(rtrim(banco)),
ltrim(rtrim(cuenta)),
'MXP',
convert(varchar(8), @w_fecha_corte, @w_formato_fecha),
52,
oficina,
78,
saldo_cta,
saldo_cta
from #datos_ctas_prestamos
where saldo_cta != 0

if @@error <> 0
begin
   select @w_error = 724662
   goto ERROR_PROCESO
end

--Actualizar linea de detalle del archivo
update sb_ods_balanactivos_tti
set ob_registro_archivo = convert(varchar,isnull(ob_num_cuenta, ''))        +'|'+
                          convert(varchar,isnull(ob_cod_cta_cont, ''))      +'|'+
                          convert(varchar,isnull(ob_cod_divisa,''))         +'|'+
                          convert(varchar,isnull(ob_fec_data,0))            +'|'+
                          convert(varchar,isnull(ob_cod_pais,0))            +'|'+
                          convert(varchar,isnull(ob_cod_centro_cont, 0))    +'|'+
                          '00'+convert(varchar,isnull(ob_cod_entidad,0))    +'|'+
                          convert(varchar,isnull(ob_imp_sdo_cont_mo, 0))    +'|'+
                          convert(varchar,isnull(ob_imp_sdo_cont_ml, 0))   

if @@error <> 0
begin
   select @w_error = 724533
   goto ERROR_PROCESO
end

--Geneacion del BCP para creacion del archivo 
select @w_query   = 'select ob_registro_archivo from cob_conta_super..sb_ods_balanactivos_tti order by ob_num_cuenta, ob_cod_cta_cont'

select @w_destino = @w_path + @w_nom_arch, -- COB_ODS_02_TTI<aaaa_mm_dd>.txt
       @w_errores = @w_path + @w_nom_log   -- COB_ODS_02_TTI<aaaa_mm_dd>.err
       
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


