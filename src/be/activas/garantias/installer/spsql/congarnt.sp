/************************************************************************/
/*	Archivo: 	        congarnt.sp                             */ 
/*	Stored procedure:       sp_con_garante                          */ 
/*	Base de datos:  	cob_custodia				*/
/*	Producto:               garantias               		*/
/*	Disenado por:           Rodrigo Garces                  	*/
/*			        Luis Alfredo Castellanos              	*/
/*	Fecha de escritura:     Junio-1995  				*/
/************************************************************************/
/*				IMPORTANTE				*/
/*	Este programa es parte de los paquetes bancarios propiedad de	*/
/*	"MACOSA", representantes exclusivos para el Ecuador de la 	*/
/*	"NCR CORPORATION".						*/
/*	Su uso no autorizado queda expresamente prohibido asi como	*/
/*	cualquier alteracion o agregado hecho por alguno de sus		*/
/*	usuarios sin el debido consentimiento por escrito de la 	*/
/*	Presidencia Ejecutiva de MACOSA o su representante.		*/
/*				PROPOSITO				*/
/*	Este programa procesa las transacciones de:			*/
/*	Consulta de garantias amparadas por un garante                  */
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*	Jun/1995   L. Castellanos   Emision Inicial			*/
/************************************************************************/
use cob_custodia
go

if exists (select 1 from sysobjects where name = 'sp_con_garante')
    drop proc sp_con_garante 
go
create proc sp_con_garante  (
   @s_ssn                int      = null,
   @s_date               datetime = null,
   @s_user               login    = null,
   @s_term               descripcion = null,
   @s_corr               char(1)  = null,
   @s_ssn_corr           int      = null,
   @s_ofi                smallint  = null,
   @t_rty                char(1)  = null,
   @t_trn                smallint = null,
   @t_debug              char(1)  = 'N',
   @t_file               varchar(14) = null,
   @t_from               varchar(30) = null,
   @i_operacion          char(1)  = null,
   @i_modo               smallint = null,
   @i_ente               int = null,
   @i_filial 		 tinyint = null,
   @i_sucursal		 smallint = null,
   @i_tipo_cust		 varchar(64) = null,
   @i_custodia 		 int = null,
   @i_tramite            int = null
)
as

declare
   @w_today              datetime,     /* fecha del dia */ 
   @w_return             int,          /* valor que retorna */
   @w_sp_name            varchar(32),  /* nombre stored proc*/
   @w_existe             tinyint,      /* existe el registro*/
   @w_error              int

--select @w_today = convert(varchar(10),getdate(),101)
select @w_today = convert(varchar(10),@s_date,101)
select @w_sp_name = 'sp_con_garante'

/***********************************************************/
/* Codigos de Transacciones                                */
--if (@t_trn <> 19184 and @i_operacion = 'S') 

begin
 if @i_operacion = 'S'
 begin
   set rowcount 20
   select
   "TRAMITE" =tr_tramite,
   "MODULO"  =tr_producto,
   "DEUDOR"  =de_cliente,
   "TIPO PRODUCTO" = tr_toperacion,
   "NUM OBLIGACION"=tr_numero_op_banco,
   "VALOR ML"      =isnull(tr_monto,0)*isnull(cv_valor,1)
   from cob_credito..cr_gar_propuesta,cob_credito..cr_tramite,
        cob_credito..cr_deudores,cu_custodia, cob_conta..cb_vcotizacion
   where cu_garante   =  @i_ente
   and gp_garantia  =  cu_codigo_externo
   and gp_tramite   =  tr_tramite
   and cv_fecha  in (select max(A.cv_fecha) 
                     from cob_conta..cb_vcotizacion A,
                          cob_credito..cr_tramite
                      where A.cv_fecha <= convert(varchar(10),@s_date,101)
                        and A.cv_moneda = tr_moneda)
   and (tr_tramite > @i_tramite or @i_tramite is null)
   and de_tramite = tr_tramite
   and de_rol = 'D'
   order by tr_tramite

   if @@rowcount = 0
      return 1 
   else
      return 0 
 end
end --Cotizacion


go