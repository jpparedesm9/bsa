/**************************************************************************/
/*   Archivo:                     adprorol.sp                             */
/*   Stored Procedure:            sp_query_pro_rol                        */
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
/*   Este stored procedure permite obtener todos los productos a los       */
/*   tiene acceso un usuario dado su rol y la moneda en la cual trabaja.  */
/**************************************************************************/
/*                            MODIFICACIONES                              */
/*   FECHA               AUTOR           RAZON                            */
/*   20-01-94		  JBU		 Escritura inicial		  */
/**************************************************************************/
use cobis
go

if exists (select * from sysobjects where name = 'sp_query_pro_rol')
  drop proc sp_query_pro_rol








go
create proc sp_query_pro_rol (
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
        @i_mon          tinyint
)
as

/*  declaracion de las variables de trabajo  */

declare
        @w_rol          varchar(3),
	@w_mon          smallint,
        @w_sp_name      varchar(30),
	@w_return	int

select @w_sp_name = 'sp_query_pro_rol'

/*  procedimiento para el debug del stored procedure  */


/* query para obtener los productos disponibles para un rol */
/* y una moneda dada                                        */

  set rowcount 20

  select    'CODIGO'     = pr_producto,
            'PRODUCTO'   = pd_descripcion
    from    cobis..ad_pro_rol,
            cobis..cl_producto
   where    pr_rol    = @i_rol
     and    pr_moneda = @i_mon
     and    pr_producto = pd_producto 

  if @@rowcount = 0
    begin
      exec cobis..sp_cerror
       	 /*  No existen bancos corresponsales ubicados en la ciudad */
  	@t_debug	= @t_debug,
	@t_file		= @t_file,
	@t_from		= @w_sp_name,
	@i_num		= 901079
      return 1
    end

  set rowcount 0
  return 0

go
