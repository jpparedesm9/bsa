/************************************************************************/
/*	Archivo: 		cccupofi.sp				*/
/*	Stored procedure: 	sp_tr_up_oficiales                      */
/*	Base de datos:  	cobis				        */
/*	Producto:               Cuentas Corrientes			*/
/*	Disenado por:           Julio Navarrete   			*/
/*	Fecha de escritura:     13-Dic-1994				*/
/************************************************************************/
/*				IMPORTANTE				*/
/*	Este programa es parte de los paquetes bancarios propiedad de	*/
/*	"MACOSA", representantes exclusivos para el Ecuador de la 	*/
/*	"NCR CORPORATION".						*/
/*	Su uso no autorizado queda expresamente prohibido asi como	*/
/*	cualquier alteracion o agregado hecho por alguno de sus		*/
/*	usuarios sin el debido consentimiento por escrito de la 	*/
/*	Presidencia Ejecutiva de MACOSA o su representante.		*/
/************************************************************************/
/*				PROPOSITO				*/
/*	Este programa realiza la transaccion de consulta de oficiales   */
/*	de credito.                                                     */
/************************************************************************/
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*	04/Ene/1995     A. Villarreal	Emision inicial para Banco de   */
/*                                      la Produccion                   */
/************************************************************************/
use cobis
go

if exists (select * from sysobjects where name = 'sp_tr_up_oficiales')
        drop proc sp_tr_up_oficiales








go
create proc sp_tr_up_oficiales (
	@s_ssn          int,
	@s_srv          varchar(30),
	@s_lsrv         varchar(30),
	@s_user         varchar(30),
	@s_sesn         int,
	@s_term         varchar(32),
	@s_date         datetime,
	@s_ofi          smallint,
	@s_rol          smallint = 1,
	@s_org_err      char(1)  = null,
	@s_error        int      = null,
	@s_sev          tinyint  = null,
	@s_msg          mensaje  = null,
	@s_org          char(1),
        @t_rty          char(1) = 'N',
        @t_from         char(1) = null,
	@t_debug	char(1) = 'N',
	@t_file		char(1) =  null,
	@t_trn		smallint,
	@i_oficial 	smallint = 0
)
as
declare @w_sp_name	descripcion,
        @w_fu_nombre	descripcion,
        @w_nom_sector   descripcion

/*  Captura nombre de Stored Procedure  */

select	@w_sp_name = 'sp_tr_up_oficiales'


/* Esta transaccion permite consultar los oficiales de un determinado nivel */
/* y dado su oficial de credito superior                                    */

 select @w_fu_nombre = fu_nombre
   from cobis..cl_funcionario,
        cobis..cc_oficial
  where oc_oficial = (select oc_ofi_nsuperior
                        from cobis..cc_oficial 
                       where oc_oficial = @i_oficial)
    and oc_funcionario = fu_funcionario

  select @w_nom_sector  = valor
    from cobis..cl_catalogo x,
         cobis..cl_tabla y
   where x.codigo = (select oc_sector
                       from cobis..cc_oficial 
                      where oc_oficial = @i_oficial)
     and y.codigo = x.tabla
     and y.tabla = "cc_sector"
  if @@rowcount = 0
     select @w_nom_sector = 'SECTOR SIN NOMBRE'

--JSB 2002-12-27 Eliminacion de subquerys en seccion de recuperacion de campos
--Migracion Oracle

 select oc_funcionario,
        fu_nombre,
        oc_tipo_oficial,
        valor,
        oc_ofi_nsuperior,
	@w_fu_nombre,
        oc_sector,
        @w_nom_sector
   from cobis..cc_oficial z, cobis..cl_funcionario,
        cobis..cl_tabla a, cobis..cl_catalogo b
   where oc_oficial = @i_oficial  
   and   a.codigo = b.tabla
   and   a.tabla  = "cc_tipo_oficial"
   and   b.codigo = oc_tipo_oficial
   and   oc_funcionario = fu_funcionario

--JSB

/*
 select oc_funcionario,
        (select fu_nombre
           from cobis..cl_funcionario
          where z.oc_funcionario = fu_funcionario),
        oc_tipo_oficial,
        (select valor
           from cobis..cl_catalogo x,
                cobis..cl_tabla y
          where x.codigo = z.oc_tipo_oficial
            and y.codigo = x.tabla
            and y.tabla = "cc_tipo_oficial" ),
        oc_ofi_nsuperior,
	@w_fu_nombre,
        oc_sector,
        @w_nom_sector
   from cobis..cc_oficial z
  where oc_oficial = @i_oficial 
*/

return 0
go
