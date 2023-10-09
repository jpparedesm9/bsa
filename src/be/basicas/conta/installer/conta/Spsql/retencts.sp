/************************************************************************/
/*	Archivo: 		retencts.sp			        */
/*	Stored procedure: 	sp_tsretencion            		*/
/*	Base de datos:  	cob_conta  				*/
/*	Producto:               contabilidad                		*/
/*	Disenado por:                                             	*/
/*	Fecha de escritura:     12-Mayo-1999 				*/
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
/*	Programa que inserta en cb_tretencion. Utilizado por Interfaz   */
/*      Contable.                                                       */
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*     	12-May-1999     J.Rodriguez         Emision Inicial             */
/*	04-Ago-1999	Juan C. Gomez	    Aumenta tama¤o de campo JCG */
/************************************************************************/
use cob_conta
go

if exists (select * from sysobjects where name = 'sp_tsretencion')
	drop proc sp_tsretencion

go

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO


create proc sp_tsretencion   (
	@s_ssn		      int = null,
	@s_date		      datetime = null,
	@s_user		      login = null,
	@s_term		      descripcion = null,
	@s_corr		      char(1) = null,
	@s_ssn_corr	      int = null,
        @s_ofi		      smallint = null,
	@t_rty		      char(1) = null,
        @t_trn		      smallint = null,
	@t_debug	      char(1) = 'N',
	@t_file		      varchar(14) = null,
	@t_from		      varchar(30) = null,
        @i_cuenta             cuenta = null,
        @i_forma              tinyint=null,
        @i_operacion          char(1)  = null,
        @i_modo               tinyint = 0,
        @i_codigo             smallint = NULL,
        @i_comprobante        int = NULL,
        @i_empresa            tinyint = NULL,
        @i_asiento            smallint = null,
        @i_tipoid             char(1) = null,
        @i_identif            char(13) = null, --JCG
        @i_concepto           char(4) = '0',
        @i_fecha              datetime = NULL,
        @i_cuenta_ini         cuenta = NULL,
        @i_cuenta_fin         cuenta = NULL,
        @i_base               money = 0,
        @i_retencion          money = 0,
        @i_valorete           money = 0,
        @i_calculado          money = 0,
        @i_formato_fecha      tinyint = null,
        @i_fecha_i            datetime = null,
        @i_fecha_f            datetime = null,
        @i_documento          char(24)= null   
)
as 
declare
	@w_today 	datetime,
	@w_return	int,
	@w_sp_name	varchar(32),
	@w_siguiente	tinyint,
        @w_operrete     char(1),
	@w_moneda	tinyint,
	@w_existe	int
				           

select @w_today = getdate()
select @w_sp_name = 'sp_tsretencion'


select @w_operrete = cp_condicion
from   cob_conta..cb_cuenta_proceso
where  cp_empresa = @i_empresa
and    @i_cuenta like cp_cuenta +'%'
and    cp_proceso = 6095


/************************************************/
/*  Tipo de Transaccion =  			*/

if @t_trn <> 6280
begin
	/* 'Tipo de transaccion no corresponde' */
	exec cobis..sp_cerror
	@t_debug = @t_debug,
	@t_file	 = @t_file,
	@t_from	 = @w_sp_name,
	@i_num	 = 601077
	return 1
end
/************************************************/

if @t_debug = 'S'
begin
	exec cobis..sp_begin_debug @t_file = @t_file
	select '/** Store Procedure **/ ' = @w_sp_name,
		t_file		= @t_file,
		t_from		= @t_from,
		i_operacion	= @i_operacion,
		i_fecha_tran	= @i_fecha,
		i_comprobante	= @i_comprobante,
		i_empresa   	= @i_empresa,      
		i_asiento	= @i_asiento,
		i_cuenta     	= @i_cuenta ,
		i_concepto	= @i_concepto
	exec cobis..sp_end_debug
end

/**************** VALIDACIONES ***********************/

     if @i_operacion = 'I' 
     begin

      begin tran

        if @w_operrete = 'I'
        begin
           insert into cb_tretencion(
             tr_empresa,
             tr_comprobante,
             tr_fecha,
             tr_asiento,
             tr_cuenta,
             tr_tipo,
             tr_identifica,
             tr_con_iva,
             tr_valor_asiento,
             tr_base,
             tr_valor_iva,
             tr_iva_calculado)
           values (
             @i_empresa,
             @i_comprobante,
             @i_fecha,
             @i_asiento,
             @i_cuenta, 
             @i_tipoid,
             @i_identif,
             @i_concepto,
             @i_retencion,
             @i_base,
             @i_valorete,
             @i_calculado)

           if @@error <> 0
           begin
             /* Error en insercion de registro */
              exec cobis..sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,
              @i_num   = 601161

              delete cob_conta..cb_tasiento
              where   ta_fecha_tran = @i_fecha and
                      ta_comprobante = @i_comprobante and
                      ta_empresa = @i_empresa

              delete cob_conta..cb_tcomprobante
              where   ct_fecha_tran = @i_fecha and
                      ct_comprobante = @i_comprobante and
                      ct_empresa = @i_empresa
          
              delete cob_conta..cb_tretencion
	      where tr_fecha = @i_fecha and
		    tr_comprobante = @i_comprobante and
	 	    tr_empresa = @i_empresa


              return 1
           end      
        end 

        if @w_operrete = 'C'
        begin
           insert into cb_tretencion(
             tr_empresa,
             tr_comprobante,
             tr_fecha,
             tr_asiento,
             tr_cuenta,
             tr_tipo,
             tr_identifica,
             tr_con_ica,
             tr_valor_asiento,
             tr_base,
             tr_valor_ica,   
             tr_ica_calculado)
           values (
             @i_empresa,
             @i_comprobante,
             @i_fecha,
             @i_asiento,
             @i_cuenta,
             @i_tipoid,
             @i_identif,
             @i_concepto,
             @i_retencion,
             @i_base,
             @i_valorete,
             @i_calculado)

           if @@error <> 0
           begin
             /* Error en insercion de registro */
              exec cobis..sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,  
              @i_num   = 601161

              delete from cob_conta..cb_tasiento
              where   ta_fecha_tran = @i_fecha and
                      ta_comprobante = @i_comprobante and
                      ta_empresa = @i_empresa

              delete from cob_conta..cb_tcomprobante
              where   ct_fecha_tran = @i_fecha and
                      ct_comprobante = @i_comprobante and
                      ct_empresa = @i_empresa

	      delete from cob_conta..cb_tretencion
	      where tr_fecha = @i_fecha and
		    tr_comprobante = @i_comprobante and
	 	    tr_empresa = @i_empresa 

              return 1
           end
        end

        if @w_operrete = 'T'
        begin
           insert into cb_tretencion(
             tr_empresa,
             tr_comprobante,
             tr_fecha,
             tr_asiento,
             tr_cuenta,
             tr_tipo,
             tr_identifica,
             tr_con_timbre,
             tr_valor_asiento,
             tr_base,      
             tr_valor_timbre,
             tr_timbre_calculado)
           values (
             @i_empresa,
             @i_comprobante,
             @i_fecha,
             @i_asiento,
             @i_cuenta,
             @i_tipoid,
             @i_identif,
             @i_concepto,
             @i_retencion,
             @i_base,
             @i_valorete,
             @i_calculado)

           if @@error <> 0
           begin
             /* Error en insercion de registro */  
             exec cobis..sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,
              @i_num   = 601161

              delete from cob_conta..cb_tasiento
              where   ta_fecha_tran = @i_fecha and
                      ta_comprobante = @i_comprobante and
                      ta_empresa = @i_empresa

              delete from cob_conta..cb_tcomprobante
              where   ct_fecha_tran = @i_fecha and
                      ct_comprobante = @i_comprobante and
                      ct_empresa = @i_empresa

	      delete from cob_conta..cb_tretencion
	      where tr_fecha = @i_fecha and
		    tr_comprobante = @i_comprobante and
	 	    tr_empresa = @i_empresa 

              return 1
           end
        end

        if @w_operrete = 'P'
        begin
           insert into cb_tretencion(
             tr_empresa,
             tr_comprobante,
             tr_fecha,
             tr_asiento, 
             tr_cuenta,
             tr_tipo,
             tr_identifica,
             tr_con_ivapagado,
             tr_valor_asiento,
             tr_base,
             tr_valor_ivapagado,
             tr_ivapagado_calculado)
           values (
             @i_empresa,
             @i_comprobante,
             @i_fecha,
             @i_asiento,
             @i_cuenta,
             @i_tipoid,
             @i_identif,
             @i_concepto,
             @i_retencion,
             @i_base,
             @i_valorete,  
             @i_calculado)

           if @@error <> 0
           begin
             /* Error en insercion de registro */
              exec cobis..sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,
              @i_num   = 601161

              delete from cob_conta..cb_tasiento
              where   ta_fecha_tran = @i_fecha and
                      ta_comprobante = @i_comprobante and
                      ta_empresa = @i_empresa

              delete from cob_conta..cb_tcomprobante
              where   ct_fecha_tran = @i_fecha and
                      ct_comprobante = @i_comprobante and
                      ct_empresa = @i_empresa

	      delete from cob_conta..cb_tretencion
	      where tr_fecha = @i_fecha and
		    tr_comprobante = @i_comprobante and
	 	    tr_empresa = @i_empresa 

              return 1
           end
        end

        if @w_operrete = 'R' OR @w_operrete is null
        begin
           insert into cb_tretencion(
             tr_empresa,
             tr_comprobante,
             tr_fecha,
             tr_asiento,
             tr_cuenta,
             tr_tipo,
             tr_identifica,
             tr_concepto,
             tr_valor_asiento,
             tr_base,
             tr_valret,
             tr_retencion_calculado,
             tr_documento)     /*CMDO*/
           values (
             @i_empresa,
             @i_comprobante,
             @i_fecha,
             @i_asiento,
             @i_cuenta,
             @i_tipoid,
             @i_identif,
             @i_concepto,
             @i_retencion,
             @i_base,
             @i_valorete,
             @i_calculado,
             @i_documento)     /*CMDO*/

           if @@error <> 0
           begin
             /* Error en insercion de registro */
              exec cobis..sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,
              @i_num   = 601161

              delete from cob_conta..cb_tasiento
              where   ta_fecha_tran = @i_fecha and
                      ta_comprobante = @i_comprobante and
                      ta_empresa = @i_empresa

              delete from cob_conta..cb_tcomprobante
              where   ct_fecha_tran = @i_fecha and
                      ct_comprobante = @i_comprobante and
                      ct_empresa = @i_empresa

	      delete from cob_conta..cb_tretencion
	      where tr_fecha = @i_fecha and
		    tr_comprobante = @i_comprobante and
	 	    tr_empresa = @i_empresa 

              return 1
           end
        end

        commit tran
        return 0
     end             
                        
return 0

go
