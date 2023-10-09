/************************************************************************/
/*	Archivo: 		compauxi.sp				*/
/*	Stored procedure: 	sp_comp_auxiliar                        */
/*	Base de datos:  	cob_conta                               */
/*	Producto: 		Contabilidad				*/
/*	Disenado por:  		Gonzalo Jaramillo                       */
/*	Fecha de documentacion:	06/Mar/2000				*/
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
/*      Retornar un nuevo secuencial para la fecha, oficina, area       */
/*      y proceso.                                                      */
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*      07/Marz/2000    V.Narvaez       Emision Inicial                 */
/************************************************************************/
use cob_conta
go

set ansi_nulls off
go

if exists (select * from sysobjects where name = 'sp_comp_auxiliar')
	drop proc sp_comp_auxiliar
go

create proc sp_comp_auxiliar(
	@s_ssn			  int          = NULL,
 	@s_user			  login        = NULL,
	@s_sesn			  int          = NULL,
	@s_term			  varchar(30)  = NULL,
	@s_date			  datetime     = NULL,
	@s_srv			  varchar(30)  = NULL,
	@s_lsrv			  varchar(30)  = NULL, 
	@s_rol			  smallint     = NULL,
	@s_ofi			  smallint     = NULL,
	@s_org_err		  char(1)      = NULL,
	@s_error		  int          = NULL,
	@s_sev			  tinyint      = NULL,
	@s_msg			  descripcion  = NULL,
	@s_org			  char(1)      = NULL,
	@t_debug		  char(1)      = 'N',
	@t_file			  varchar(14)  = NULL,
	@t_from			  varchar(32)  = NULL,
	@i_tabla 	      varchar(30)  = NULL, 
	@i_empresa        tinyint,           
	@i_fecha_tran     datetime,         
    @i_comprobante    int,
    @i_formato_fecha  smallint,
    @i_modo           tinyint,
    @i_operacion      char(1),
    @i_asiento        tinyint      = NULL
	)
as

declare 
@w_return       int,
@w_sp_name      varchar(30),
@w_oficina1     smallint,
@w_oficina2     smallint,
@w_area1        smallint,
@w_area2        smallint,
@w_automat1     smallint,
@w_automat2     smallint

/*  Captura nombre de Stored Procedure  */
select  @w_sp_name = 'sp_comp_auxiliar'

if @i_operacion = 'Q'
begin
   set rowcount 20
   if @i_modo = 0 begin
      select sc_oficina_orig, sc_area_orig,
      --sc_consecutivo, substring(sc_descripcion,1,64),
      substring(sc_descripcion,1,64),
      convert(char(12),sc_fecha_tran,@i_formato_fecha),
      sc_mayorizado,
      sc_comprobante,sc_tot_debito,
      sc_tot_credito, sc_tot_debito_me, sc_tot_credito_me,
      substring(of_descripcion,1,40),
      substring(ar_descripcion,1,40), 'co_autorizado',
      substring(sc_digitador,1,15),
      substring(sc_digitador,1,15),
      substring('refe',1,10),
      sc_estado, 'tipo', 
      convert(char(12),sc_fecha_gra,@i_formato_fecha),
      sc_automatico
      from cob_conta_tercero..ct_scomprobante,
           cob_conta..cb_oficina, 
           cob_conta..cb_area
      where sc_fecha_tran = @i_fecha_tran 
      and sc_empresa = @i_empresa 
      and sc_comprobante = @i_comprobante 
      and sc_estado = 'P'
      and of_empresa = @i_empresa
      and of_oficina = sc_oficina_orig 
      and ar_empresa = @i_empresa 
      and ar_area = sc_area_orig

      if @@rowcount = 0 begin
      /* 'Comprobante consultado no existe'*/
      exec cobis..sp_cerror
         @t_debug   = @t_debug,
         @t_file    = @t_file,
         @t_from    = @w_sp_name,
         @i_num	    = 601061
         return 1
      end

      select 
      sa_oficina_dest,sa_area_dest,sa_cuenta,
      sa_tipo_doc,sa_debito,sa_credito,sa_debito_me,
      sa_credito_me,sa_cotizacion,sa_tipo_tran,
      substring(sa_concepto,1,60),sa_moneda,
      en_ced_ruc,en_tipo_ced, sa_documento
      from cob_conta_tercero..ct_sasiento 
           left outer join  cobis..cl_ente on
                 sa_ente = en_ente
      where 	sa_empresa = @i_empresa
      and sa_fecha_tran  = @i_fecha_tran 
      and sa_comprobante = @i_comprobante  
      order by sa_asiento		

   end
   else begin
      select 
      sa_oficina_dest,sa_area_dest,sa_cuenta,
      sa_tipo_doc,sa_debito,sa_credito,sa_debito_me,
      sa_credito_me,sa_cotizacion,sa_tipo_tran,
      substring(sa_concepto,1,60),sa_moneda,
      en_ced_ruc,en_tipo_ced, sa_documento
      from cob_conta_tercero..ct_sasiento 
            left outer join  cobis..cl_ente on
               sa_ente   = en_ente
      where sa_empresa   = @i_empresa 
      and sa_fecha_tran  = @i_fecha_tran 
      and sa_comprobante = @i_comprobante 
      and sa_asiento > @i_asiento
      order by sa_asiento				 

      if @@rowcount = 0 
      begin
         /* 'Comprobante consultado no existe'*/
         exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file	 = @t_file,
         @t_from	 = @w_sp_name,
         @i_num	 = 601150
         return 1
      end
   end
return 0
end
go