use cob_bvirtual
go

if object_id('sp_administra_token') is not null
begin
  drop procedure sp_administra_token
  if object_id('sp_administra_token') is not null
    print 'FAILED DROPPING PROCEDURE sp_administra_token'
end
go

/******************************************************************************/
/*   ARCHIVO:         sp_administra_token.sp                                 */
/*   NOMBRE LOGICO:   sp_administra_token                                    */
/*   PRODUCTO:        BANCAMOVIL                                             */
/******************************************************************************/
/*                                 IMPORTANTE                                 */
/* Este programa es parte de los paquetes bancarios propiedad de COBISCorp.   */
/* Su uso no autorizado queda expresamente prohibido asi como cualquier       */
/* alteracion o agregado hecho por alguno de usuarios sin el debido           */
/* consentimiento por escrito de la Presidencia Ejecutiva de COBISCorp        */
/* o su representante.                                                        */
/******************************************************************************/
/*                     PROPOSITO                                              */
/*   Operaciones para administrar Token                                       */
/*                                                                            */
/******************************************************************************/
/*                              MODIFICACIONES                                */
/******************************************************************************/
/*  FECHA       VERSION         AUTOR                      RAZON              */
/******************************************************************************/
/* 01/Nov/16     1.0.0.0        Gelen Romero      Emision Inicial             */
/* 29/Nov/16     1.0.0.1        GQU               OTP                         */
/* 13/03/17      1.0.0.2        GQU               Parametro vigencia token    */
/* 07/Nov/17     1.0.0.3        GQU               Actualizacion codigos error */
/******************************************************************************/
create procedure sp_administra_token(
   @t_show_version        bit = 0,
   @s_date                datetime = null,
   @s_srv                 varchar(30) = null,      
   @s_ssn_branch          int = null,
   @s_ssn                 int = null,
   @s_servicio            tinyint = 1,
   @t_trn                 int = 1875900,
   @t_debug               char(1) = 'N',
   @t_file                varchar(14) = null,
   @t_from                varchar(32) = null,
   @i_operacion           char(1),
   @i_login               varchar(128) = null,
   @i_token               varchar(256) = null,
   @i_canal               tinyint = 1,
   --@i_fecha_generacion    datetime      = null,
   @o_token_valido        varchar(256) = 'N' out
 
)
as

declare
    @w_sp_name            varchar(64),
    @w_return             int,
    @w_longitud_token     int,
	@w_tiempo_token       int,
	@w_tam_token          int,
	@w_fecha_token        datetime

select @w_sp_name = 'sp_administra_token'

-- Mostrar la version del programa
if @t_show_version = 1
begin
   print 'Stored procedure = ' + @w_sp_name + ' 1.0.0.3'
   return 0
end

-- Modo de debug
if @t_trn != 1875900 -- Transaccion
begin
-- Error en codigo de transaccion
   exec cobis..sp_cerror
      @t_debug     = @t_debug,
      @t_file      = @t_file,
      @t_from      = @w_sp_name,
      @i_num       = 17001
   return 1
end

if @i_operacion = 'Q' -- 
begin

select 
	@w_longitud_token = pa_int
from cobis..cl_parametro 
where pa_nemonico ='TAMT'
and pa_producto='BVI'

select 
	@w_tiempo_token = pa_int
from cobis..cl_parametro 
where pa_nemonico ='TVT'
and pa_producto='BVI'

select @w_tam_token=len(@i_token)


if @w_tam_token != 64 --Tamaño del token encriptado
begin
    /* Error longitud del token incorrecto */
	 exec cobis..sp_cerror
	@t_from  = @w_sp_name,
	@i_num   = 1890002
	return 1890002
end


select 
	@w_fecha_token=to_fecha_cre 
from cobis..se_token
where to_token_value = @i_token

select @w_fecha_token = dateadd(n, @w_tiempo_token, @w_fecha_token) -- fecha del token mas tiempo de vigencia


if getdate() > @w_fecha_token 
begin
    /* Error Token incorrecto */
	 exec cobis..sp_cerror
	@t_from  = @w_sp_name,
	@i_num   = 1890004
	return 1890004
end


   if exists (select 1 
              from cobis..se_token
              where to_servicio = @i_canal
               and  to_usuario  = @i_login
               and  to_token_value = @i_token)
               --and  to_fecha_cre =@i_fecha_generacion)
			   
			     begin    			   
			   
			       return 0
			  
			  
			     end
    else			  
			   
				begin
					exec cobis..sp_cerror
						@t_from  = @w_sp_name,
						@i_num   = 1890000
						return 1890000
                end
			 
			 
end

if @i_operacion = 'I' -- inserta
begin

	if exists (select 1 
	  from cobis..se_token
	  where to_servicio = @i_canal
	   and  to_usuario  = @i_login)
   
		 begin    			   
   
		   delete from cobis..se_token 
		   where to_servicio = @i_canal
		   and to_usuario = @i_login

		 end

    insert into cobis..se_token
    (to_servicio,to_usuario,to_token_value,to_fecha_cre)
    values
    (@i_canal,@i_login,@i_token,getdate())
  
    if @@error != 0
	begin
	   --rollback tran
	   /* Error en la insercion de datos*/
	   exec cobis..sp_cerror
	   @t_from  = @w_sp_name,
	   @i_num   = 1890001
	   return 1890001
	end
	
end

return 0

go