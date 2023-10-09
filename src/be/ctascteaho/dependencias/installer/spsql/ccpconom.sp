/************************************************************************/
/*  Archivo:                ccpconom.sp                                 */
/*  Stored procedure:       sp_tr_query_nom_ctacte                      */
/*  Base de datos:          cob_cuentas                                 */
/*  Producto:               Cuentas Corrientes                          */
/************************************************************************/
/*                              IMPORTANTE                              */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad        */
/*  de COBISCorp.                                                       */
/*  Su uso no    autorizado queda  expresamente   prohibido asi como    */
/*  cualquier    alteracion o  agregado  hecho por    alguno  de sus    */
/*  usuarios sin el debido consentimiento por   escrito de COBISCorp.   */
/*  Este programa esta protegido por la ley de   derechos de autor      */
/*  y por las    convenciones  internacionales   de  propiedad inte-    */
/*  lectual.    Su uso no  autorizado dara  derecho a    COBISCorp para */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir        */
/*  penalmente a los autores de cualquier   infraccion.                 */
/************************************************************************/
/*                              PROPOSITO                               */
/*  Este programa procesa la transaccion de:                            */
/*  Mantenimiento de Ruta y Transito.                                  */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*  FECHA           AUTOR           RAZON                               */
/*  04/07/2016      Jorge Salazar   Migracion a CEN                     */
/************************************************************************/
use cob_cuentas
go



if exists (select
             1
           from   sysobjects
           where  name = 'sp_tr_query_nom_ctacte')
  drop proc sp_tr_query_nom_ctacte
go


CREATE PROCEDURE sp_tr_query_nom_ctacte (
    @s_srv		      varchar(30),
    @s_lsrv		      varchar(30),
	@t_debug	      char(1) = 'N',
	@t_file		      varchar(14) = null,
	@t_from		      varchar(32) = null,
    @i_cerrada        char(1) = 'A',
	@i_cta		      varchar(14),
	@i_mon		      tinyint,
	@i_ger		      char(1) = null,
	@i_pasinac        char(1) = 'N'
)
as
declare	@w_return	  int,
	@w_sp_name	      varchar(30),
	@w_rpc		      varchar(64),
	@w_cuenta	      int,
	@w_filial	      tinyint,
	@w_oficina	      smallint,
	@w_producto	      tinyint,
	@w_srv_rem	      varchar(64),
	@w_srv_local	  varchar(64),
	@w_tipo		      char(1)
	
--Ver	 3 NR208
	
/*  Captura nombre de Stored Procedure  */
select	@w_sp_name = 'sp_tr_query_nom_ctacte'

if not exists(select 1
  from  cob_cuentas..cc_ctacte
 where  cc_cta_banco = @i_cta
   and  cc_moneda    = @i_mon)
begin
  /*  No existe Cuenta  */
  exec cobis..sp_cerror	
	@t_debug= @t_debug,
	@t_file	= @t_file,
	@t_from	= @w_sp_name,
	@i_num	= 201004 
  return 201004
end

/*  Modo de debug  */

/*  Captura de parametros de la oficina  */
exec @w_return = cobis..sp_parametros 
			@t_debug	= @t_debug,
			@t_file	        = @t_file,
			@t_from	        = @w_sp_name,
			@s_lsrv		= @s_lsrv,
            @i_nom_producto = 'CUENTA CORRIENTE',
			@o_oficina 	= @w_oficina out,
			@o_producto 	= @w_producto out
			
if @w_return <> 0
	return @w_return


/*  Determinacion de condicion de local o remoto  */
exec @w_return = cob_cuentas..sp_cta_origen 
			@t_debug	= @t_debug,
			@t_file	        = @t_file,
			@t_from	        = @w_sp_name,
			@i_cta		= @i_cta,
			@i_producto	= @w_producto,
		 	@i_mon	        = @i_mon, 
			@i_oficina	= @w_oficina,
 		 	@o_tipo		= @w_tipo out, 
			@o_srv_local	= @w_srv_local out,
			@o_srv_rem	= @w_srv_rem out

if @w_return <> 0
	return @w_return


select   @w_srv_local = @s_lsrv

select @w_rpc = 'sp_query_nom_ctacte'
if @w_tipo = 'L'
	select @w_rpc = 'cob_cuentas..' + @w_rpc
else
	select @w_rpc = @w_srv_local + '.' + @w_srv_rem + '.'
			+ 'cob_cuentas.' + @w_rpc

exec @w_return = @w_rpc
	@t_debug	= @t_debug,
	@t_file		= @t_file,
	@t_from		= @t_from,
	@i_cta		= @i_cta,
    @i_cerrada  = @i_cerrada,
	@i_mon		= @i_mon,
	@i_ger		= @i_ger,
	@i_pasinac  = @i_pasinac
if @w_return <> 0
begin
	rollback tran
	return @w_return
end
return 0


GO

