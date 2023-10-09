/***********************************************************************/
/*     Archivo:                sp_device.sp                */
/*     Stored procedure:       sp_device                   */
/*     Base de datos:          cob_sincroniza                          */
/*     Producto:               Cobis                                   */
/*     Disenado por:                                                   */
/*     Fecha de escritura:     10/Nov/2015                             */
/***********************************************************************/
/*                         IMPORTANTE                                  */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad       */
/*  de COBISCorp.                                                      */
/*  Su uso no    autorizado queda  expresamente   prohibido asi como   */
/*  cualquier    alteracion o  agregado  hecho por    alguno  de sus   */
/*  usuarios sin el debido consentimiento por   escrito de COBISCorp.  */
/*  Este programa esta protegido por la ley de   derechos de autor     */
/*  y por las    convenciones  internacionales   de  propiedad inte-   */
/*  lectual.    Su uso no  autorizado dara  derecho a    COBISCorp para*/
/*  obtener ordenes  de secuestro o  retencion y para  perseguir       */
/*  penalmente a los autores de cualquier   infraccion.                */
/***********************************************************************/
/*                              PROPOSITO                              */
/*     Este programa contiene la gestion de la entidad  SpDevice       */
/***********************************************************************/
/*                              MODIFICACIONES                         */
/*     FECHA             AUTOR                 RAZON                   */
/*     10/Nov/2015                             Emision inicial         */
/***********************************************************************/

use cob_sincroniza
go

if object_id('sp_device') is not null
begin
    drop procedure sp_device
end
go


create proc sp_device(
  @t_show_version            bit           = 0,
  @i_operacion               char(1),              -- Opcion con la que se ejecuta el programa
  @t_debug                   char(1)       = 'N',
  @t_file                    varchar(10)   = null,
  @i_alias                   varchar(45)   = null,
  @i_device_id               varchar(45)   = null,
  @i_login                   varchar(25)   = null,
  @i_status                  char          = null,
  @i_ret_fu_nombre           bit            = 0,
  @i_first_time				 tinyint		= 0

)
as
declare @w_sp_name                    varchar(32),
		@w_allow_update				  char(1),
		@w_usuario_gmail           varchar(10)

select @w_sp_name = 'sp_device'
/*--VERSIONAMIENTO--*/
if @t_show_version = 1
   begin
      print 'Stored procedure ' + @w_sp_name + ' Version 4.0.0.35'
      return 0
   end
/*--FIN DE VERSIONAMIENTO--*/
 


/*get status*/
if @i_operacion = 'M'
begin
  select @w_usuario_gmail =  valor from cobis..cl_catalogo where tabla = (select codigo from cobis..cl_tabla where tabla = 'cl_usuario_google') and codigo = 'usrb2b' and estado = 'V'

  select @w_allow_update = di_permitir_matricula
  from cob_sincroniza..si_dispositivo
  where di_login  = @i_login
  AND di_permitir_matricula = 'S'
  
  if(@w_allow_update = 'S' and @i_first_time = 1)
  begin
  
	if exists (select 1 from si_dispositivo
	          where di_imei = @i_device_id and di_estado in ('P','R')) begin
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 2109106 --EL DISPOSITIVO ESTA ASIGNADO A OTRO OFICIAL Y SE ENCUENTRA ACTIVO
		return 2109106
	end
	
	update cob_sincroniza..si_dispositivo
	set di_imei = @i_device_id
	where di_login  = @i_login
	AND di_permitir_matricula = 'S'
  end
  
  if @i_login <> isnull(@w_usuario_gmail,'0')
  begin
     select de_status = di_estado
     from cob_sincroniza..si_dispositivo
     where di_imei   = @i_device_id 
     and   di_login  = @i_login
     and   di_estado in ('P','R')
  end
  ELSE
  BEGIN
     select de_status = 'R'
  end
 
  if @@rowcount = 0 begin
	 
	 select de_status = di_estado
	 from cob_sincroniza..si_dispositivo
	 where di_imei   = @i_device_id 
	 and   di_login  = @i_login
	 
	 
  end
  
  update cob_sincroniza..si_dispositivo
	set di_permitir_matricula 	= 'N'
	where di_imei   				= @i_device_id 
	and   di_login  				= @i_login
	AND   di_permitir_matricula 	= 'S'
	


  
end
/*register*/
if @i_operacion = 'R'
begin

  select *
  from cob_sincroniza..si_dispositivo
    where di_imei=@i_device_id 
    and di_login = @i_login

  if @@rowcount = 0
  begin
  exec cobis..sp_cerror
  @t_debug = @t_debug,
  @t_file = @t_file,
  @t_from = @w_sp_name,
  @i_num = 101018
  /* No existe device */
  return 1
  end

  update cob_sincroniza..si_dispositivo 
    set di_estado='R',
    di_alias=@i_alias
    where di_imei=@i_device_id 
    and di_login = @i_login


/* Si no se puede insertar error */
  if @@error != 0
  begin exec cobis..sp_cerror
   @t_debug = @t_debug,
   @t_file = @t_file,
   @t_from = @w_sp_name,
   @i_num = 103018
  /* 'Error en la actualizacion de estado sp_device'*/
  return 1
  end
end

--if @i_ret_fu_nombre = 1
--  begin
      select fu_nombre from cobis..cl_funcionario where fu_login = @i_login
--      return 0
--  end

go


