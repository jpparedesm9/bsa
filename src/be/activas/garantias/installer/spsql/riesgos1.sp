/************************************************************************/
/*	Archivo: 	        riesgos1.sp                             */ 
/*	Stored procedure:       sp_riesgos1                             */ 
/*	Base de datos:  	cob_custodia				*/
/*	Producto:               garantias               		*/
/*	Disenado por:           Rodrigo Garces                  	*/
/*			        Luis Alfredo Castellanos              	*/
/*	Fecha de escritura:     Abril-1996  				*/
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
/*	Riesgos de la Garantia, verificando si la operacion ha sido     */
/*	Cancelada en el caso de las garantias cerradas                  */
/************************************************************************/
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		  RAZON         		*/
/*	Abr/1996     Luis Castellanos   Emision Inicial			*/
/*	Oct/07/2002  Gonzalo Solanilla R. Comentarios Comercio Exterior */
/*					  Banco Agrario			*/
/************************************************************************/
use cob_custodia
go

if exists (select 1 from sysobjects where name = 'sp_riesgos1')
drop proc sp_riesgos1
go
create proc sp_riesgos1 (
   @s_date               datetime = null,
   @t_trn                smallint = null,
   @t_debug              char(1)  = 'N',
   @t_file               varchar(14) = null,
   @t_from               varchar(30) = null,
   @i_operacion          char(1)  = null,
   @i_modo               smallint = null,	--no se ocupa
   @i_codigo_externo     varchar(64) = null,
   @i_cliente            int         = null,	--no se ocupa
   @i_producto           varchar(15) = null,	--no se ocupa
   @i_tramite		 int         = null,	--no se ocupa
   @i_filial 		 tinyint     = null,	--no se ocupa
   @i_sucursal		 smallint    = null,	--no se ocupa
   @i_tipo_cust		 varchar(64) = null,	--no se ocupa
   @i_custodia 		 int         = null,	--no se ocupa
   @i_codigo_compuesto   varchar(64) = null,	--no se ocupa
   @i_garantia           varchar(64) = null,	--no se ocupa
   @i_operac             cuenta      = null,	--no se ocupa
   @o_riesgos            char(1)     = null out
)
as

declare
   @w_today              datetime,     /* FECHA DEL DIA */ 
   @w_sp_name            varchar(32),  /* NOMBRE STORED PROC*/
   @w_ayer               datetime,
   @w_riesgo             money,
   @w_producto		 varchar(4),
   @w_moneda		 int,
   @w_num_op_banco       varchar(20),
   @w_sum_riesgos        money,
   @w_est_cancelado      tinyint,
   @w_est_precancelado   tinyint,
   @w_tramite            int,
   @w_est_anulado        tinyint,
   @w_return		 int

select @w_today   = convert(varchar(10),@s_date,101)
select @w_sp_name = 'sp_riesgos1'
select @w_ayer    = dateadd(dd,-1,@s_date)

/***********************************************************/
/* CODIGOS DE TRANSACCIONES                                */

if (@t_trn <> 19604 and @i_operacion = 'Q') 
begin
/* TIPO DE TRANSACCION NO CORRESPONDE */
   exec cobis..sp_cerror
   @t_debug = @t_debug,
   @t_file  = @t_file, 
   @t_from  = @w_sp_name,
   @i_num   = 1901006
   return 1 
end


if @i_operacion = 'Q'
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

   if exists (select 1 from cob_credito..cr_gar_propuesta
              where gp_garantia = @i_codigo_externo)
   begin
      declare cursor_consulta cursor for
      select tr_tramite, tr_producto, tr_numero_op_banco,
      tr_moneda
      from cob_credito..cr_gar_propuesta,
      cob_credito..cr_tramite     
      where gp_garantia     = @i_codigo_externo
      and gp_tramite        = tr_tramite
      and tr_tipo          in ('O','R','M') -- Tipo de Tramite Normalizacion
      and tr_numero_op_banco     is not null        
      group by gp_tramite, tr_tramite, tr_producto, tr_numero_op_banco,tr_moneda
      order by gp_tramite, tr_tramite, tr_producto, tr_numero_op_banco,tr_moneda
      for read only

      open cursor_consulta
      fetch cursor_consulta into @w_tramite, @w_producto, @w_num_op_banco,
      @w_moneda

      select @w_sum_riesgos = 0

      while @@fetch_status = 0
      begin
         select @w_riesgo = 0

         if @w_producto = 'CCA'
         begin 
            select @w_riesgo = sum(am_acumulado - am_pagado )
            from cob_cartera..ca_operacion,cob_cartera..ca_amortizacion
            where op_banco           = @w_num_op_banco 
            and op_operacion       = am_operacion
            and am_concepto         = 'CAP'
            and op_estado         <> @w_est_cancelado
            and op_estado         <> @w_est_precancelado
            and op_estado         <> @w_est_anulado
            group by op_banco
            order by op_banco

            select @w_riesgo=isnull(isnull(@w_riesgo,0)*isnull(cv_valor,1),0)
            from cob_conta..cb_vcotizacion
            where cv_moneda = convert(tinyint,@w_moneda) --emg Ene-16-01 optimizacion
            and cv_fecha in (select max(cv_fecha)
                             from cob_conta..cb_vcotizacion
                             where cv_fecha <= @s_date
                             and cv_moneda = @w_moneda) 

            select @w_sum_riesgos = @w_sum_riesgos + isnull(@w_riesgo,0)
         end 

/* COMERCIO EXTERIOR */
        /* if @w_producto = 'CEX'
         begin 
            select @w_riesgo = op_saldo
            from cob_credito..cr_tramite,
            cob_comext..ce_operacion
            where tr_numero_op_banco = @w_num_op_banco
            and tr_numero_op       = op_operacion
            and tr_producto        = @w_producto
            and op_etapa      not in ('40','41','50')

            select @w_riesgo=isnull(isnull(@w_riesgo,0)*isnull(cv_valor,1),0)
            from cob_conta..cb_vcotizacion
            where cv_moneda = convert(tinyint,@w_moneda)
            and cv_fecha in (select max(cv_fecha)
                             from cob_conta..cb_vcotizacion
                             where cv_fecha <= @s_date
                             and cv_moneda = @w_moneda) 

            select @w_sum_riesgos = @w_sum_riesgos + isnull(@w_riesgo,0)
         end*/


         fetch cursor_consulta into @w_tramite, @w_producto,
         @w_num_op_banco, @w_moneda
      end -- While
      if @w_sum_riesgos > 0
      select @o_riesgos = 'S'
      else
      select @o_riesgos = 'N'

      close cursor_consulta
      deallocate cursor_consulta
   end -- Fin del If exists
   else  -- No existen tramites asociados a la garantia
   select @o_riesgos = 'N'
select @o_riesgos
end 
go