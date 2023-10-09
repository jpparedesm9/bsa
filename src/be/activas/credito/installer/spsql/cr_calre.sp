/*cr_calre.sp*************************************************************/
/*  Archivo:                         cr_calre.sp                         */
/*  Stored procedure:                sp_calificacion_reest               */
/*  Base de datos:                   cob_conta_super                     */
/*  Producto:                        Credito                             */
/*************************************************************************/
/*              IMPORTANTE                                               */
/*  Este programa es parte de los paquetes bancarios propiedad de        */
/*  "MACOSA", representantes exclusivos para el Ecuador de NCR           */
/*  Su uso no autorizado queda expresamente prohibido asi como           */
/*  cualquier alteracion o agregado hecho por alguno de sus              */
/*  usuarios sin el debido consentimiento por escrito de la              */
/*  Presidencia Ejecutiva de MACOSA o su representante.                  */
/*************************************************************************/
/*              PROPOSITO                                                */
/*  Este programa realiza los siguientes procesos:                       */
/*  1. Pone como calificacion por reestructuracion a la calificacion que */
/*     tenia la obligacion antes de ser reestructurada si la obligacion  */
/*     vuelve a vencer y supera el periodo de gracia configurado en el   */
/*     sistema                                                           */
/*  2. Marca el inicio del proceso de calificacion en el parametro CALIF */
/*************************************************************************/

use cob_conta_super
go

IF OBJECT_ID ('sp_calificacion_reest') IS NOT NULL
	DROP PROCEDURE sp_calificacion_reest
GO

CREATE proc sp_calificacion_reest
(
   @i_param1            varchar(255),
   @i_param2            varchar(255) = null
)
as

declare 
   @i_fecha              datetime,
   @i_cliente            int,
   @w_fecha_fm           datetime,
   @w_sp_name            varchar(15),
   @w_error              int,
   @w_mensaje            varchar(255),
   @w_est_vencido        tinyint,
   @w_calif_mala         catalogo,
   @w_tcal_res           catalogo,
   @w_tcal_ren           catalogo,
   @w_num_inst           tinyint,
   @w_calif              catalogo,
   @w_usuario            login,
   @w_fecha_actual       datetime

select 
@i_fecha        = convert(datetime, @i_param1),
@i_cliente      = convert(int, @i_param2),
@w_sp_name      = 'sp_calificacion_reest',
@w_usuario      = 'crebatch',
@w_fecha_actual = getdate()

if isnull(@i_cliente, 0) <= 0
   select @i_cliente = convert(int, null)

--Codigo Reestructuracion
select @w_tcal_res = substring(pa_char,1,10)
from   cobis..cl_parametro
where  pa_nemonico = 'RES'
and    pa_producto = 'REC'

if @w_tcal_res is null begin
   select @w_error   = 1
   select @w_mensaje = 'No Encontro parametro <RES> '
   goto ERRORFIN
end

--Codigo Renovacion
select @w_tcal_ren = substring(pa_char,1,10)
from   cobis..cl_parametro
where  pa_nemonico = 'REN'
and    pa_producto = 'REC'

if @w_tcal_ren is null begin
   select @w_error   = 1
   select @w_mensaje = 'No Encontro parametro <REN> '
   goto ERRORFIN
end

--Calificacion Mala
select @w_calif_mala = substring(pa_char, 1, 10)
from   cobis..cl_parametro
where  pa_nemonico = 'MCAL'
and    pa_producto = 'REC'

if @w_calif_mala is null begin
   select @w_error   = 1
   select @w_mensaje = 'No Encontro parametro <MCAL> '
   goto ERRORFIN
end

--CONSULTAR ESTADO VENCIDO PARA CARTERA
exec cob_externos..sp_estados
   @i_producto    = 7,
   @o_est_vencido = @w_est_vencido out

if @w_est_vencido is null begin
   select @w_error   = 1
   select @w_mensaje = 'No Encontro Estado Vencido para Cartera '
   goto ERRORFIN
end
   
/* CALIFICACION CON LAS OPERACIONES REESTRUCTURADAS VENCIDAS */
insert into cob_conta_super..sb_dato_calificacion
      (dc_fecha, dc_aplicativo, dc_banco, 
      dc_cliente, dc_clase_cartera, dc_tip_calif, 
      dc_calificacion, dc_usuario, dc_fecha_ing)
select 
   @i_fecha,            do_aplicativo,          do_banco,
   do_codigo_cliente,   do_clase_cartera,       @w_tcal_res,
   @w_calif_mala,       @w_usuario,             @w_fecha_actual
from cob_conta_super..sb_dato_operacion
where do_reestructuracion = 'S'
and do_fecha            = @i_fecha
and do_estado_cartera   = @w_est_vencido
and do_codigo_cliente   = isnull(@i_cliente, do_codigo_cliente)

if @@error <> 0 begin
   select @w_error   = 1
   select @w_mensaje = 'Error Insertando calificacion reestructuradas '
   goto ERRORFIN
end

/* CALIFICACION CON LAS OPERACIONES RENOVADAS VENCIDAS */
insert into cob_conta_super..sb_dato_calificacion
      (dc_fecha, dc_aplicativo, dc_banco, 
      dc_cliente, dc_clase_cartera, dc_tip_calif, 
      dc_calificacion, dc_usuario, dc_fecha_ing)
select 
   @i_fecha,            do_aplicativo,          do_banco,
   do_codigo_cliente,   do_clase_cartera,       @w_tcal_ren,
   @w_calif_mala,       @w_usuario,             @w_fecha_actual
from cob_conta_super..sb_dato_operacion
where do_op_anterior    is not null
and do_fecha            = @i_fecha
and do_estado_cartera   = @w_est_vencido
and do_codigo_cliente   = isnull(@i_cliente, do_codigo_cliente)

if @@error <> 0 begin
   select @w_error   = 1
   select @w_mensaje = 'Error Insertando calificacion renovadas '
   goto ERRORFIN
end

return 0

ERRORFIN:

select @w_mensaje = @w_sp_name + ' --> ' + @w_mensaje

insert into sb_errorlog (er_fecha, er_fecha_proc, er_fuente, er_origen_error, er_descrp_error) 
                 values (@i_fecha, getdate(), @w_sp_name, convert(varchar, @w_error) + ' - CONSOLIDADOR', @w_mensaje)

return 1

GO
