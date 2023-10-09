/******************************************************************************/
/* Archivo:            b2c_mantenimiento_login.sp                             */
/* Stored procedure:   sp_b2c_mantenimiento_login                             */
/* Base de datos:      cob_bvirtual                                           */
/* Producto:           VIRTUAL BANKING                                        */
/* Disenado por:       KVI                                                    */
/* Fecha de escritura: Jul/2022                                               */
/******************************************************************************/
/*                                 IMPORTANTE                                 */
/* Este programa es parte de los paquetes bancarios propiedad de COBISCorp.   */
/* Su uso no autorizado queda expresamente prohibido asi como cualquier       */
/* alteracion o agregado hecho por alguno de usuarios sin el debido           */
/* consentimiento por escrito de la Presidencia Ejecutiva de COBISCorp        */
/* o su representante.                                                        */
/******************************************************************************/
/*                                PROPOSITO                                   */
/* Operaciones de mantenimiento del login                                     */
/******************************************************************************/
/*                                MODIFICACIONES                              */
/* FECHA            AUTOR               RAZON                                 */
/* 13-Jul-2022      KVI              Emision inicial                          */
/******************************************************************************/
use cob_bvirtual
go

if object_id('sp_b2c_mantenimiento_login') is not null
    drop proc sp_b2c_mantenimiento_login
go

create proc sp_b2c_mantenimiento_login(
	@s_ssn           int          = null,
	@s_sesn          int          = null,
	@s_date          datetime     = null,
	@s_user          varchar(14)  = null,
	@s_term          varchar(30)  = null,
	@s_ofi           smallint     = null,
	@s_srv           varchar(30)  = null,
	@s_lsrv          varchar(30)  = null,
	@s_rol           smallint     = null,
	@s_org           varchar(15)  = null,
	@s_culture       varchar(15)  = null,
	@t_rty           char(1)      = null,
	@t_debug         char(1)      = 'N',
	@t_file          varchar(14)  = null,
	@t_trn           int          = null,
	@i_operacion     varchar(1)   = null,
	@i_ente_mis      int,
	@i_celular       varchar(20),
    @i_canal         varchar(30)  = ''	
)	
as
declare @w_return             int,
		@w_sp_name            varchar(30),
        @w_version            char(8),
		@w_fecha_proceso      datetime,
		@w_login              varchar(64),
		@w_ente               int,
        @w_ente_login         int,
        @w_descripcion        varchar(64)		
		
			
select @w_sp_name = 'sp_b2c_mantenimiento_login'

select @s_user = isnull(@s_user, 'b2cuser')
select @w_fecha_proceso = fp_fecha from cobis..ba_fecha_proceso
select @s_date = isnull(@s_date, @w_fecha_proceso)

if @i_operacion = 'E'
begin
  select @w_ente = en_ente
  from   cob_bvirtual..bv_ente 
  where  en_ente_mis = @i_ente_mis
  
  select @w_login      = lo_login,
         @w_ente_login = lo_ente
  from   cob_bvirtual..bv_login
  where  lo_login = @i_celular
  
  if exists (select 1 from cob_bvirtual..bv_login where lo_login = @i_celular and (lo_ente <> @w_ente or @w_ente is null))
  begin    
  	update bv_login
  	set lo_fecha_mod  = @s_date, 
  		lo_hora       = getdate(), 
  		lo_estado     = 'E'
  	where lo_login = @w_login
	
	select @w_descripcion = @i_canal + ' - Cambio Estado'
  	
  	insert into cob_bvirtual..ts_login(
  		secuencial,     cod_alterno,   tipo_transaccion, clase,      fecha,      
		usuario,        terminal,      oficina,          tabla,      lsrv, 
		srv,            ente,  		   login,            fecha_mod,  hora,                            	
		descripcion     
	)                                       
  	values (                                                         
  		@s_ssn,         5,             18548,    	     'E',        @s_date, 
		@s_user,        @s_term,       @s_ofi,           'bv_login', @s_lsrv, 
		@s_srv,         @w_ente_login, @w_login,         getdate(),  convert(varchar(8), getdate(),108), 
		@w_descripcion
	)   
  
    if @@error != 0
    begin
    -- Error en la insercion en la tabla de servicio
  	 exec cobis..sp_cerror
  	  @t_from  = @w_sp_name,
  	  @i_num   = 1850034
  	return 1
    end			
  end
end
 
return 0

go
