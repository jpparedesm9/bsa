/************************************************************************/
/*      Archivo:                calif_emp.sp                            */
/*      Stored procedure:       sp_calificacion_emproblemado            */
/*      Producto:               Crédito                                 */
/*      Disenado por:           Pedro Rafael Montenegro Rosales         */
/*      Fecha de escritura:     29/Nov/2016                             */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      "MACOSA".                                                       */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de MACOSA o su representante.             */
/************************************************************************/  
/*                              PROPOSITO                               */
/*      Realiza la calificacion interna de las operaciones de 1 a 5     */
/************************************************************************/  

use cob_conta_super
go

IF OBJECT_ID ('sp_calificacion_emproblemado') IS NOT NULL
	DROP PROCEDURE sp_calificacion_emproblemado
GO

CREATE proc sp_calificacion_emproblemado
(
   @i_param1             varchar(255),          --Fecha de Proceso
   @i_param2             varchar(255) = null    --Cliente
)
as

declare 
   @i_fecha              datetime,
   @i_cliente            int,
   @w_fecha_fm           datetime,
   @w_sp_name            varchar(15),
   @w_error              int,
   @w_mensaje            varchar(255),
   @w_tcal_emp           catalogo,
   @w_calif_mala         catalogo,
   @w_usuario            login,
   @w_fecha_actual       datetime

select 
@i_fecha        = convert(datetime, @i_param1),
@i_cliente      = convert(int, @i_param2),
@w_sp_name      = 'sp_calificacion_emproblemado',
@w_usuario      = 'crebatch',
@w_fecha_actual = getdate()

if isnull(@i_cliente, 0) <= 0
   select @i_cliente = convert(int, null)

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

/* Insertando reestructurados sb_dato_calificacion */
insert into cob_conta_super..sb_dato_calificacion 
         (dc_fecha, dc_aplicativo, dc_banco, 
         dc_cliente, dc_clase_cartera, dc_tip_calif, 
         dc_calificacion, dc_usuario, dc_fecha_ing)
select 
   @i_fecha,            do_aplicativo,    do_banco,
   do_codigo_cliente,   do_clase_cartera, @w_tcal_emp,
   @w_calif_mala,       @w_usuario,       @w_fecha_actual
from cob_conta_super..sb_dato_operacion
where do_codigo_cliente = isnull(@i_cliente, do_codigo_cliente)
and do_fecha            = @i_fecha
and  do_emproblemado = 'S'

if @@error <> 0 begin
   select @w_error   = 1
   select @w_mensaje = 'Error insertando la califiaccion por emproblemado <sb_dato_calificacion> '
   goto ERRORFIN
end

return 0

ERRORFIN:

select @w_mensaje = @w_sp_name + ' --> ' + @w_mensaje

insert into sb_errorlog (er_fecha, er_fecha_proc, er_fuente, er_origen_error, er_descrp_error) 
                 values (@i_fecha, getdate(), @w_sp_name, convert(varchar, @w_error) + ' - CONSOLIDADOR', @w_mensaje)

return 1

GO
