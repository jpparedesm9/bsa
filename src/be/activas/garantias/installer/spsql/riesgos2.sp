/************************************************************************/
/*	Archivo: 	        riesgos2.sp                             */ 
/*	Stored procedure:       sp_riesgos2                             */ 
/*	Base de datos:  	cob_custodia				*/
/*	Producto:               garantias               		*/
/*	Disenado por:           Rodrigo Garces			      	*/
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
/************************************************************************/
/*				PROPOSITO				*/
/*	Este programa procesa las transacciones de:			*/
/*	Consulta el total de los riesgos de una Garantia                */
/*      El detalle y total                                              */
/************************************************************************/
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*	Oct/1995  L.Castellanos      Emision Inicial                    */     
/*      Nov/1996  L.Castellanos      Nuevo Calculo de los Riesgos 	*/
/*	Oct/07/2002 Gonzalo Solanilla R. Comentarios Comercio Exterior  */
/*					 No lo Utiliza Banco Agrario	*/
/*      Dic/2002    JVelandia         cambio etiqueta valor actual      */
/************************************************************************/
use cob_custodia
go

if exists (select 1 from sysobjects where name = 'sp_riesgos2')
drop proc sp_riesgos2
go
create proc sp_riesgos2  (
   @s_date               datetime = null,
   @t_trn                smallint = null,
   @t_debug              char(1)  = 'N',
   @t_file               varchar(14) = null,
   @t_from               varchar(30) = null,
   @i_operacion          char(1)  = null,
   @i_producto           char(64) = null,
   @i_modo               smallint = null,	--no se ocupa
   @i_cliente            int = null,		--no se ocupa
   @i_filial 		 tinyint = null,	--no se ocupa
   @i_sucursal		 smallint = null,	--no se ocupa
   @i_tipo_cust		 varchar(64) = null,	--no se ocupa
   @i_custodia 		 int = null,		--no se ocupa
   @i_codigo_compuesto   varchar(64) = null,	--no se ocupa
   @i_garantia           varchar(64) = null,
   @i_operac             cuenta   = null,
   @o_opcion             money    = null out

)
as

declare
   @w_today              datetime,     /* FECHA DEL DIA */ 
   @w_sp_name            varchar(32),  /* NOMBRE STORED PROC*/
   @w_est_cancelado      tinyint,
   @w_est_precancelado   tinyint,
   @w_est_anulado        tinyint,
   @w_fecha_fin          datetime,
   @w_monto              money,
   @w_riesgo             money,
   @w_sum_riesgos        money,
   @w_deudor             int, 	  
   @w_nom_deudor         varchar(64),  --NVR-BE
   @w_moneda             tinyint,
   @w_tramite            int,
   @w_toperacion         catalogo,
   @w_cotizacion         money,
   @w_producto           catalogo,
   @w_num_op_banco       varchar(24),	--NVR1
   @w_return		 int

select @w_today = convert(varchar(10),@s_date,101)
select @w_sp_name = 'sp_riesgos2'

/***********************************************************/
/* CODIGOS DE TRANSACCIONES                                */

if (@t_trn <> 19614 and @i_operacion = 'Q')      
begin
/* TIPO DE TRANSACCION NO CORRESPONDE */
    exec cobis..sp_cerror
    @t_debug = @t_debug,
    @t_file  = @t_file, 
    @t_from  = @w_sp_name,
    @i_num   = 1901006
    return 1 
end


if @i_operacion = 'S'
begin
   select @w_est_cancelado = es_codigo
   from cob_cartera..ca_estado
   where es_codigo = 3

   select @w_est_precancelado = es_codigo
   from cob_cartera..ca_estado
   where es_codigo = 5

   select @w_est_anulado = es_codigo
   from cob_cartera..ca_estado
   where es_codigo = 6

   create table #cu_operacion_cerrada (
          oc_producto         char(3)  null,
          oc_operacion        varchar(24)   null,
          oc_moneda           tinyint  null,
          oc_valor_inicial    money    null,
          oc_valor_actual     money    null,
          oc_fecha_venc       datetime null,
          oc_deudor           int      null,  
          oc_nom_deudor       varchar(100)  null) 
   if exists (select * from cob_credito..cr_gar_propuesta
              where gp_garantia = @i_garantia)
   begin
      declare cursor_consulta cursor for
      select distinct tr_tramite, tr_producto, tr_numero_op_banco,
      tr_moneda, tr_toperacion,de_cliente, en_nomlar
      from cob_credito..cr_gar_propuesta,
      cob_credito..cr_tramite,cob_credito..cr_deudores,
      cobis..cl_ente
      where gp_garantia     = @i_garantia
      and gp_tramite        = tr_tramite
      and tr_tipo          in ('O','R','M')
      and tr_numero_op     is not null
      and tr_tramite        = de_tramite
      and de_rol            = 'D'
      and de_cliente        = en_ente
      order by tr_tramite
      for read only

      open cursor_consulta
      fetch cursor_consulta into @w_tramite, @w_producto, @w_num_op_banco,
      @w_moneda,@w_toperacion,@w_deudor, @w_nom_deudor

      if (@@fetch_status = -1)  -- ERROR DEL CURSOR
      begin
         exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file, 
         @t_from  = @w_sp_name,
         @i_num   = 1909001 
         return 1 
      end

      if @@fetch_status <> 0
      begin
         --print "No existen tramites"
         close cursor_consulta
         deallocate cursor_consulta
         return 0
      end
      select @w_sum_riesgos = 0

      while @@fetch_status = 0
      begin
         select @w_riesgo = 0
         if @w_producto = 'CCA'
         begin 
            select @w_fecha_fin = op_fecha_fin,
            @w_monto     = isnull(sum(am_acumulado),0),
            @w_riesgo = isnull(sum(am_acumulado - am_pagado + am_gracia),0)
            from cob_cartera..ca_operacion,cob_cartera..ca_amortizacion
            where op_banco         = @w_num_op_banco
            and op_operacion       = am_operacion
            and am_concepto        = 'CAP'
            and op_estado         <> @w_est_cancelado
            and op_estado         <> @w_est_precancelado
            and op_estado         <> @w_est_anulado
            group by op_banco,op_fecha_fin
            order by op_banco


            insert into #cu_operacion_cerrada
            select  distinct @w_toperacion,  
            @w_num_op_banco,
            @w_moneda,
            isnull(@w_monto,0),
            @w_riesgo, 
            @w_fecha_fin,
            @w_deudor ,
            @w_nom_deudor
         end -- 'CCA'

/* COMERCIO EXTERIOR */
/*         if @w_producto = 'CEX'
         begin 
            select @w_monto  = op_importe,
            @w_riesgo = op_saldo,
            @w_fecha_fin = op_fecha_expir 
            from cob_credito..cr_gar_propuesta,
            cob_credito..cr_tramite,
            cob_comext..ce_operacion
            where tr_tramite         = @w_tramite       
            and tr_numero_op       = op_operacion
            and tr_producto        = @w_producto
            and op_etapa      not in ('40','41','50')

            insert into #cu_operacion_cerrada
            select  distinct @w_toperacion,  
            @w_num_op_banco,
            @w_moneda,
            @w_monto,
            @w_riesgo, 
            @w_fecha_fin,
            @w_deudor,
            @w_nom_deudor 
         end -- 'CEX'
*/

         select @w_cotizacion = cv_valor   
         from cob_conta..cb_vcotizacion
         where cv_moneda = @w_moneda
         and cv_fecha = (select max(cv_fecha) from cob_conta..cb_vcotizacion
                         where cv_fecha <= @s_date
                         and cv_moneda = @w_moneda) 

         select @w_riesgo = isnull(@w_riesgo,0)*isnull(@w_cotizacion,1)

         select @w_sum_riesgos = @w_sum_riesgos + @w_riesgo

         fetch cursor_consulta into @w_tramite, @w_producto,
         @w_num_op_banco, @w_moneda,@w_toperacion,@w_deudor,
         @w_nom_deudor

      end -- While

      close cursor_consulta
      deallocate cursor_consulta

      select @o_opcion = @w_sum_riesgos
   end
   else
   select @o_opcion = 0.0

   /* Selecciona los registros */
   if @i_producto is null -- PRIMEROS 20 REGISTROS
   begin
      set rowcount  20
      select distinct 'TIPO PRODUCTO'  = oc_producto,
      'OBLIGACION'       = oc_operacion,
      'MONEDA'          = oc_moneda,
      'VALOR GARANTIA'   = oc_valor_inicial,
      'VALOR ACEPTADO'    = oc_valor_actual,
      'FECHA VENCIM'    = convert(char(10),oc_fecha_venc,101),
      'DEUDOR'          = oc_deudor,
      'NOMBRE DEUDOR'   = oc_nom_deudor
      from #cu_operacion_cerrada
      order by oc_producto,oc_operacion
   end
   else               -- 20 SIGUIENTES                                      
   begin
      set rowcount  20
      select distinct 'TIPO PRODUCTO'  = oc_producto,
      'OBLIGACION'       = oc_operacion,
      'MONEDA'          = oc_moneda,
      'VALOR GARANTIA'   = oc_valor_inicial,
      'VALOR ACEPTADO'    = oc_valor_actual,
      'FECHA VENCIM'    = convert(char(10),oc_fecha_venc,103),
      'DEUDOR'          = oc_deudor,
      'NOMBRE DEUDOR'   = oc_nom_deudor
      from #cu_operacion_cerrada
      where (oc_producto > @i_producto
      or (oc_producto = @i_producto and oc_operacion > @i_operac))
      order by oc_producto,oc_operacion
   end    
end
go