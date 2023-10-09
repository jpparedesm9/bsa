/************************************************************************/
/*	Archivo: 	        crtotcli.sp                             */ 
/*	Stored procedure:       sp_crtotcli                             */ 
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
/*	Dado el cliente entrega el total de garantias y otras           */
/*	operaciones, suma de garantias vigentes,propuestas y excepc.    */
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*	Jun/1995		     Emision Inicial			*/
/************************************************************************/
use cob_custodia
go

set ansi_nulls off
go

if exists (select 1 from sysobjects where name = 'sp_crtotcli')
    drop proc sp_crtotcli
go
create proc sp_crtotcli  (
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
   @i_cliente            int = null, 
   @i_tipo 		 tinyint = null,
   @i_codigo_externo     varchar(64) = null
)
as

declare
   @w_today              datetime,     /* fecha del dia */ 
   @w_return             int,          /* valor que retorna */
   @w_sp_name            varchar(32),  /* nombre stored proc*/
   @w_existe             tinyint,      /* existe el registro*/
   @w_error              int,
   @w_estado             char(1),
   @w_fecha			 datetime

select @w_today = @s_date
select @w_sp_name = 'sp_crtotcli'

/***********************************************************/
/* Codigos de Transacciones                                */

if (@t_trn <> 19344 and @i_operacion = 'S') 
begin
/* tipo de transaccion no corresponde */
    select @w_error = 1901006
    goto error
end
  
if @i_operacion = 'S'
begin


   select 'TOTAL GARANTIA'   = sum(cu_valor_inicial * isnull(a.cv_valor,1)),
          'TOTAL OTRAS OPER' = sum(isnull(gp_monto_exceso,0) + (tr_monto * isnull(b.cv_valor,1)) * isnull(gp_monto_exceso-gp_monto_exceso,1))
   from cu_cliente_garantia,
   cob_credito..cr_deudores,
   cob_credito..cr_gar_propuesta c
   left join cu_custodia d  
   on  c.gp_garantia     = d.cu_codigo_externo 
   inner join cob_conta..cb_vcotizacion a
   on a.cv_moneda       = d.cu_moneda
     left join cob_credito..cr_tramite
     on c.gp_tramite         = tr_tramite
       inner join cob_conta..cb_vcotizacion b
       on b.cv_moneda        = tr_moneda
    where cg_ente            = @i_cliente
      and d.cu_garante       is null   --  Excluye garantes personales
      and de_rol             = 'C'     --  Codeudor 
      and d.cu_filial        = cg_filial
      and d.cu_sucursal      = cg_sucursal 
      and d.cu_tipo          = cg_tipo_cust
      and d.cu_custodia      = cg_custodia 
      and de_tramite         = tr_tramite
      and a.cv_fecha = (select max(c.cv_fecha)
                        from  cob_conta..cb_vcotizacion c
                        where c.cv_moneda = a.cv_moneda
                        and   c.cv_fecha <= @s_date)
      and b.cv_fecha = (select max(d.cv_fecha)         --pga23may2001
                        from  cob_conta..cb_vcotizacion d
                        where d.cv_moneda = b.cv_moneda
                        and   d.cv_fecha <= @s_date)

   if @@rowcount = 0 
   begin
      select @w_error = 1901003
      goto error
   end
end

return 0 
error:

   exec cobis..sp_cerror
   @t_debug = @t_debug,
   @t_file  = @t_file, 
   @t_from  = @w_sp_name,
   @i_num   = @w_error
   return 1  
go