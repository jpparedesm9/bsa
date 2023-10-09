/* ********************************************************************* */
/*      Archivo:                sp_reporte_telf_domicilio.sp             */
/*      Stored procedure:       sp_reporte_telf_domicilio                */
/*      Base de datos:          cob_conta_super                          */
/*      Producto:               Regulatorios                             */
/*      Disenado por:           Sonia Rojas                              */
/*      Fecha de escritura:     14-Julio-2020                            */
/* ********************************************************************* */
/*                              IMPORTANTE                               */
/*      Este programa es parte de los paquetes bancarios propiedad de    */
/*      "MACOSA", representantes exclusivos para el Ecuador de la        */
/*      "NCR CORPORATION".                                               */
/*      Su uso no autorizado queda expresamente prohibido asi como       */
/*      cualquier alteracion o agregado hecho por alguno de sus          */
/*      usuarios sin el debido consentimiento por escrito de la          */
/*      Presidencia Ejecutiva de MACOSA o su representante.              */
/* ********************************************************************* */
/*                              PROPOSITO                                */
/*      Programa temporal para sumatoria de contabilidad                 */
/* ********************************************************************* */
/*                             MODIFICACION                              */
/*    FECHA                 AUTOR                 RAZON                  */
/*    14/Jul/2020           SRO              Emision inicial             */
/* ********************************************************************* */

use cob_conta_super
go

if not object_id('sp_reporte_telf_domicilio') is null
   drop proc sp_reporte_telf_domicilio
go

create proc sp_reporte_telf_domicilio
(
   @i_param1   datetime = null   --FECHA REPROCESO
)

as
declare
@w_min_atraso          int,
@w_max_atraso          int,
@w_error               int,
@w_fecha_proceso       datetime,
@w_fecha_corte         datetime,
@w_ciudad_nacional     int,
@w_query               varchar(6000),
@w_comando             varchar(6000),
@w_errores             varchar(255),
@w_s_app               VARCHAR(100),
@w_cmd                 varchar(5000),
@w_arch_resultado      VARCHAR(50),
@w_path_destino        VARCHAR(60),
@w_destino_reporte     VARCHAR(200)


select @w_ciudad_nacional = pa_int
from   cobis..cl_parametro with (nolock)
where  pa_nemonico = 'CIUN'
and    pa_producto = 'ADM'

if @i_param1 is null
   select @w_fecha_proceso = fp_fecha from cobis..ba_fecha_proceso
else
   select @w_fecha_proceso = @i_param1   
   
select @w_fecha_corte  = @w_fecha_proceso

while exists(select 1 from cobis..cl_dias_feriados where df_ciudad = @w_ciudad_nacional  and df_fecha = @w_fecha_corte)
begin
   if datepart(dd, @w_fecha_corte) != 1 select @w_fecha_corte = dateadd(dd, -1, @w_fecha_corte) else break
end

select 
@w_arch_resultado       = ba_arch_resultado,
@w_path_destino         = ba_path_destino
from cobis..ba_batch 
where ba_batch = 28797

PRINT @w_arch_resultado
select @w_min_atraso = isnull(pa_int, 1)
from   cobis..cl_parametro with (nolock)
where  pa_nemonico = 'MINATR'
and    pa_producto = 'CCA'


select @w_max_atraso = isnull(pa_int, 180)
from   cobis..cl_parametro with (nolock)
where  pa_nemonico = 'MAXATR'
and    pa_producto = 'CCA'


PRINT @w_min_atraso 
print @w_max_atraso
select 
dtd_cliente                     = do_codigo_cliente,
dtd_banco                       = do_banco,
dtd_agencia_actual              = convert(varchar(100), null),
dtd_buc                         = convert(varchar(20), null),
dtd_status                      = convert(varchar(20), null),
dtd_lada                        = convert(int, null),
dtd_tel                         = convert(varchar(16), null),
dtd_ext                         = convert(varchar(10), null),
dtd_tipo                        = convert(char(1), null),
dtd_tipo_desc                   = convert(varchar(20), null),
dtd_dias_atraso                 = do_dias_mora_365
into #det_telefono_domicilio
from cob_conta_super..sb_dato_operacion
where do_dias_mora_365 between @w_min_atraso AND @w_max_atraso
and   do_fecha = @w_fecha_corte
and   do_aplicativo = 7

/*TELEFONO DOMICILIO*/
update #det_telefono_domicilio set 
dtd_tel            = te_valor,
dtd_tipo           = te_tipo_telefono
from cobis..cl_direccion, cobis..cl_telefono
where di_ente      = te_ente
and   di_ente      = dtd_cliente
and   di_direccion = te_direccion
and   di_tipo      = 'RE'

/*TIPO TELEFONO*/
update #det_telefono_domicilio set
dtd_tipo_desc  = b.valor
FROM cobis..cl_tabla a, cobis..cl_catalogo b
where a.codigo = b.tabla
and   a.tabla  = 'cl_ttelefono'
and   b.codigo = dtd_tipo

update #det_telefono_domicilio set
dtd_buc           = en_banco
from cobis..cl_ente
where en_ente     = dtd_cliente 

truncate table cob_conta_super..sb_reporte_telefono_domicilio

insert into cob_conta_super..sb_reporte_telefono_domicilio(
[AGENCIA_ACTUAL],[BUC],[ESTATUS],[LADA],           
[TEL],[EXT],[TIPO])  
values (
'AGENCIA_ACTUAL','BUC','ESTATUS','LADA',           
'TEL','EXT','TIPO')

insert into cob_conta_super..sb_reporte_telefono_domicilio(
[AGENCIA_ACTUAL],[BUC],[ESTATUS],[LADA],           
[TEL],[EXT],[TIPO]) 
select 
'AGENCIA_ACTUAL' = isnull(convert(varchar, dtd_agencia_actual),''),
'BUC'            = isnull(convert(varchar, dtd_buc ),''),                 
'ESTATUS'        = isnull(convert(varchar, dtd_status),''),               
'LADA'           = isnull(convert(varchar, dtd_lada),''),                 
'TEL'            = isnull(convert(varchar, dtd_tel ),''),                 
'EXT'            = isnull(convert(varchar, dtd_ext),''),                                   
'TIPO'           = isnull(convert(varchar, dtd_tipo_desc),'')
from #det_telefono_domicilio

           
select @w_query = 'select [AGENCIA_ACTUAL] + char(44) + [BUC]+ char(44) + [ESTATUS] + char(44) + [LADA] + char(44) + '           
select @w_query = @w_query + '[TEL]+ char(44) +[EXT]+ char(44) +[TIPO]'                
select @w_query = @w_query + 'from cob_conta_super..sb_reporte_telefono_domicilio' 


select @w_s_app = pa_char
from cobis..cl_parametro
where pa_producto = 'ADM'
and   pa_nemonico = 'S_APP'       

select 
@w_destino_reporte = @w_path_destino + @w_arch_resultado + '_' +replace(convert(varchar, @w_fecha_proceso,103),'/','') + '.txt',
@w_errores         = @w_path_destino + @w_arch_resultado + '_' +replace(convert(varchar, @w_fecha_proceso,103),'/','') + '.err'

select @w_comando = 'bcp "' + @w_query + '" queryout "'	   
select @w_comando = @w_comando + @w_destino_reporte + '" -b5000 -c -C RAW -T -e ' + @w_s_app + 's_app.ini -T -e"' + @w_errores + '"'

exec @w_error = xp_cmdshell @w_comando

if @w_error <> 0 begin
  select @w_error = 70146
  return 1
end

return 0

go