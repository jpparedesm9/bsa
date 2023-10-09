/*************************************************************************/
/*   Archivo:              sp_aceptacion.sp                              */
/*   Stored procedure:     sp_aceptacion                                 */
/*   Base de datos:        cobis                                         */
/*   Producto:             Clientes                                      */
/*   Disenado por:         KVI                                           */
/*   Fecha de escritura:   25 Enero 2023                                 */
/*************************************************************************/
/*                           IMPORTANTE                                  */
/*   Este programa es parte de los paquetes bancarios propiedad de       */
/*   'COBIS'.                                                            */
/*   Su uso no autorizado queda expresamente prohibido asi como          */
/*   cualquier alteracion o agregado hecho por alguno de sus usuarios    */
/*   sin el debido consentimiento por escrito de la Presidencia          */
/*   Ejecutiva de COBIS o su representante legal.                        */
/*************************************************************************/
/*                           PROPOSITO                                   */
/*   Manejo de Tabla de Log de Auditoria para Tipos de Aceptacion        */
/*************************************************************************/
/*                           CAMBIOS                                     */
/* 25/Ene/2023    KVI    Emision Inicial                                 */
/* 14/Mar/2023    ALL    Recepcion de fecha de aceptacion                */
/*************************************************************************/

use cobis
go

if exists (select 1 from sysobjects where name = 'sp_aceptacion')
   drop proc sp_aceptacion
go

create proc sp_aceptacion(
    @s_ssn             int         = null,
    @s_user            login       = null,
    @s_sesn            int         = null,
    @s_term            varchar(30) = null,
    @s_date            datetime    = null,
    @s_srv             varchar(30) = null,
    @s_lsrv            varchar(30) = null,
    @s_rol             smallint    = null,
    @s_ofi             smallint    = null,
    @s_org_err         char(1)     = null,
    @s_error           int         = null,
    @s_sev             tinyint     = null,
    @s_msg             descripcion = null,
    @s_org             char(1)     = null,
    @t_debug           char(1)     = 'N',
    @t_file            varchar(10) = null,
    @t_from            varchar(32) = null,
	@t_trn             smallint    = null,
	@i_cliente         int,
	@i_operacion       char(1)     = 'I',
	@i_aceptacion      varchar(10) = null,
	@i_resultado       char(1)     = null,
	@i_canal           int         = null,
	@i_fecha_aceptacion varchar(50)   = null
)
as
declare 
@w_error           int,
@w_return          int,
@w_mensaje         varchar(255),
@w_sp_name         varchar(30),
@w_msg             varchar(255),
@w_oficina_asesor  int


select @w_sp_name = 'sp_aceptacion'


if (@i_operacion = 'I')
begin
  select @w_oficina_asesor = fu_oficina from cl_funcionario
  where fu_login = @s_user
  
  if not exists (select 1 from cobis..cl_log_aceptacion 
                 where ta_ente            = @i_cliente 
				 and   ta_tipo_aceptacion = @i_aceptacion 
				 and   ta_login_asesor    = @s_user)
  begin  
    insert into cl_log_aceptacion (
        ta_fecha_registro,  ta_tipo_aceptacion,  ta_resultado,      ta_fecha_aceptacion,  ta_canal,
        ta_ente,            ta_login_asesor,     ta_oficina_asesor
	) values (
	    getdate(),          @i_aceptacion,       @i_resultado,      ISNULL(convert(datetime,@i_fecha_aceptacion,103), getdate()),  @i_canal,
		@i_cliente,         @s_user,             @w_oficina_asesor
    )	

    if @@error <> 0 begin
        select @w_error = 70129
		goto ERROR
    end  
  end
  else 
  begin
    update cl_log_aceptacion
	set ta_resultado         = @i_resultado,
	    ta_fecha_aceptacion  = ISNULL(convert(datetime,@i_fecha_aceptacion,103), getdate())
	where ta_ente            = @i_cliente
	and   ta_tipo_aceptacion = @i_aceptacion
	and   ta_login_asesor    = @s_user
	
	if @@error <> 0 begin
        select @w_error = 276005
		goto ERROR
    end 
  end
  
end

return 0


ERROR:

exec @w_return = cobis..sp_cerror
@t_debug  = 'N',
@t_file   = '',
@t_from   = @w_sp_name,
@i_num    = @w_error

return @w_error

go