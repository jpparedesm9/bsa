/*cr_cafin.sp************************************************************/
/*  Archivo:                         cr_cafin.sp                        */
/*  Stored procedure:                sp_calificacion_final              */
/*  Base de datos:                   cob_conta_super                    */
/*  Producto:                        Credito                            */
/*  Disenado por:                    Myriam Davila                      */
/*  Fecha de escritura:              27-Jul-1998                        */
/************************************************************************/
/*              IMPORTANTE                                              */
/*  Este programa es parte de los paquetes bancarios propiedad de       */
/*  "MACOSA", representantes exclusivos para el Ecuador de NCR          */
/*  Su uso no autorizado queda expresamente prohibido asi como          */
/*  cualquier alteracion o agregado hecho por alguno de sus             */
/*  usuarios sin el debido consentimiento por escrito de la             */
/*  Presidencia Ejecutiva de MACOSA o su representante.                 */
/************************************************************************/
/*              PROPOSITO                                               */
/*  Este programa va a pasar la calificacion sugerida a la final de     */
/*  todas las operaciones que esten en la tabla de calificacion.        */
/*  Si existe el criterio de calificacion definitiva esta sera la       */
/*  calificacion final de la obligacion                                 */
/************************************************************************/
/*              MODIFICACIONES                                          */
/*  FECHA       AUTOR                   RAZON                           */
/*  28/Jul/98   Monica Vidal G.         Emision Inicial                 */
/*  24/Ago/98   Ma. Augusta Escand¢n    Actualizacion Calif. en Cartera */
/************************************************************************/

use cob_conta_super
go

if exists (select * from sysobjects where name = 'sp_calificacion_final')
   drop proc sp_calificacion_final
go

create proc sp_calificacion_final(
   @i_param1           varchar(255),
   @i_param2           varchar(255) = null
)
as

declare 
   @i_fecha            datetime,
   @i_cliente          int,
   @w_sp_name          varchar(15),
   @w_error            int,
   @w_operacion        int,
   @w_calif            char(1),
   @w_def              varchar(30), 
   @w_count            int,
   @w_fecha	           datetime,
   @w_mensaje          varchar(255),
   @w_usuario          login

select @i_fecha        = convert(datetime, @i_param1),
       @i_cliente      = convert(int, @i_param2),
       @w_usuario      = 'crebatch',
       @w_sp_name      = 'sp_calificacion_final'       

if isnull(@i_cliente, 0) <= 0
   select @i_cliente = convert(int, null)

select *
into #sb_dato_calif
from cob_conta_super..sb_dato_calificacion
where dc_fecha      = @i_fecha
and   dc_aplicativo = 7
and   dc_cliente    = isnull(@i_cliente, dc_cliente)

select 
banco        = dc_banco,
aplicativo   = dc_aplicativo,
calificacion = max(dc_calificacion)
into #calificacion
from #sb_dato_calif
group by dc_banco, dc_aplicativo

if @@error <> 0 begin
   select @w_mensaje = 'Error Insert en #calificacion '
   select @w_error   = 21003
   goto ERRORFIN
end


update cob_conta_super..sb_dato_operacion set
   do_calificacion = calificacion
from #calificacion
where banco       = do_banco
and do_fecha      = @i_fecha
and aplicativo    = do_aplicativo
and do_codigo_cliente    = isnull(@i_cliente, do_codigo_cliente)

if @@error <>0 begin
   select 
   @w_error   = 21001,
   @w_mensaje = 'Error al actualizar Registro de Calificacion Semanal sb_dato_operacion_tmp (do_calificacion) '
   goto ERRORFIN
end

return 0

ERRORFIN:

select @w_mensaje = @w_sp_name + ' --> ' + @w_mensaje

insert into sb_errorlog (er_fecha, er_fecha_proc, er_fuente, er_origen_error, er_descrp_error) 
                 values (@i_fecha, getdate(), @w_sp_name, convert(varchar, @w_error) + ' - CONSOLIDADOR', @w_mensaje)

return @w_error

go
