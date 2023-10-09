/*************************************************************************/
/*   Archivo:            sp_mapear_errores_biometricos.sp                */
/*   Stored procedure:   sp_mapear_errores_biometricos                   */
/*   Autor:              Javier Ariza                                    */
/*   Base de datos:      cob_cartera                                    */
/*************************************************************************/
/*                                  IMPORTANTE                           */
/*   Este programa es parte de los paquetes bancarios propiedad de       */
/*   "MACOSA", representantes exclusivos para el Ecuador de NCR          */
/*   Su uso no autorizado queda expresamente prohibido asi como          */
/*   cualquier acion o agregado hecho por alguno de sus                  */
/*   usuarios sin el debido consentimiento por escrito de la             */
/*   Presidencia Ejecutiva de MACOSA o su representante.                 */
/*************************************************************************/
/*                                  PROPOSITO                            */
/*   Este procedimiento almacenado, realiza el mapeo de error Biocheck   */
/*   21/07/2022        AINCA           Modificación guardado de errores  */
/*************************************************************************/
use cob_cartera
go

if object_id ('sp_mapear_errores_biometricos') is not null
   drop procedure sp_mapear_errores_biometricos
go

create proc sp_mapear_errores_biometricos(
@s_ssn              int         = null,
@s_ofi              smallint    = null,
@s_user             login       = null,
@s_date             datetime    = null,
@s_srv              varchar(30) = null,
@s_term	            descripcion = null,
@s_rol              smallint    = null,
@s_lsrv	            varchar(30) = null,
@s_sesn	            int 	    = null,
@s_org              char(1)     = null,
@s_org_err          int 	    = null,
@s_error            int 	    = null,
@s_sev              tinyint     = null,
@s_msg              descripcion = null,
@t_rty              char(1)     = null,
@t_trn              int         = null,
@t_debug            char(1)     = 'N',
@t_file             varchar(14) = null,
@t_from             varchar(30) = null,
-- -------------------------------------------
@i_codigo_error     varchar(40), -- Codigo de Error
@i_cliente          int, -- Cliente,
@i_tramite          int         = null,
@o_resultado1	    varchar(255) = null output
) 
as
declare 
@w_sp_name   		   	varchar(32),
@w_catalogo_code       	varchar(32),
@w_catalogo_description	varchar(255),
@w_error               	int,
@w_msg                  varchar(255)

select @w_sp_name = 'sp_mapear_errores_biometricos'

select @w_catalogo_description= C.valor 
from   cobis..cl_tabla T, cobis..cl_catalogo C
where  T.tabla  = 'cl_respuesta_biometricos'
and    T.codigo = C.tabla
and    C.codigo= @i_codigo_error
and    C.estado = 'V'

if(@w_catalogo_description is null or @w_catalogo_description = '')
begin
   select @w_catalogo_description = 'El código de error no existe en el catálogo' 
end
else
begin
   select @w_catalogo_description = null;
end

print 'antes de insertar'
print '@s_user ' + convert(varchar(25),@s_user)
print '@i_codigo_error ' + convert(varchar(25),@i_codigo_error)
print '@i_cliente ' + convert(varchar(25),@i_cliente)

INSERT INTO cobis..cl_log_error_biometricos (eb_fecha_proceso, eb_usuario, eb_error_descripcion,     eb_error_code,    eb_cliente,  eb_tramite)
VALUES                               (GETDATE()       , @s_user,    @w_catalogo_description , @i_codigo_error,   @i_cliente, @i_tramite);

if @@error <> 0 
begin
	select @w_error = 150000, @w_msg = 'Error en la Insercion del Error Biometrico'
	goto ERROR
end
	
select @o_resultado1=@w_catalogo_description;
--print 'el resultado codigo interno es'+@o_resultado1

return 0		

ERROR:
exec cobis..sp_cerror
	@t_debug  = 'N',
	@t_file   = null,
	@t_from   = @w_sp_name,
	@i_num    = @w_error,
	@i_msg    = @w_msg
return @w_error