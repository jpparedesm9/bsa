/************************************************************************/
/*      Archivo:                anuautspr.sp                            */
/*      Stored procedure:       sp_anula_autspread                      */
/*      Base de datos:          cobis                                   */
/*      Producto:               Plazo Fijo                              */
/*      Disenado por:           Ximena Cartagena                        */
/*      Fecha de documentacion: 21-Mar-2005                             */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      'MACOSA', representantes exclusivos para el Ecuador de la       */
/*      'NCR CORPORATION'.                                              */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de MACOSA o su representante.             */
/************************************************************************/
/*                              PROPOSITO                               */
/*      Anula las autorizaciones de spread de tasa fija no utilizadas   */
/*      durante el d¡a                                                  */
/*                                                                      */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA           AUTOR              RAZON                        */
/*      26-Ago-2006     Gabriela Arboleda  Emision Inicial              */
/************************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if exists (select 1 from sysobjects where name = 'sp_anula_autspread')
   drop proc sp_anula_autspread
go
create proc sp_anula_autspread (
   @s_user                 login           = NULL, 
   @t_debug                char(1)         = 'N',
   @t_file                 varchar(10)     = NULL,
   @i_fecha_proceso        datetime
)
with encryption
as
declare 
@w_sp_name         descripcion,
@w_error           int,
@w_operacion       int,
@w_operacion_c     varchar(15),
@w_debug           char(1)
       
select @w_sp_name = 'sp_anula_autspread'


declare cur_autorizacion cursor for

select as_operacion
from   pf_aut_spread
where  as_fecha  = @i_fecha_proceso
  and  as_estado = 'V'

open cur_autorizacion

fetch cur_autorizacion into
      @w_operacion 

while @@fetch_status = 0
begin
   

   select @w_operacion_c = convert(varchar(10),@w_operacion)

   update pf_aut_spread
      set as_estado = 'A'
   where current of cur_autorizacion
   select @w_error = @@error
   if @w_error <> 0
   begin
   	exec sp_errorlog 
           @s_date    = @i_fecha_proceso,
           @i_fecha   = @i_fecha_proceso,
	   @i_error   = @w_error,
           @i_usuario = @s_user,
           @i_cuenta  = @w_operacion_c,
           @i_descripcion = @w_sp_name

        goto LEER
   end

   LEER:
   fetch cur_autorizacion into
      @w_operacion 
end

   if @w_debug = 'S' begin
      print 'anula spread @@FETCH_STATUS '+ cast(@@FETCH_STATUS as varchar) 
   end

if @@fetch_status = -2
begin
	close cur_autorizacion
	deallocate cur_autorizacion
	raiserror ('200001 - Fallo lectura del cursor ', 16, 1)
	return 0
end 


close cur_autorizacion
deallocate cur_autorizacion

return 0
go



