use cob_cartera
go
/************************************************************************/
/*   ARCHIVO:         sp_act_reg_con_error.sp                           */
/*   NOMBRE LOGICO:   sp_act_reg_con_error                              */
/*   Base de datos:   cob_cartera                                       */
/*   PRODUCTO:        Cartera                                           */
/*   Fecha de escritura:   Marzo 2020                                   */
/************************************************************************/
/*                                  IMPORTANTE                          */
/*   Este programa es parte de los paquetes bancarios propiedad de      */
/*   'COBIS'.                                                           */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier alteracion o agregado hecho por alguno de sus            */
/*   usuarios sin el debido consentimiento por escrito de la            */
/*   Presidencia Ejecutiva de COBIS o su representante legal.           */
/************************************************************************/
/*                     PROPOSITO                                        */
/*   Elimina los registros de ca_corresponsal_trn que quedan en estado  */
/*   I, apesar de que dieron error                                      */
/************************************************************************/
/*                     MODIFICACIONES                                   */
/*   FECHA        AUTOR     RAZON                                       */
/* 05/03/2020     ACHP       Caso #XXXXX - Emision inicial              */
/************************************************************************/

if exists(select 1 from sysobjects where name = 'sp_act_reg_con_error')
    drop proc sp_act_reg_con_error
go

create proc sp_act_reg_con_error (
    @i_param1           datetime = null, -- FECHA DE PROCESO
    @t_show_version     bit      = 0
)as
declare
  @w_sp_name        varchar(20),
  @w_s_app          varchar(50),
  @w_path           varchar(255),  
  @w_msg            varchar(200),  
  @w_return         int,
  @w_param_dias     int,
  @w_ciudad_nacional  int

select @w_sp_name = 'sp_act_reg_con_error'

--Versionamiento del Programa
if @t_show_version = 1
begin
  print 'Stored Procedure=' + @w_sp_name + ' Version=' + '1.0.0.0'
  return 0
end

select @w_ciudad_nacional = pa_int
from   cobis..cl_parametro with (nolock)
where  pa_nemonico = 'CIUN'
and    pa_producto = 'ADM'

if(@i_param1 is null)
  select @i_param1 = (select fp_fecha FROM cobis..ba_fecha_proceso)

select @w_param_dias = pa_int from cobis..cl_parametro where pa_nemonico = 'ERCTRE' and pa_producto = 'CCA'

select @i_param1 = dateadd(dd,-@w_param_dias, @i_param1)

while exists( select 1 from cobis..cl_dias_feriados where df_ciudad = @w_ciudad_nacional and df_fecha = @i_param1) 
    select @i_param1 = dateadd(dd,-1, @i_param1)

PRINT 'fecha_final_consulta:' + convert(VARCHAR(30),@i_param1)

--SELECT * FROM cob_cartera..ca_corresponsal_trn where co_tipo = 'GL' and co_estado = 'I' and co_fecha_proceso < @i_param1 ORDER BY co_secuencial ASC--56
update ca_corresponsal_trn
set co_estado = 'E'
where co_tipo = 'GL' and co_estado = 'I' and co_fecha_proceso < @i_param1

return 0

go
