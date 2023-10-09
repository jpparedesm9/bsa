/************************************************************************/
/*   Archivo:             cb_compa_ej.sp                                */
/*   Stored procedure:    sp_comp_autoriza_ej                           */
/*   Base de datos:       cob_conta                                     */
/*   Producto:            Contabilidad                                  */
/*   Disenado por:        Raul Altamirano Mendez                        */
/*   Fecha de escritura:  Octubre.2017                                  */
/************************************************************************/
/*                              IMPORTANTE                              */
/*   Este programa es parte de los paquetes bancarios propiedad de      */
/*   'COBIS'.                                                           */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier alteracion o agregado hecho por alguno de sus            */
/*   usuarios sin el debido consentimiento por escrito de la            */
/*   Presidencia Ejecutiva de 'COBIS' o su representante.               */
/************************************************************************/
/*                              PROPOSITO                               */
/*      Emite un listado de los comprobantes generados por todos los 	*/ 
/*      modulos en estado 'B'						                    */
/************************************************************************/
/*                               MODIFICACIONES                         */
/*  FECHA              AUTOR          	CAMBIO                          */
/*  02.Oct.2017		Raul Altamirano M. 	Emision Inicial					*/
/************************************************************************/

use cob_conta
go

if exists (select 1 from sysobjects where name = 'sp_comp_autoriza_ej')
   drop proc sp_comp_autoriza_ej
go

create proc sp_comp_autoriza_ej
(
	@i_param1       tinyint  = null,  --empresa
	@i_param2       datetime = null   --fecha
)

as 
declare	
@w_empresa          tinyint,
@w_fecha_reporte    datetime,
@w_error			int,
@w_return			int,
@w_mensaje          varchar(150),
@w_param_empresa    tinyint,
@w_fecha_proceso	datetime,
@w_batch            int,
@w_sp_name			varchar(30),
@w_ruta_arch        varchar(255),
@w_nombre_arch      varchar(30),
@w_msg              varchar(255),
@w_sql              varchar(5000),
@w_sql_bcp          varchar(5000)



select @w_sp_name = 'sp_comp_autoriza_ej', @w_batch = 6935

select @w_fecha_proceso = fp_fecha from cobis..ba_fecha_proceso


declare @resultadobcp table (linea varchar(max))

select
@w_ruta_arch    = ba_path_destino,
@w_nombre_arch  = replace(ba_arch_resultado, '.', ('_' + replace(convert(varchar, @w_fecha_proceso, 106), ' ', '') + '.'))
from  cobis..ba_batch
where ba_batch = @w_batch

if @@error != 0 or @@rowcount != 1 or isnull(@w_ruta_arch, '') = '' or isnull(@w_nombre_arch, '') = ''
begin
   select @w_error = 70134
   goto ERROR_PROCESO
end

select @w_param_empresa = pa_tinyint from cobis..cl_parametro where pa_nemonico = 'EMP' and pa_producto = 'ADM'

select @w_empresa       = isnull(@i_param1, @w_param_empresa), 
       @w_fecha_reporte = isnull(@i_param2, @w_fecha_proceso)
	   

select	@w_sql = 'select sc_oficina_orig as OFICINA, '  +
                         'sc_comprobante as NUM_COMP, ' +
                         'sc_descripcion as DESCRIP, '  +
                         'sc_digitador as DIGITADOR, '  +
                         'case when sc_automatico <> 0 then ' + 
						 char(39) + 'A' + char(39) + ' else ' + 
						 char(39) + 'M' + char(39) + ' end as AUTOMATICO, ' +
                         'sc_tot_debito as TOT_DEBITO, ' +
						 'sc_tot_debito_me as TOT_DEBITO_ME, ' +
						 'sc_tot_credito as TOT_CREDITO, ' +
                         'sc_tot_credito_me as TOT_CREDITO_ME, ' + 
                         'sc_tran_modulo as MODULO, ' +
                         'sc_producto as PRODUCTO, '  + 
                         'sc_fecha_tran as FECHA_TRAN ' + 
                         'from cob_conta_tercero..ct_scomprobante ' + 
                 'where  sc_empresa = ' + convert(varchar, @w_empresa) + space(1) +
                 'and sc_producto > 0 ' +
                 'and sc_comprobante > 0 ' +
                 'and sc_fecha_tran <= ' + char(39) + convert(varchar, @w_fecha_reporte, 101) + char(39) + space(1) +
                 'and sc_estado = ' + char(39) + 'B' + char(39) + space(1) +
                 'order by sc_producto, sc_oficina_orig, ' +
				           'sc_area_orig, sc_fecha_tran, sc_comprobante '

						   
select @w_sql_bcp = 'bcp "' + @w_sql + '" queryout "' + @w_ruta_arch + @w_nombre_arch + '" -C -c -t\t -T'

delete from @resultadobcp

insert into @resultadobcp
exec xp_cmdshell @w_sql_bcp;

select * from @resultadobcp

--SELECCIONA CON %ERROR% SI NO ENCUENTRA EN EL FORMATO: ERROR = 
if @w_mensaje is null
    select top 1 @w_mensaje = linea
    from  @resultadobcp 
    where upper(linea) like upper('%Error %')

if @w_mensaje is not null
begin
    select @w_error = 70146
    goto ERROR_PROCESO
end

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

