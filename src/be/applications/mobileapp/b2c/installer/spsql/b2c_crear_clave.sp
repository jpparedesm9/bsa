use cob_bvirtual
go

if object_id('sp_crear_clave') is not null
begin
  drop procedure sp_crear_clave
  if object_id('sp_crear_clave') is not null
    print 'FAILED DROPPING PROCEDURE sp_crear_clave'
end
go


/******************************************************************************/
/*   ARCHIVO:         b2c_crear_clave.sp                                       */
/*   NOMBRE LOGICO:   sp_crear_clave                                          */
/*   PRODUCTO:        BANCAMOVIL                                              */
/******************************************************************************/
/*                                 IMPORTANTE                                 */
/* Este programa es parte de los paquetes bancarios propiedad de COBISCorp.   */
/* Su uso no autorizado queda expresamente prohibido asi como cualquier       */
/* alteracion o agregado hecho por alguno de usuarios sin el debido           */
/* consentimiento por escrito de la Presidencia Ejecutiva de COBISCorp        */
/* o su representante.                                                        */
/******************************************************************************/
/*                     PROPOSITO                                              */
/*   Creación clave temporal mobile banking                                   */
/*                                                                            */
/******************************************************************************/
/*                              MODIFICACIONES                                */
/******************************************************************************/
/*  FECHA       VERSION         AUTOR                      RAZON              */
/******************************************************************************/
/* 23/May/14     1.0.0.0        Iván Martínez           Emision Inicial       */
/* 07/Nov/17     1.0.0.1        Galo Quisigüiña         Valida cedula         */
/******************************************************************************/
create procedure sp_crear_clave( 
   @t_show_version          bit = 0,
   @s_date                  datetime = null,
   @s_srv                   varchar(30) = null,
   @s_ssn_branch            int = null,
   @s_ssn                   int = null,
   @s_servicio              tinyint = 8,
   @s_culture               varchar(10) = 'ES-EC', --se debe enviar la cultura del dispositivo en @i_servicio
   @t_trn                   int,
   @t_debug                 char(1) = 'N',
   @t_file                  varchar(14) = null,
   @t_from                  varchar(32) = null,
   @i_operacion             char(1),
   @o_lo_cambiar_login      char(1) = null out,
   @i_ente_ib               int = 0,
   @i_servicio              tinyint = null,
   @i_login                 varchar(64) = null,
   @i_clave_temp            varchar(64) = null,
   @i_clave_def             varchar(64) = null,
   @i_clave                 varchar(64) = null,
   @i_numero_tarjeta        varchar(64) = null, -- numero de tarjeta de debito
   @i_pin_tarjeta           varchar(4) = null,   -- pin de la tarjeta de debito
   @i_cedula                varchar(10) = null,   -- numero de cedula 
   @i_valida_ced            char(1) = 'N',   -- Valida cedula
   @o_ente                  int = null out,   
   @o_login                 varchar(64) = null out,
   @o_provider              varchar(10) = null out 
)

as

declare
    @w_sp_name            varchar(64),
	@w_return             int,
    @w_producto           tinyint,
	@w_servicio			  tinyint

select @w_sp_name = 'sp_crear_clave'

--PRODUCTO BANCA VIRTUAL PARA NOTIFICACION
select @w_producto = 18

-- Mostrar la version del programa
if @t_show_version = 1
begin
   print 'Stored procedure = ' + @w_sp_name + '1.0.0.1'
   return 0
end

---- INTERNACIONALIZACION ----
EXEC cobis..sp_ad_establece_cultura
    @o_culture = @s_culture OUT
	
-- Modo de debug
if @t_trn != 17007
begin
-- Error en codigo de transaccion 
   exec cobis..sp_cerror
      @t_debug     = @t_debug,
      @t_file      = @t_file,
      @t_from      = @w_sp_name,
 @i_num       = 17001
   return 1
end

-- CREACION DE CLAVE TEMPORAL
	if @i_operacion = 'C' 
	begin

		-- se asume login unico
		if exists (select 1 
			from bv_login
			where (lo_servicio = 0 or lo_servicio = 1 or lo_servicio = 8)
				and lo_login = @i_login)
		begin
			update bv_login
			set lo_clave_temp = @i_clave_temp,
				lo_cambiar_login = 'S',
				lo_clave_def = null
			where (lo_servicio = 0 or lo_servicio = 1 or lo_servicio = 8)
				and lo_login = @i_login
				
			select @i_ente_ib = lo_ente, @w_servicio = lo_servicio from bv_login where (lo_servicio = 0 or lo_servicio = 1 or lo_servicio = 8) and lo_login = @i_login			
			/*
			if (@i_ente_ib != 0)	
			begin
			   exec @w_return = cob_bvirtual..sp_bv_enviar_notif_ib
					@s_culture        = @s_culture,
					@s_date           = @s_date,
					@t_show_version   = 0,
					@i_servicio       = @w_servicio,--@i_servicio,
					@i_ente_ib        = @i_ente_ib,      --Codigo IB de cliente
					@i_notificacion   = 'N104',           --Codigo de la notificacion
					@i_producto       = 18,        --Codigo del producto
					@i_num_producto   = '',          --Numero del producto
					@i_tipo_mensaje   = 'F',    --Tipo de mensaje a enviar E-Mensaje de Error F-mensaje de finalizada correctamente la transaccion I-Mensaje para oficiales o funcionarios del banco
					@i_f              = '@i_f',
					@i_aux1           = 'aux1',
					@i_aux2           = 'aux2',
					@i_aux3           = @i_clave,
					@i_aux4           = 'aux4',
					@i_login          = @i_login, --DSA LOGIN DE USUARIO																				
					@i_tipo 		  = 'M'
					

			   if @w_return <> 0
			   begin
				  -- Error al enviar correo electr=nico de Generaci=n de Contraseña
				  exec cobis..sp_cerror
					@t_from  = @w_sp_name,
					@i_num   = 1850357
				  return 1850357
			   end
			end   */
		end
		else
		begin
			exec cobis..sp_cerror
			 @t_from  = @w_sp_name,
			 @i_num   = 17026
			return 17026 --Error al crear clave temporal
		end

	end 
	
	--<C1> : Desde aqui cambios ClearMinds
	if @i_operacion = 'A' 
	begin

		-- se asume login unico
		if exists (select 1 
			from bv_login
			where (lo_servicio = 1 or lo_servicio = 0 or lo_servicio = 8)
				and lo_login = @i_login
		)
		begin
			update bv_login
			set lo_clave_temp = @i_clave_temp,
				lo_cambiar_login = 'N',
				lo_clave_def = @i_clave_temp
			where (lo_servicio = 1 or lo_servicio = 0 or lo_servicio = 8)
				and lo_login = @i_login
		end
		else
		begin
			exec cobis..sp_cerror
			 @t_from  = @w_sp_name,
			 @i_num   = 17026
			return 17026 --Error al crear clave temporal
		end

	end
		
	if @i_operacion = 'D' 
	begin
		if exists(
			select 1 from cob_atm..tm_tarjeta where ta_codigo = @i_numero_tarjeta --aqui falta implementar el PIN de la tarjeta
		)
		begin 
			select @o_ente = ta_cliente from cob_atm..tm_tarjeta where ta_codigo = @i_numero_tarjeta --aqui falta implementar el PIN de la tarjeta
			return 0
		end 
		else 
		begin
			return 1875104 --1875104 : EL NUMERO DE TARJETA DE CREDITO ES INVALIDO
		end
	end	
	
	if @i_operacion = 'T' 
	begin
		if(@i_valida_ced = 'S')
		begin
			if exists(select 1 from bv_login join bv_ente on bv_login.lo_ente = bv_ente.en_ente where lo_login =  @i_login and (lo_servicio = 1 or lo_servicio = 0 or lo_servicio = 8) and en_ced_ruc = @i_cedula)
			begin 
				select @o_ente = lo_ente from bv_login join bv_ente on bv_login.lo_ente = bv_ente.en_ente where lo_login =  @i_login and (lo_servicio = 1 or lo_servicio = 0 or lo_servicio = 8) and en_ced_ruc = @i_cedula

				return 0
			end 
			else 
			begin
				exec cobis..sp_cerror
				@t_from = @w_sp_name,
				@i_num  = 1875000,
				@s_culture = @s_culture
				return 1875000 --1875000 : LOGIN NO AUTORIZADO O NO EXISTE
			end
		end
		else
		begin
			if exists(select 1 from  bv_login where lo_login = @i_login and (lo_servicio = 1 or lo_servicio = 0 or lo_servicio = 8))
			begin 
				select @o_ente = lo_ente from  bv_login where lo_login = @i_login and (lo_servicio = 1 or lo_servicio = 0 or lo_servicio = 8)
				return 0
			end 
			else 
			begin
				exec cobis..sp_cerror
				@t_from = @w_sp_name,
				@i_num  = 1875000,
				@s_culture = @s_culture
				return 1875000 --1875000 : LOGIN NO AUTORIZADO O NO EXISTE
			end
		end
	end
	
	if @i_operacion = 'L' 
	begin
		if exists(
			--select 1 from bv_login where (lo_servicio = 1 or lo_servicio = 0) and lo_num_doc = @i_cedula
			select 1 from bv_login join bv_ente on bv_login.lo_ente = bv_ente.en_ente where lo_login =  @i_login and (lo_servicio = 1 or lo_servicio = 0 or lo_servicio = 8) and en_ced_ruc = @i_cedula

		)
		begin
			select @o_login = lo_login from bv_login join bv_ente on bv_login.lo_ente = bv_ente.en_ente where lo_login =  @i_login and (lo_servicio = 1 or lo_servicio = 0 or lo_servicio = 8) and en_ced_ruc = @i_cedula
			select @i_ente_ib = lo_ente from bv_login join bv_ente on bv_login.lo_ente = bv_ente.en_ente where lo_login =  @i_login and (lo_servicio = 1 or lo_servicio = 0 or lo_servicio = 8) and en_ced_ruc = @i_cedula
			
			
			/*if (@i_ente_ib != 0)
			begin
				exec @w_return = cob_bvirtual..sp_bv_enviar_notif_ib
				@s_culture        = @s_culture,
				@s_date           = @s_date,
				@t_show_version   = 0,
				@i_servicio       = @i_servicio,
				@i_ente_ib        = @i_ente_ib,      --Codigo IB de cliente
				@i_notificacion   = 'N104',           --Codigo de la notificacion
				@i_producto       = 18,        --Codigo del producto
				@i_num_producto   = '',          --Numero del producto
				@i_tipo_mensaje   = 'F',    --Tipo de mensaje a enviar E-Mensaje de Error F-mensaje de finalizada correctamente la transaccion I-Mensaje para oficiales o funcionarios del banco
				@i_f              = '@i_f',
				@i_aux1           = 'aux1',
				@i_aux2           = 'aux2',
				@i_aux3           = @i_clave,
				@i_aux4           = 'aux4',
				@i_login          = @i_login --DSA LOGIN DE USUARIO
				
				
				if @w_return <> 0
				begin
				  -- Error al enviar correo electr=nico de Generaci=n de Contraseña
				  exec cobis..sp_cerror
					@t_from  = @w_sp_name,
					@i_num   = 1850357
				  return 1850357
				end
				else
				begin
					exec cobis..sp_cerror
					 @t_from  = @w_sp_name,
					 @i_num   = 17026
					return 17026 --Error al crear clave temporal
				end
			end*/
		end
	end
	
	if @i_operacion = 'P' 
	begin
		if exists(
			select 1 from bv_login_authentication where (la_channel_id = 1 or la_channel_id = 0) and la_login = @i_login 
		)
		begin 
			select @o_provider = la_provider from bv_login_authentication where (la_channel_id = 1 or la_channel_id = 0) and la_login = @i_login 
			return 0
		end 
		else 
		begin
			return 1875000 --1875000 : LOGIN NO AUTORIZADO O NO EXISTE
		end
	end 
	--</C1> : Hasta aqui cambios ClearMinds

return 0

go