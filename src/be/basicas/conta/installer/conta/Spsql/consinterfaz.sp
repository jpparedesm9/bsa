/************************************************************************/
/*	Archivo: 		consinterfaz.sp			        */
/*	Stored procedure: 	sp_consulta_interfaz			*/
/*	Base de datos:  	cob_conta  				*/
/*	Producto:               contabilidad                		*/
/*	Disenado por:                                               	*/
/*	Fecha de escritura:     10-Marzo-1999				*/
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
/*	Consulta los comprobantes que ingresaron por interfaz contable  */
/*      y que poseen error.                                             */
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*	10/Mar/1999	M. Perez      Emision Inicial			*/
/************************************************************************/
use cob_conta
go

if exists (select * from sysobjects where name = 'sp_consulta_interfaz')
	drop proc sp_consulta_interfaz  
go
create proc sp_consulta_interfaz (
	@s_ssn		int = null,
	@s_date		datetime = null,
	@s_user		login = null,
	@s_term		descripcion = null,
	@s_corr		char(1) = null,
	@s_ssn_corr	int = null,
        @s_ofi		smallint = null,
	@t_rty		char(1) = null,
        @t_trn		smallint = null,
	@t_debug	char(1) = 'N',
	@t_file		varchar(14) = null,
	@t_from		varchar(30) = null,
	@i_empresa 	tinyint = null,
	@i_producto 	tinyint,
	@i_fecha	datetime,
        @i_operacion    char(1),
        @i_modo         tinyint = 0,
        @i_comprobante  int = null
		)                        
as

declare @w_today 	datetime,
	@w_return	int,
	@w_sp_name	varchar(32)


select @w_today = getdate()
select @w_sp_name = 'sp_consulta_interfaz'


/************************************************/
/*  Tipo de Transaccion       			*/

if (@t_trn <> 6909) 
begin
	/* 'Tipo de transaccion no corresponde' */
	exec cobis..sp_cerror
	@t_debug = @t_debug,
	@t_file	 = @t_file,
	@t_from	 = @w_sp_name,
	@i_num	 = 601077
	return 1
end


/***********************************************/
if @i_operacion = 'Q'
begin
        set rowcount 20

        if @i_modo = 0
        begin 
          select 'COMPROBANTE'        = sc_comprobante,
                 'FECHA'               = sc_fecha_tran,
                 'OFICINA ORIGEN'      = sc_oficina_orig,
                 'AREA ORIGEN'         = sc_area_orig,
                 'DESCRIPCION'         = sc_descripcion,
                 'FECHA DE GRABACION' = sc_fecha_gra,
                 'PERFIL'              = sc_perfil,
                 'TOTAL DEBITOS'       = sc_tot_debito,
                 'TOTAL CREDITOS'      = sc_tot_credito,
                 'OBSERVACIONES'       = sc_observaciones
            from cob_conta_tercero..ct_scomprobante
           where sc_producto   = @i_producto
             and sc_empresa    = @i_empresa
             and sc_fecha_tran = @i_fecha
             and sc_estado     = 'E'
           order by sc_producto,sc_comprobante,sc_fecha_tran

          if @@error <> 0
            begin
               exec cobis..sp_cerror
               @t_debug = @t_debug,
               @t_file  = @t_file,
               @t_from  = @w_sp_name,
               @i_num   = 605082

               set rowcount 0
               return 1
            end

            set rowcount 0
            return 0
          end
        else
        begin
          select 'COMPROBANTE'        = sc_comprobante,
                 'FECHA'               = sc_fecha_tran,
                 'OFICINA ORIGEN'      = sc_oficina_orig,
                 'AREA ORIGEN'         = sc_area_orig,
                 'DESCRIPCION'         = sc_descripcion,
                 'FECHA DE GRABACION' = sc_fecha_gra,
                 'PERFIL'              = sc_perfil,
                 'TOTAL DEBITOS'       = sc_tot_debito,
                 'TOTAL CREDITOS'      = sc_tot_credito,
                 'OBSERVACIONES'       = sc_observaciones
            from cob_conta_tercero..ct_scomprobante
           where sc_producto   = @i_producto
             and sc_empresa    = @i_empresa
             and sc_fecha_tran = @i_fecha
             and sc_estado     = 'E'
             and sc_comprobante > @i_comprobante
           order by sc_producto,sc_comprobante,sc_fecha_tran  
         
         if @@error <> 0
            begin
               exec cobis..sp_cerror
               @t_debug = @t_debug,
               @t_file  = @t_file,
               @t_from  = @w_sp_name,
               @i_num   = 605082
               return 1
            end

            set rowcount 0
            return 0    
        end                              
end 

return 0
go
