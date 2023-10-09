/**********************************************************************************/
/*      Base de datos:          cob_cartera                                       */
/*      Producto:               Cartera                                           */
/*      Disenado por:           Adriana Chiluisa                                  */
/*      Fecha de escritura:     21/08/2019                                        */
/**********************************************************************************/
/*                              IMPORTANTE                                        */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad de COBISCorp.    */
/*  Su uso no    autorizado queda  expresamente   prohibido asi como cualquier    */
/*  alteracion o  agregado  hecho por    alguno  de sus usuarios sin el           */
/*   debido consentimiento por   escrito de COBISCorp.                            */
/*  Este programa esta protegido por la ley de   derechos de autor y por las      */
/*  convenciones  internacionales   de  propiedad intelectual.                    */
/*  Su uso no  autorizado dara  derecho a    COBISCorp para obtener ordenes       */
/*  de secuestro o  retencion y para  perseguir penalmente a los                  */
/*  autores de cualquier   infraccion.                                            */
/**********************************************************************************/  
/*                               PROPOSITO                                        */
/*          Tiene como propósito generar pago de realizados elavon                */
/**********************************************************************************/ 
/*                              MOFICIACIONES                                     */
/*   21/08/2019       ACH                  Version Inicial                        */
/**********************************************************************************/

use cob_cartera
go

IF OBJECT_ID ('dbo.sp_reporte_pagos_elavon') IS NOT NULL
	DROP PROCEDURE dbo.sp_reporte_pagos_elavon
GO

create proc sp_reporte_pagos_elavon
(
    @i_param1   datetime = null
)
as 
declare
    @w_fecha           datetime,
    @w_ciudad_nacional int,
	@w_error           int,
	@w_s_app           varchar(40),
	@w_path            varchar(255),
	@w_cmd             varchar(5000),
    @w_destino         varchar(255),
    @w_errores         varchar(255),
	@w_comando         varchar(6000),
	@w_fecha_ant       datetime,
	@w_ffecha          int,
	@w_mensaje         varchar(100)

select @w_ffecha = 103

if(@i_param1 = null)
    select @w_fecha = fp_fecha 
	from   cobis..ba_fecha_proceso
else
    select @w_fecha = @i_param1

	
-- PARAMETRO CODIGO CIUDAD FERIADOS NACIONALES
select @w_ciudad_nacional = pa_int
from   cobis..cl_parametro with (nolock)
where  pa_nemonico = 'CIUN'
and    pa_producto = 'ADM'

if @@rowcount = 0 begin
   select @w_error = 101024
   --goto ERROR_FIN
end

--select 'Fecha Enviada: '+convert(varchar,@w_fecha)--**Borrar
--HASTA ENCONTRAR EL HABIL ANTERIOR
select @w_fecha = dateadd(dd,-1,@w_fecha)
--select 'Fecha Enviada -1: '+convert(varchar,@w_fecha)--**Borrar

while exists(select 1 from cobis..cl_dias_feriados 
             where df_ciudad = @w_ciudad_nacional  and df_fecha = @w_fecha)
   select @w_fecha = dateadd(dd,-1,@w_fecha)

--select 'Fecha Para consulta: '+convert(varchar,@w_fecha)--**Borrar
--------------------------------------------------
----------Para Generar los archivos
--------------------------------------------------
select @w_s_app = pa_char
from cobis..cl_parametro
where pa_producto = 'ADM'
and   pa_nemonico = 'S_APP'

select @w_path = pp_path_destino
from cobis..ba_path_pro
where pp_producto = 7

truncate table ca_reporte_pagos_elavon

insert into ca_reporte_pagos_elavon
select 
'USUARIO',
'NOMBRE_USUARIO',
'NUM_DISPOSITIVO',
'NUM_OPERACION',
'REFERENCIA',
'IMPORTE',
'FECHA_HORA' ,
'NUM_AFILIACION',
'TIPO_OPERACION',
'TIPO_PAGO'

insert into ca_reporte_pagos_elavon
select co_login,
       fu_nombre,
       '',
       co_codigo_interno,
       co_referencia,
       co_monto,
       convert(varchar(50),co_fecha_real,101) + ' ' + convert(varchar(50),co_fecha_real,108),
       '8020519',
       case when co_accion = 'I' then 'PAGOS'
	        when co_accion = 'R' then 'REVERSOS'
	   ELSE '' end,
       co_tipo
from  cob_cartera..ca_corresponsal_trn, cobis..cl_funcionario
where co_corresponsal = 'ELAVON'
and   co_login = fu_login
and   co_fecha_proceso = @w_fecha

update ca_reporte_pagos_elavon
set    rp_num_dispositivo = isnull(di_imei,'')
from   cob_sincroniza..si_dispositivo, ca_reporte_pagos_elavon
where  di_login     = rp_usuario
and    di_estado    = 'R'
and    di_fecha_reg = (select max(di_fecha_reg)
                                        from   cob_sincroniza..si_dispositivo
                                        where  di_login = rp_usuario
                                        and    di_estado = 'R')
										
select @w_cmd = @w_s_app + 's_app bcp -auto -login cob_cartera..ca_reporte_pagos_elavon out '

select 	@w_destino= @w_path + 'PAGOS_ELAVON_' +  replace(CONVERT(varchar(10), @w_fecha, @w_ffecha),'/', '')+ '.txt',
	    @w_errores  = @w_path + 'PAGOS_ELAVON_' +  replace(CONVERT(varchar(10), @w_fecha, @w_ffecha),'/', '')+ '.err'
	
select @w_comando = @w_cmd + @w_destino + ' -b5000 -c -T -e ' + @w_errores + ' -t"|" ' + '-config ' + @w_s_app + 's_app.ini'
--select @w_comando = @w_cmd + @w_destino+ ' -b5000 -c -T -e ' + @w_errores + ' -t"\t" ' + '-config ' + @w_s_app + 's_app.ini' --con espacios

PRINT ' CMD: ' + @w_comando 

exec @w_error = xp_cmdshell @w_comando

if @w_error <> 0 begin
   select
   @w_error = 724680,
   @w_mensaje = 'Error generando Archivo de Seguros Funeral Net Altas'
   goto ERROR
end

return 0

ERROR:
exec cobis..sp_errorlog 
	@i_fecha        = @w_fecha,
	@i_error        = @w_error,
	@i_usuario      = 'usrbatch',
	@i_tran         = 26004,
	@i_descripcion  = @w_mensaje,
	@i_tran_name    =null,
	@i_rollback     ='S'
return @w_error

go

