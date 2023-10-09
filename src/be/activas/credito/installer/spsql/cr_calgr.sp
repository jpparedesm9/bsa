/*cr_calgr.sp***********************************************************/
/*	Archivo:                        cr_calgr.sp                         */
/*	Stored procedure:               sp_calificacion_gral                */
/*	Base de Datos:                  cob_conta_super                     */
/*	Producto:                       CREDITO                             */
/*	Disenado por:                   Alfredo Zuluaga                     */
/*	Fecha de Documentacion:         Nov 26/2009                         */
/***********************************************************************/
/*			             IMPORTANTE                                       */
/*	Este programa es parte de los paquetes bancarios propiedad de       */
/*	"MACOSA",representantes exclusivos para el Ecuador de la            */
/*	AT&T                                                                */
/*	Su uso no autorizado queda expresamente prohibido asi como          */
/*	cualquier autorizacion o agregado hecho por alguno de sus           */
/*	usuario sin el debido consentimiento por escrito de la              */
/*	Presidencia Ejecutiva de MACOSA o su representante                  */
/***********************************************************************/
/*			PROPOSITO                                                     */
/*	Este stored procedure permite realizar las siguientes               */ 
/*	operaciones: Ejecuta los procesos de calificacion                   */
/*      (BATCH)                                                        */
/***********************************************************************/
/*			MODIFICACIONES                                                */
/*	FECHA		AUTOR			RAZON                                          */
/*	11/26/09        Alfredo Zuluaga         Emision Inicial             */
/***********************************************************************/

use cob_conta_super
go

IF OBJECT_ID ('sp_calificacion_gral') IS NOT NULL
	DROP PROCEDURE sp_calificacion_gral
GO

CREATE proc sp_calificacion_gral
(
   @i_param1             varchar(255),          --Fecha de Proceso
   @i_param2             varchar(255) = null    --Cliente
) 
as

declare
@i_fecha              datetime,
@i_cliente            int,
@w_periodicidad       varchar(1),
@w_today              datetime,      /* FECHA DEL DIA       */ 
@w_sp_name            varchar(32),   /* NOMBRE STORED PROC  */
@w_error              int,
@w_usuario            varchar(20),
@w_mensaje            varchar(255),
@w_tcal_res           catalogo,
@w_tcal_ren           catalogo,
@w_tcal_emp           catalogo,
@w_msg                varchar(200)

select @i_fecha        = convert(datetime, @i_param1),       --Fecha del Cierre Actual
       @i_cliente      = convert(int, @i_param2),            --Cliente
       @w_sp_name      = 'sp_calificacion_gral',
       @w_usuario      = 'crebatch'

if isnull(@i_cliente, 0) <= 0
   select @i_cliente = convert(int, null)
       
exec @w_error = sp_dia_habil_cierre
@i_fecha        = @i_fecha,
@o_periodicidad = @w_periodicidad out,
@o_msg          = @w_msg out

if @w_error <> 0 begin
   select @w_mensaje   = 'Error Ejecutando sp_dia_habil_cierre '
   select @w_error     = 210001 
   goto ERRORFIN 
end

if @w_msg is not null begin
   select @w_mensaje  = @w_msg
   select @w_error    = 210001 
   goto ERRORFIN 
end

select @w_tcal_res = substring(pa_char,1,10)
from   cobis..cl_parametro
where  pa_nemonico = 'RES'
and    pa_producto = 'REC'

if @w_tcal_res is null begin
   select @w_error   = 21001
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

--Codigo Emproblemado
select @w_tcal_emp = substring(pa_char, 1, 10)
from   cobis..cl_parametro
where  pa_nemonico = 'EMP'
and    pa_producto = 'REC'

if @w_tcal_emp is null begin
   select @w_error   = 1
   select @w_mensaje = 'No Encontro parametro <EMP> '
   goto ERRORFIN
end

--Eliminacion Informacion de Calificacion para Todos los Procesos
if @i_cliente is null begin

   --Eliminar sb_dato_calificacion para la fecha de cierre (todos los marcados RES)
   delete cob_conta_super..sb_dato_calificacion
   where dc_fecha      = @i_fecha
   and   dc_aplicativo = 7
   and   dc_tip_calif  in (@w_tcal_res, @w_tcal_ren, @w_tcal_emp)
   
   if @@error <> 0 begin
      select @w_error   = 21001
      select @w_mensaje = 'Error Eliminando <sb_dato_calificacion> '
      goto ERRORFIN
   end
   
end else begin  -- calificacion de un solo cliente

   --Eliminar sb_dato_calificacion para la fecha de cierre (todos los marcados RES)
   delete cob_conta_super..sb_dato_calificacion
   where dc_fecha      = @i_fecha
   and   dc_aplicativo = 7
   and   dc_cliente    = @i_cliente
   and   dc_tip_calif in (@w_tcal_res, @w_tcal_ren, @w_tcal_emp)
   
   if @@error <> 0 begin
      select @w_error   = 21001
      select @w_mensaje = 'Error Eliminando Reestructurados <sb_dato_calificacion> '
      goto ERRORFIN
   end
   
end

--Envio de Procesos de Calificacion
--1. Calificacion por Cliente Emproblemado
exec @w_error = cob_conta_super..sp_calificacion_emproblemado
@i_param1 = @i_param1,
@i_param2 = @i_param2

if @w_error <> 0 begin
   select @w_mensaje = 'Error Ejecutando <sp_calificacion_vto> '
   goto ERRORFIN
end

----2. Calificacion por Reestructuracion
exec @w_error = cob_conta_super..sp_calificacion_reest
@i_param1 = @i_param1,
@i_param2 = @i_param2

if @w_error <> 0 begin
   select @w_mensaje = 'Error Ejecutando <sp_calificacion_reest> '
   goto ERRORFIN
end

--3. Calificacion Final por Operacion
exec @w_error = cob_conta_super..sp_calificacion_final
@i_param1 = @i_param1,
@i_param2 = @i_param2

if @w_error <> 0 begin
   select @w_mensaje = 'Error Ejecutando <sp_calificacion_final> '
   goto ERRORFIN
end

return 0

ERRORFIN:

select @w_mensaje = @w_sp_name + ' --> ' + @w_mensaje

insert into sb_errorlog (er_fecha, er_fecha_proc, er_fuente, er_origen_error, er_descrp_error) 
                 values (@i_fecha, getdate(), @w_sp_name, convert(varchar, @w_error) + ' - CONSOLIDADOR', @w_mensaje)

return @w_error

GO
