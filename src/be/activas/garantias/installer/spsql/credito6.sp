/************************************************************************/
/*	Archivo: 	        credito6.sp                             */ 
/*	Stored procedure:       sp_credito6                             */ 
/*	Base de datos:  	cob_custodia				*/
/*	Producto:               garantias               		*/
/*	Disenado por:           Rodrigo Garces                   	*/
/*			        Luis Alfredo Castellanos              	*/
/*	Fecha de escritura:     Junio-1995  				*/
/************************************************************************/
/*				IMPORTANTE				*/
/*	Este programa es parte de los paquetes bancarios propiedad de	*/
/*	"SYSCONSULTING"                                                 */
/*	Su uso no autorizado queda expresamente prohibido asi como	*/
/*	cualquier alteracion o agregado hecho por alguno de sus		*/
/*	usuarios sin el debido consentimiento por escrito de la 	*/
/*	Presidencia Ejecutiva de SYSCONSULTING o su representante.      */
/*				PROPOSITO				*/
/*	Este programa procesa las transacciones de:			*/
/*	Consulta de garantias amparadas por un garante                  */
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*	Oct/1995  L.Castellanos      Emision Inicial            	*/
/*	Abr/1998                     Upgrade Cartera			*/
/*      Oct/07/2002 Gonzalo Solanilla R. Comentarios Comercio Exterior  */ 
/*					 no se utiliza en Banco Agrario */
/*      Dic/2002     Jvelandia           cambio etiqueta de valor actual*/ 
/************************************************************************/
use cob_custodia
go

if exists (select 1 from sysobjects where name = 'sp_credito6')
   drop proc sp_credito6
go
create proc sp_credito6  (
   @s_ssn                int      = null,
   @s_date               datetime = null,
   @s_user               login    = null,
   @s_term               varchar(64) = null,
   @s_corr               char(1)  = null,
   @s_ssn_corr           int      = null,
   @s_ofi                smallint  = null,
   @t_rty                char(1)  = null,
   @t_trn                smallint = null,
   @t_debug              char(1)  = 'N',
   @t_file               varchar(14) = null,
   @t_from               varchar(30) = null,
   @i_operacion          char(1)  = null,
   @i_producto           char(64) = null,
   @i_modo               smallint = null,
   @i_cliente            int = null,
   @i_filial 		 tinyint = null,
   @i_sucursal		 smallint = null,
   @i_tipo_cust		 varchar(64) = null,
   @i_custodia 		 int = null,
   @i_codigo_compuesto   varchar(64) = null
)
as

declare
   @w_today              datetime,     /* fecha del dia      */ 
   @w_return             int,          /* valor que retorna  */
   @w_sp_name            varchar(32),  /* nombre stored proc */
   @w_existe             tinyint,      /* existe el registro */
   @w_error              int,
   @w_contador           tinyint

--select @w_today = getdate()
select @w_today = @s_date
select @w_sp_name = 'sp_credito6'

/***********************************************************/
/* Codigos de Transacciones                                */

if (@t_trn <> 19404 and @i_operacion = 'S') 
     
begin
/* tipo de transaccion no corresponde */
    exec cobis..sp_cerror
    @t_debug = @t_debug,
    @t_file  = @t_file, 
    @t_from  = @w_sp_name,
    @i_num   = 1901006
    return 1 
end

if @i_operacion = 'S'
begin

      create table #cu_operacion_cliente (
      oc_producto         char(3),
      oc_operacion        varchar(24),
      oc_moneda           tinyint,
      oc_valor_inicial    money,
      oc_valor_actual     money,
      oc_fecha_venc       datetime
      )

      insert into #cu_operacion_cliente
      select  tr_producto,  
      op_banco,
      op_moneda,
      sum(am_acumulado),		 	        -- UPGRADE CCA
      sum(am_acumulado - am_pagado ),   -- UPGRADE CCA
      -- sum(ro_acumulado),			        -- UPGRADE CCA
      -- sum(ro_acumulado - ro_adelantado - ro_pagado), -- UPGRADE CCA
      op_fecha_fin
      from cu_custodia,cob_credito..cr_gar_propuesta,cob_credito..cr_tramite,
      cob_cartera..ca_operacion,
      cob_cartera..ca_amortizacion                      -- UPGRADE CCA
      -- cob_cartera..ca_rubro_op	                -- UPGRADE CCA
      where cu_garante        = @i_cliente
      and cu_codigo_externo = gp_garantia
      and cu_estado         not in ('A')
      and gp_tramite        = tr_tramite
      and tr_numero_op      = op_operacion
      and tr_producto       = 'CCA' 
      and am_operacion      = op_operacion		     -- UPGRADE CCA
      and am_concepto       = 'CAP'  -- (C)apital            -- UPGRADE CCA
      -- and ro_operacion      = op_operacion		     -- UPGRADE CCA
      -- and ro_tipo_rubro     = 'C' -- (C)apital            -- UPGRADE CCA

      group by op_banco,tr_producto,op_moneda,op_fecha_fin
      order by op_banco

/*    No se Utiliza Banco Agrario gsr-07/10/2002				*/
/*    Comercio Exterior  */
/*      insert into #cu_operacion_cliente
      select  tr_producto,  
      op_operacion_banco,
      op_moneda,
      op_importe,                 
      op_saldo,          
      op_fecha_expir
      from cu_custodia,cob_credito..cr_gar_propuesta,cob_credito..cr_tramite,
      cob_comext..ce_operacion
      where cu_garante        = @i_cliente
      and cu_codigo_externo = gp_garantia
      and cu_estado         not in ('A')
      and gp_tramite        = tr_tramite
      and tr_numero_op      = op_operacion
      and tr_producto       = 'CEX'*/


   if @i_producto is null -- PRIMEROS 20 REGISTROS
   begin
      set rowcount  20 
      select "PRODUCTO"        = oc_producto,
      "OPERACION"       = oc_operacion,
      "MONEDA"          = oc_moneda,
      "VALOR GARANTIA"   = oc_valor_inicial,
      "VALOR ACEPTADO"    = oc_valor_actual,
      "FECHA VENCIM"    = oc_fecha_venc
      from #cu_operacion_cliente
      order by oc_producto,oc_operacion

      if @@rowcount = 0
         print "No existen operaciones para este cliente"
 
   end else               -- 20 SIGUIENTES
   begin
       set rowcount  20 
       select "PRODUCTO"        = oc_producto,
       "OPERACION"       = oc_operacion,
       "MONEDA"          = oc_moneda,
       "VALOR GARANTIA"   = oc_valor_inicial,
       "VALOR ACEPTADO"    = oc_valor_actual,
       "FECHA VENCIM"    = oc_fecha_venc
       from #cu_operacion_cliente
       where (oc_producto > @i_producto 
       or (oc_producto = @i_producto and oc_operacion > @i_operacion))
       order by oc_producto,oc_operacion 

       if @@rowcount = 20
          print "No existen mas operaciones para este cliente"
   end
end
go