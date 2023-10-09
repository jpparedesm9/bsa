/*************************************************************************/
/*	Archivo: 		astosmig.sp			      	 */
/*	Stored procedure: 	sp_sasientomig				 */
/*	Base de datos:  	cob_conta  				 */
/*	Producto:               contabilidad                		 */
/*	Disenado por:           			            	 */
/*	Fecha de escritura:     02-Dic-1999 				 */
/*************************************************************************/
/*				IMPORTANTE				 */
/*	Este programa es parte de los paquetes bancarios propiedad de	 */
/*	"MACOSA", representantes exclusivos para el Ecuador de la 	 */
/*	"NCR CORPORATION".						 */
/*	Su uso no autorizado queda expresamente prohibido asi como	 */
/*	cualquier alteracion o agregado hecho por alguno de sus		 */
/*	usuarios sin el debido consentimiento por escrito de la 	 */
/*	Presidencia Ejecutiva de MACOSA o su representante.		 */
/*				PROPOSITO				 */
/*	Este programa procesa las transacciones de:			 */
/*	Inserta los asientos de un comprobante a la tabla temporal       */
/*	de comprobantes generados por un subsistema                      */
/*				MODIFICACIONES				 */
/*	FECHA		AUTOR		  RAZON				 */
/*************************************************************************/
use cob_conta
go

if exists (select * from sysobjects where name = 'sp_sasientomig')
	drop proc sp_sasientomig
go

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO


create proc sp_sasientomig   (
 	@s_ssn		   	int = null,
	@s_date		   	datetime = null,
	@s_user		   	login = null,
	@s_term		   	descripcion = null,
	@s_corr		   	char(1) = null,
	@s_ssn_corr	   	int = null,
        @s_ofi		   	smallint = null,
	@t_rty		   	char(1) = null,
        @t_trn		   	smallint = null,
	@t_debug	   	char(1) = 'N',
	@t_file		   	varchar(14) = null,
	@t_from		   	varchar(30) = null,
	@i_operacion	   	char(1) = null,
	@i_fecha_tran	   	datetime = null,
        @i_comprobante	   	int = null,
	@i_empresa 	   	tinyint = null,
	@i_asiento	   	smallint = null,
	@i_cuenta   	   	cuenta = null,
	@i_oficina_dest    	smallint = null,
	@i_area_dest       	smallint  = null,
	@i_credito	   	money = null,
	@i_debito	   	money = null,
	@i_concepto	   	descripcion = null,
	@i_credito_me	   	money = null,
	@i_debito_me	   	money = null,
	@i_moneda   	   	tinyint = null,
	@i_cotizacion	   	float = null,
	@i_tipo_doc	   	char(1) =null,
	@i_tipo_tran	   	char(1) = null,
	@i_producto	   	tinyint = null,
	@i_debcred	   	char(1) = null,
        @i_opcion          	tinyint = null,
        @i_fecha_est       	datetime = null,
        @i_detalle         	smallint = null,
	@i_ente            	int = null,
        @i_con_rete        	char(4) = null,
        @i_base            	money = null,
        @i_valret          	money = null,
        @i_con_iva         	char(4) = null,
        @i_valor_iva       	money = null,
        @i_iva_retenido    	money = null,
        @i_con_ica         	char(4) = null,
        @i_valor_ica       	money = null,
        @i_con_timbre      	char(4) = null,
        @i_valor_timbre    	money = null,
        @i_con_iva_reten   	char(4) = null,
        @i_codigo_regimen  	char(4) = null,
        @i_con_ivapagado   	char(4) = null,
        @i_valor_ivapagado 	money = null,
        @i_documento       	char(24) = null,
        @i_mayorizado      	char(1) = "N",
        @i_oper_banco      	char (4) = null,
        @i_doc_banco       	char(20) = null,
        @i_cheque          	varchar (64) = null,
        @i_fecha_fin_difer 	datetime = null,
        @i_desc_difer      	descripcion = null,
        @i_con_dptales		char(4) = null,
        @i_valor_dptales	money = null
)
as
declare
	@w_today 	   	datetime,
	@w_return	   	int,
	@w_sp_name	   	varchar(32),
	@w_siguiente	   	tinyint,
	@w_error    	   	descripcion,
	@w_moneda	   	tinyint,
	@w_moneda_base	   	tinyint,
	@w_existe	   	int,
	@w_debito	   	money,
	@w_credito	   	money,
	@w_debito_me	   	money,
	@w_credito_me	   	money,
	@w_sum_debito_me   	money,
	@w_sum_credito_me  	money,
        @w_banco           	varchar (3),
        @w_ctacte          	varchar (20),
        @w_valor           	money,
        @w_debcred         	char(1)


select @w_today = getdate()
select @w_sp_name = 'sp_sasiento'


select @w_moneda_base = em_moneda_base
from cb_empresa where em_empresa = @i_empresa



select  @w_sum_debito_me  = sum(sa_debito_me),
	@w_sum_credito_me = sum(sa_credito_me)
from cob_conta_tercero..ct_sasiento
where 	sa_empresa 	= @i_empresa
and   	sa_producto 	= @i_producto
and   	sa_fecha_tran 	= @i_fecha_tran
and	sa_comprobante 	= @i_comprobante


if @w_sum_debito_me <> @w_sum_credito_me
	if not exists(select sa_tipo_doc from cob_conta_tercero..ct_sasiento
			where sa_empresa = @i_empresa and
	      		sa_producto = @i_producto and
	      		sa_fecha_tran = @i_fecha_tran and
	     		sa_comprobante = @i_comprobante and
			sa_tipo_doc in ('C','V'))
	begin
                	select @w_error = 'No existen doctos. de Compra o '
					  + ' Venta para cuadrar la M.E.'
                	exec cobis..sp_cerror
                	@t_debug = @t_debug,
                	@t_file  = @t_file,
                	@t_from  = @w_sp_name,
                	@i_msg   = @w_error,
                	@i_num   = 999999

			 delete cob_conta_tercero..ct_scomprobante
                         where sc_empresa = @i_empresa and
			      sc_producto = @i_producto and
			      sc_fecha_tran = @i_fecha_tran and
			      sc_comprobante = @i_comprobante

                        delete cob_conta_tercero..ct_sasiento
			where sa_empresa = @i_empresa and
			      sa_producto = @i_producto and
			      sa_fecha_tran = @i_fecha_tran and
			      sa_comprobante = @i_comprobante
       		     return 1
	end


       select @w_debito    = 0, @w_credito    = 0,
              @w_debito_me = 0, @w_credito_me = 0

       	if @i_debcred = '1'
	begin
             select @w_debito    = isnull(@i_debito,0),
             	    @w_debito_me = isnull(@i_debito_me,0)
             if @i_moneda != @w_moneda_base and @i_debito_me != 0
                select @i_cotizacion = round((@i_debito / @i_debito_me),2)
             else select @i_cotizacion = 0
	end
       	else
	begin
             select @w_credito   = isnull(@i_credito,0),
             	    @w_credito_me = isnull(@i_credito_me,0)
             if @i_moneda != @w_moneda_base and @i_credito_me != 0
                select @i_cotizacion = round((@i_credito / @i_credito_me),2)
             else select @i_cotizacion = 0
	end

begin tran
        select @i_asiento = null
        select @i_asiento = max(sa_asiento) + 1
         from cob_conta_tercero..ct_sasiento
         where sa_empresa = @i_empresa
           and sa_fecha_tran = @i_fecha_tran
           and sa_comprobante = @i_comprobante
	   and sa_producto = @i_producto

        if @i_asiento is null select @i_asiento = 1

	insert into cob_conta_tercero..ct_sasiento (
                sa_producto,sa_fecha_tran,sa_comprobante,sa_empresa,
		sa_asiento,sa_cuenta,
		sa_oficina_dest,sa_area_dest,
		sa_credito,sa_debito,sa_concepto,
		sa_credito_me,sa_debito_me,sa_cotizacion,
		sa_tipo_doc,sa_tipo_tran,sa_moneda,
                --sa_opcion,sa_fecha_est,sa_detalle,
                sa_opcion,--sa_fecha_est,sa_detalle,
                sa_ente,sa_con_rete,sa_base,
                sa_valret,sa_con_iva,sa_valor_iva,
                sa_iva_retenido,sa_con_ica,sa_valor_ica,
                sa_con_timbre,sa_valor_timbre,sa_con_iva_reten,
                --sa_codigo_regimen,sa_con_ivapagado,sa_valor_ivapagado,
                sa_con_ivapagado,sa_valor_ivapagado,
                sa_documento,sa_mayorizado,sa_con_dptales,sa_valor_dptales)
                --sa_fecha_fin_difer,sa_desc_difer)
	values (@i_producto,@i_fecha_tran,@i_comprobante,@i_empresa,
		@i_asiento,@i_cuenta,
		@i_oficina_dest,@i_area_dest,
		@w_credito,@w_debito,@i_concepto,
		@w_credito_me,@w_debito_me,@i_cotizacion,
		@i_tipo_doc,@i_tipo_tran,@i_moneda,
                --@i_opcion,@i_fecha_est,@i_detalle,
                @i_opcion,--@i_fecha_est,@i_detalle,
                @i_ente,@i_con_rete,@i_base,
                @i_valret,@i_con_iva,@i_valor_iva,
                @i_iva_retenido,@i_con_ica,@i_valor_ica,
                @i_con_timbre,@i_valor_timbre,@i_con_iva_reten,
                --@i_codigo_regimen,@i_con_ivapagado,@i_valor_ivapagado,
                @i_con_ivapagado,@i_valor_ivapagado,
                @i_documento,@i_mayorizado,@i_con_dptales,@i_valor_dptales) --,
                --@i_fecha_fin_difer,@i_desc_difer)

	if @@error <> 0
	begin
	/* 'Error en insercion del detalle del comprobante en la tabla temporal' */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 603020

                delete cob_conta_tercero..ct_sasiento
		where   sa_empresa = @i_empresa and
		        sa_producto = @i_producto and
			sa_fecha_tran = @i_fecha_tran and
			sa_comprobante = @i_comprobante

                delete cob_conta_tercero..ct_scomprobante
		where 	sc_empresa = @i_empresa and
		        sc_producto = @i_producto and
			sc_fecha_tran = @i_fecha_tran and
			sc_comprobante = @i_comprobante
		return 1
	end



        else
        begin
           select @w_banco       =  ba_banco,
                  @w_ctacte      =  ba_ctacte
           from   cob_conta..cb_banco
           where  ba_empresa     =  @i_empresa
           and    ba_cuenta      =  @i_cuenta

           if @@rowcount > 0
           begin
             if @i_moneda = @w_moneda_base
             begin
               if @i_debcred = '1'
                 select @w_valor = @i_debito
               else
                 select @w_valor = @i_credito
             end
             else
             begin
               if @i_debcred = '1'
                 select @w_valor = @i_debito_me
               else
                 select @w_valor = @i_credito_me
             end
             if @i_debcred = '1'
                select @w_debcred = 'D'
             else
                select @w_debcred = 'C'

             if (@i_oper_banco is not null)
             begin
               insert into cob_conta_tercero..ct_conciliacion
               (cl_producto,cl_comprobante,cl_empresa,
                cl_fecha_tran,cl_asiento,cl_cuenta,
                cl_oficina_dest,cl_area_dest,cl_debcred,
                cl_valor,cl_oper_banco,cl_doc_banco,
                cl_banco,cl_fecha_est,cl_cuenta_cte,
                cl_detalle,cl_relacionado,cl_cheque)
               values
               (@i_producto,@i_comprobante,@i_empresa,
                @i_fecha_tran,@i_asiento,@i_cuenta,
                @i_oficina_dest,@i_area_dest,@w_debcred,
                @w_valor,@i_oper_banco,@i_doc_banco,
                @w_banco,@i_fecha_est,@w_ctacte,
                @i_detalle,'N',@i_cheque)

	       if @@error <> 0
	       begin
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 601161
               end
             end
           end
        end

commit tran
return 0

go
