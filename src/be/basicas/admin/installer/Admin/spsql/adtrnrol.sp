/**************************************************************************/
/*   Archivo:                     adtrnrol.sp                             */
/*   Stored Procedure:            sp_query_tran_rol                       */
/*   Base de datos:               cobis                                   */
/*   Producto:                    Administrador                           */
/*   Disenado por:                Sandra Ortiz                            */ 
/*   Fecha de escritura:          20 Enero de 1994                        */
/**************************************************************************/
/*                             IMPORTANTE                                 */
/*   Este programa es parte de los paquetes bancarios propiedad de        */
/*   "MACOSA", representantes exclusivos para el Ecuador de la            */
/*   "NCR CORPORATION".                                                   */
/*   Su uso no autorizado queda expresamente prohibido asi como cualquier */
/*   alteracion o agregado hecho por alguno de sus usuarios sin el debido */
/*   consentimiento por escrito de la preseidencia ejecutiva de MACOSA    */
/*   o su representante.                                                  */
/**************************************************************************/
/*                             PROPOSITO                                  */
/*   Este stored procedure permite obtener todos las transacciones a las   */
/*   que tiene acceso un usuario dado su rol, producto y la moneda en la  */   
/*   cual trabaja.                                                        */
/**************************************************************************/
/*                            MODIFICACIONES                              */
/*   FECHA               AUTOR           RAZON                            */
/*   20-01-94		  JBU		 Escritura inicial		  */
/**************************************************************************/
use cobis
go

if exists (select * from sysobjects where name = 'sp_query_tran_rol')
  drop proc sp_query_tran_rol








go
create proc sp_query_tran_rol (
	@s_ssn		int,
	@s_srv		varchar(30) = null,
	@s_lsrv         varchar(30) = null,
	@s_user		varchar(30) = null,
	@s_sesn         int,
	@s_term		varchar(10),
	@s_date		datetime,
	@s_org		char(1),
	@s_ofi		tinyint = 1,
	@s_rol		smallint = 1, 
	@s_org_err	char(1) = null,
        @s_error        int = null,
        @s_sev		tinyint = null,
	@s_msg		mensaje = null,
        @t_debug	char(1) ='N',
        @t_file		varchar(14) = null,
        @t_from		descripcion = null,
	@t_rty		char(1) = 'N',
        @i_rol          tinyint,
        @i_prod         tinyint,
        @i_mon          tinyint,
        @i_sectrn       smallint = null, 
        @i_modo         tinyint = null
)
as

/*  declaracion de las variables de trabajo  */

declare
        @w_sp_name      varchar(30),
	@w_return	int

select @w_sp_name = 'sp_query_tran_rol'

/*  procedimiento para el debug del stored procedure  */


/* query para obtener las transacciones disponibles para un producto para */
/* un rol y una moneda dada                                               */

if @i_modo = 0 
  begin
    set rowcount 20
    select    'CODIGO'      = ta_transaccion,
              'NEMONICO'    = tn_nemonico,
              'TRANSACCION' = tn_descripcion
      from    cobis..ad_tr_autorizada,
              cobis..cl_ttransaccion
     where    ta_producto    = @i_prod
       and    ta_moneda      = @i_mon
       and    ta_rol         = @i_rol
       and    ta_transaccion = tn_trn_code
  end
else
  begin
    set rowcount 20
    select    'CODIGO'      = ta_transaccion,
              'NEMONICO'    = tn_nemonico,
              'TRANSACCION' = tn_descripcion
      from    cobis..ad_tr_autorizada,
              cobis..cl_ttransaccion
     where    ta_producto    = @i_prod
       and    ta_moneda      = @i_mon
       and    ta_rol         = @i_rol
       and    ta_transaccion = tn_trn_code
       and    ta_transaccion > @i_sectrn
  end

  if @@rowcount = 0
    begin
      exec cobis..sp_cerror
       	 /*  No existen transacciones autorizadas para el rol dado */
  	@t_debug	= @t_debug,
	@t_file		= @t_file,
	@t_from		= @w_sp_name,
	@i_num		= 901079
      return 1
    end

  set rowcount 0
  return 0

go
