/************************************************************************/
/*      Archivo:                i_autspr.sp                             */
/*      Stored procedure:       sp_ins_autspread                        */
/*      Base de datos:          cobis                                   */
/*      Producto:               Plazo Fijo                              */
/*      Disenado por:           N. Silva                                */
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
/*                              PROPOSITO                               */
/*      Este script crea los procedimientos para las consultas de las   */
/*      operaciones de plazos fijos.                                    */
/*                                                                      */
/*                              MODIFICACIONES                          */
/*      FECHA           AUTOR              RAZON                        */
/*      21-Mar-2005     N. Silva           Emision Inicial              */
/************************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if exists (select 1 from sysobjects where name = 'sp_ins_autspread')
   drop proc sp_ins_autspread
go

create proc sp_ins_autspread (
@s_ssn                  int             = NULL,
@s_user                 login           = NULL,
@s_term                 varchar(30)     = NULL,
@s_date                 datetime        = NULL,
@s_srv                  varchar(30)     = NULL,
@s_lsrv                 varchar(30)     = NULL,
@s_ofi                  smallint        = NULL,
@s_rol                  smallint        = NULL,
@t_debug                char(1)         = 'N',
@t_file                 varchar(10)     = NULL,
@t_from                 varchar(32)     = NULL,
@t_trn                  smallint,
@i_as_operacion         int             = 0,
@i_as_spread            float,
@i_as_operador          char(1),
@i_operacion            char(1)         = 'I',
@i_as_estado            char(1))
with encryption
as
declare
@w_sp_name              descripcion,
@w_error                int,
@w_as_estado            char(1),
@w_secuencial           int,
@w_embargo              money
       
select @w_sp_name = 'sp_ins_autspread'


/*----------------------------------*/
/*  Verificar Codigo de Transaccion */
/*----------------------------------*/
if @t_trn <> 14159       
begin
   exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 149065
	return 1
end

   select @w_embargo   = isnull(op_monto_blq, 0) + isnull(op_monto_blqlegal, 0) + isnull(op_monto_pgdo, 0) + isnull(op_monto_int_blqlegal, 0)
     from pf_operacion
    where op_operacion   = @i_as_operacion

		/*Validar que el titulo no tenga ningun Valor Bloqueado*/
		if @w_embargo > 0 
		begin
		   exec cobis..sp_cerror 
       			@t_debug = @t_debug,
        		@t_file  = @t_file,
        		@t_from  = @w_sp_name,
        		@i_num   = 141200
		   return 1
		end  
  
if @i_operacion = 'I'
begin

   if exists( select 1 
                from pf_aut_spread
               where as_fecha     = @s_date
                 and as_operacion = @i_as_operacion
                 and as_estado    = 'V')
   begin
	   delete from pf_aut_spread
	       where as_fecha     = @s_date
                 and as_operacion = @i_as_operacion
                 and as_estado    = 'V'
	   if @@error <> 0
	   begin 
	      exec cobis..sp_cerror
	           @t_debug = @t_debug,
	           @t_file  = @t_file,
	           @t_from  = @w_sp_name, 
	           @i_num   = 141187
	      return  141187
	   end
   end
   ------------------------------------------------
   -- Insercion de datos de autorizacion de Spread   
   ------------------------------------------------
   insert into cob_pfijo..pf_aut_spread(as_secuencial ,   as_operacion,    as_spread       , 
                                        as_operador,     as_fecha,        as_estado      , as_usuario)
                                 values(@s_ssn,          @i_as_operacion, @i_as_spread    , 
                                        @i_as_operador,  @s_date, 	  @i_as_estado   , @s_user)
   if @@error <> 0
   begin
      select @w_error = 149065
      goto ERROR
   end

end

if @i_operacion = 'U'
begin
 
   select @w_as_estado = as_estado
     from pf_aut_spread
    where as_operacion   = @i_as_operacion
      and as_fecha       = @s_date
   
   if @w_as_estado = 'U' --Si ya fue utilizado
   begin 
      exec cobis..sp_cerror
           @t_debug = @t_debug,
           @t_file  = @t_file,
           @t_from  = @w_sp_name, 
           @i_num   = 141185
      return  1
   end

   update pf_aut_spread
      set as_spread      = @i_as_spread,
          as_operador    = @i_as_operador
    where as_operacion   = @i_as_operacion
      and as_fecha       = @s_date

   if @@error <> 0
   begin
      select @w_error = 141187
      goto ERROR
   end
end
return 0

-------------------
-- Manejo de error
-------------------
ERROR:
   rollback tran
   exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name, 
        @i_num   = @w_error
   return  1
go

go
